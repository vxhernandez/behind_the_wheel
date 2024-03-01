/***************************************************************/
--Triggers
/***************************************************************/

--This trigger logs inserts into the Customers table and adds a row into a the customer_audit table.
--create an audit table
CREATE TABLE dbo.customer_audit (
AuditID INT IDENTITY(1, 1) PRIMARY KEY,
CustomerID int,
CustomerFN nvarchar(100),
CustomerLN nvarchar(100),
TimeAdded datetime2
);
GO

--create a trigger that logs inserts to the customer table
CREATE or ALTER TRIGGER dbo.CustomerChangeLog
ON dbo.customers
AFTER INSERT
AS
BEGIN
    INSERT INTO dbo.customer_audit ( 
        CustomerID,
        CustomerFN,
        CustomerLN,
        TimeAdded
    )
    SELECT 
        CUSTOMER_ID,
        FIRST_NAME,
        LAST_NAME,
        GETDATE()
    FROM
        INSERTED;
END;
GO

--view existing data in customers table
SELECT * FROM dbo.CUSTOMERS
ORDER BY customer_id DESC;
GO

--to see the changes in the audit log
SELECT * from customer_audit;

--to see all triggers
SELECT * 
FROM sys.triggers;


/***************************************************************/
--Stored Procedures
/***************************************************************/

--Allows the user to enter a sale_id, and see the sale_price, sale_date and car_id from the Sales table by entering sale_id parameter.

CREATE or alter PROCEDURE dbo.uspShowSalePriceBySaleID
    @paramSaleID int
AS
SELECT	
dbo.SALES.SALE_ID AS 'Sale ID',
dbo.SALES.SALE_DATE 'Date of Sale',
format(dbo.SALES.SALE_PRICE, 'C2') AS 'Sold For',
dbo.SALES.CAR_ID AS 'Car Id'

FROM dbo.SALES 
		
WHERE dbo.SALES.SALE_ID = @paramSaleID
;
GO

-- execute the stored procedure with various parameters
EXEC dbo.uspShowSalePriceBySaleID 22;
GO
EXEC dbo.uspShowSalePriceBySaleID 172;
GO

/***************************************************************/

--Takes sales_person_id and displays their total sales and vehicle information.

CREATE OR ALTER PROCEDURE dbo.uspTotalsBySalesPerson
@paramSalesPersonId int
As

SELECT 
    b.sales_person_id AS 'Sales Person ID',
	a.DEALERSHIP_ID as 'Dealership',
    a.make AS 'Vehicle Make', 
    a.model AS 'Vehicle Model',
    COALESCE(a.color, 'Color Not Listed') AS 'Vehicle Color',
    FORMAT(a.msrp, 'C2') AS 'Vehicle MSRP',
    FORMAT(b.sale_price, 'C2') AS 'Sale Price',
    FORMAT(SUM(b.sale_price) OVER (PARTITION BY b.sales_person_id ORDER BY b.sale_date), 'C2') AS 'Sales Total',
    b.SALE_DATE AS 'Date of Sale'
FROM   
    cars a
JOIN 
    sales b ON a.car_id = b.car_id
WHERE 
    a.CAR_ID IN (SELECT car_ID FROM sales)
    AND SALES_PERSON_ID = @paramSalesPersonId
ORDER BY 
    b.sale_date;


EXEC dbo.uspTotalsBySalesPerson 356;
GO

/***************************************************************/

/*

Updated the previous stored procedure that allows the user to enter either the sales_person_id or the last_name. 
if both parameters are NULL, the procedure will display an error message. This prevents the user from
not entering a parameter which would then display information for all the sales people.

*/

CREATE OR ALTER PROCEDURE dbo.uspTotalsBySalesPerson
--Both @paramSalesPersonId and @paramSalesPersonLN parameters are declared with default values of NULL, allowing them to be optionally provided.
    @paramSalesPersonId INT = NULL,
    @paramSalesPersonLN VARCHAR(100) = NULL
AS
BEGIN

  -- Check if both parameters are NULL
    IF @paramSalesPersonId IS NULL AND @paramSalesPersonLN IS NULL
    BEGIN
        -- Raises an error and returns a custom error message
        RAISERROR('At least one parameter must be provided.', 16, 1);
        RETURN;
    END;

    -- Execute the main query using the provided sales_person_id parameter or last_name
    SELECT 
        b.sales_person_id AS 'Sales Person ID',
		CONCAT(c.FIRST_NAME, ' ', c.LAST_NAME) AS 'Sales Person',
        a.DEALERSHIP_ID AS 'Dealership',
        a.make AS 'Vehicle Make', 
        a.model AS 'Vehicle Model',
        COALESCE(a.color, 'Color Not Listed') AS 'Vehicle Color',
        FORMAT(a.msrp, 'C2') AS 'Vehicle MSRP',
        FORMAT(b.sale_price, 'C2') AS 'Sale Price',
        FORMAT(SUM(b.sale_price) OVER (PARTITION BY b.sales_person_id ORDER BY b.sale_date), 'C2') AS 'Sales Total',
        b.SALE_DATE AS 'Date of Sale'
    FROM   
        cars a
    JOIN 
        sales b ON a.car_id = b.car_id
    JOIN
        SALES_PEOPLE c ON b.SALES_PERSON_ID = c.SALES_PERSON_ID
    WHERE 
    a.CAR_ID IN (SELECT car_ID FROM sales)
    AND (@paramSalesPersonId IS NULL OR b.SALES_PERSON_ID = @paramSalesPersonId)
    AND (@paramSalesPersonLN IS NULL OR c.last_name = @paramSalesPersonLN)
    ORDER BY 
        b.sale_date;
END;


EXEC dbo.uspTotalsBySalesPerson @paramSalesPersonId = 75;
GO
EXEC dbo.uspTotalsBySalesPerson @paramSalesPersonLN = 'Nowick';
GO
