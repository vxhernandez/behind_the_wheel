
CREATE TABLE DEALERSHIPS (
    DEALERSHIP_ID INT IDENTITY(1, 1) NOT NULL, -- Primary key
    DEALERSHIP_NAME VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100),
    CITY VARCHAR(100),
    STATE VARCHAR(2),
    POSTAL_CODE VARCHAR(10),
    PRIMARY_PHONE VARCHAR(25),
    CONSTRAINT PK_DEALERSHIP_ID PRIMARY KEY (DEALERSHIP_ID),
    CONSTRAINT CK_DEALER_STATE CHECK (
        LEN(STATE) = 2 AND STATE = UPPER(STATE) AND STATE NOT LIKE '%[^A-Z]%'), -- Checks if state is in uppercase letters
    CONSTRAINT CK_DEALER_POSTAL_CODE CHECK (POSTAL_CODE NOT LIKE '%[^0-9]%') -- Checks if postal code contains only numeric characters
);

CREATE TABLE CUSTOMERS (
    CUSTOMER_ID INT IDENTITY(1, 1) NOT NULL, -- Primary key
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    ADDRESS VARCHAR(100),
    CITY VARCHAR(100),
    STATE VARCHAR(2),
    POSTAL_CODE VARCHAR(10),
    PRIMARY_PHONE VARCHAR(25),
    EMAIL_ADDRESS VARCHAR(320),
    CONSTRAINT PK_CUSTOMER_ID PRIMARY KEY (CUSTOMER_ID),
    CONSTRAINT CK_STATE CHECK (
        LEN(STATE) = 2 AND STATE = UPPER(STATE) AND STATE NOT LIKE '%[^A-Z]%'), -- Checks if state is in uppercase letters
    CONSTRAINT CK_POSTAL_CODE CHECK (POSTAL_CODE NOT LIKE '%[^0-9]%'), -- Checks if postal code contains only numeric characters
    CONSTRAINT CK_EMAIL_ADDRESS CHECK (
        EMAIL_ADDRESS LIKE '%@%' AND EMAIL_ADDRESS NOT LIKE '%@%@%' ) -- Checks if email address is valid
);

CREATE TABLE CARS (
    CAR_ID INT IDENTITY(1, 1) NOT NULL, -- Primary key
    DEALERSHIP_ID INT NOT NULL,
    MAKE VARCHAR(50) NOT NULL,
    MODEL VARCHAR(50) NOT NULL,
    YEAR INT NOT NULL,
    COLOR VARCHAR(50) NOT NULL,
    MSRP DECIMAL(10, 2) NOT NULL,
    VIN VARCHAR(17) NOT NULL,
    CONSTRAINT PK_CAR_ID PRIMARY KEY (CAR_ID),
    CONSTRAINT FK_DEALERSHIP_ID FOREIGN KEY (DEALERSHIP_ID) REFERENCES DEALERSHIPS(DEALERSHIP_ID),
    CONSTRAINT CK_YEAR CHECK (YEAR >= 1000 AND YEAR <= 9999) -- Checks if year is a valid 4-digit number
);

CREATE TABLE SALES_PEOPLE (
    SALES_PERSON_ID INT IDENTITY(1, 1) NOT NULL, -- Primary key
    DEALERSHIP_ID INT NOT NULL, -- Foreign key
    FIRST_NAME VARCHAR(100) NOT NULL,
    LAST_NAME VARCHAR(100) NOT NULL,
    CONSTRAINT PK_SALES_PERSON PRIMARY KEY (SALES_PERSON_ID),
    CONSTRAINT FK_SALES_DEALERSHIP_ID FOREIGN KEY (DEALERSHIP_ID) REFERENCES DEALERSHIPS(DEALERSHIP_ID)
);

CREATE TABLE SALES (
    SALE_ID INT IDENTITY(1, 1) NOT NULL, -- Primary key
    CUSTOMER_ID INT NOT NULL,
    CAR_ID INT NOT NULL,
    SALES_PERSON_ID INT NOT NULL,
    SALE_DATE DATE NOT NULL,
    SALE_PRICE DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_SALE_ID PRIMARY KEY (SALE_ID),
	CONSTRAINT FK_CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT FK_CAR_ID FOREIGN KEY (CAR_ID) REFERENCES CARS(CAR_ID),
    CONSTRAINT FK_SALES_PERSON_ID FOREIGN KEY (SALES_PERSON_ID) REFERENCES SALES_PEOPLE(SALES_PERSON_ID)
);

/*************************************************************************/

--Populates the dealership_id column data in the cars table.

DECLARE @Counter INT 
DECLARE @i INT
SET @Counter=1
WHILE ( @Counter <= 3051)
BEGIN
    SET @i = FLOOR(RAND() * 8 + 1)
    UPDATE staging.cars
    SET dealership_ID = @i
    WHERE car_ID = @Counter
	and dealership_id = 9
    SET @Counter  = @Counter  + 1
END

--Populates the sale_price column in the Sales table.

UPDATE staging.SALES
SET sale_price = (
    SELECT msrp * (1 + (ABS(CHECKSUM(NEWID())) % 8 + -2) / 100.0)
    FROM dbo.cars
    WHERE cars.car_ID = staging.SALES.car_id
);

--Populates the sale_date column in the Sales table.

UPDATE staging.sales
SET sale_date = (
    SELECT DATEADD(day, ABS(CHECKSUM(NEWID())) % (365 * 1), DATEADD(year, year - 1900, '19000101'))
    FROM dbo.cars
    WHERE cars.car_ID = sales.car_id
);


/*************************************************************************/


--Total sales by salesperson View.

CREATE VIEW TotalSalesBySalesperson AS
SELECT
    s.SALES_PERSON_ID,
    sp.LAST_NAME,
    sp.FIRST_NAME,
    SUM(s.SALE_PRICE) AS TotalSales
FROM
    sales s
JOIN
    SALES_PEOPLE sp ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
GROUP BY
    s.SALES_PERSON_ID,
    sp.LAST_NAME,
    sp.FIRST_NAME;

--Sales by dealership View

create view [sales_by_dealership] AS
SELECT 
a.DEALERSHIP_ID, 
c.DEALERSHIP_NAME as Dealership, 
format(SUM(b.SALE_PRICE), 'C2') AS 'Total Sales'
FROM dbo.CARS AS a 
INNER JOIN SALES AS b ON a.CAR_ID = b.CAR_ID 
INNER JOIN DEALERSHIPS AS c ON a.DEALERSHIP_ID = c.DEALERSHIP_ID
GROUP BY a.DEALERSHIP_ID, c.DEALERSHIP_NAME;

--View created from a join to view data from all tables.

create view [all_sales_info] AS
select 
concat(a.first_name, ' ', a.last_name) as customer,
concat(d.first_name, ' ', d.last_name) AS sales_person,
b.SALE_DATE, 
b.SALE_PRICE, 
c.MAKE, 
c.MODEL, 
c.YEAR, 
c.MSRP,
e.DEALERSHIP_NAME
from CUSTOMERS a
join sales b on a.CUSTOMER_ID = b.CUSTOMER_ID
join cars c on b.CAR_ID = c.CAR_ID
join SALES_PEOPLE d on b.SALES_PERSON_ID = d.SALES_PERSON_ID 
join DEALERSHIPS e on c.DEALERSHIP_ID = e.DEALERSHIP_ID;
