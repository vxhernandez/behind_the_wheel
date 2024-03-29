
/***************************************************************************/
/************************ Analytical Questions *****************************/
/***************************************************************************/

--1. What is the total sales amount by dealership?

SELECT a.DEALERSHIP_ID, c.DEALERSHIP_NAME AS Dealership, SUM(b.SALE_PRICE) AS 'Total Sales'
FROM  CARS AS a INNER JOIN
         SALES AS b ON a.CAR_ID = b.CAR_ID INNER JOIN
         DEALERSHIPS AS c ON a.DEALERSHIP_ID = c.DEALERSHIP_ID
GROUP BY a.DEALERSHIP_ID, c.DEALERSHIP_NAME
ORDER BY a.DEALERSHIP_ID;

--2. What is the average sale price of vehicles sold by each dealership?

SELECT d.DEALERSHIP_ID, d.DEALERSHIP_NAME, AVG(s.SALE_PRICE) AS avg_price, SUM(s.SALE_PRICE) AS total_sales
FROM  CARS AS c INNER JOIN
         SALES AS s ON c.CAR_ID = s.CAR_ID INNER JOIN
         DEALERSHIPS AS d ON c.DEALERSHIP_ID = d.DEALERSHIP_ID
GROUP BY d.DEALERSHIP_ID, d.DEALERSHIP_NAME
ORDER BY d.DEALERSHIP_ID;

--3. What is the percentage of vehicles sold by each dealership compared to total sales?

SELECT c.DEALERSHIP_ID, COUNT(*) AS cars_sold, SUM(s.SALE_PRICE) AS dealership_sales, SUM(s.SALE_PRICE) /
             (SELECT SUM(SALE_PRICE) AS sum_price
           FROM   SALES) * 100 AS percentage_of_total_sales
FROM  SALES AS s INNER JOIN
         CARS AS c ON s.CAR_ID = c.CAR_ID
GROUP BY c.DEALERSHIP_ID;

--4. What is the number of vehicles sold by each salesperson?

SELECT TOP (25) { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) } AS sales_person, COUNT(*) AS total_cars_sold
FROM  SALES AS a INNER JOIN
         SALES_PEOPLE AS b ON a.SALES_PERSON_ID = b.SALES_PERSON_ID
GROUP BY { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) }
ORDER BY total_cars_sold DESC;

--5. What is the total sales generated by each salesperson?

SELECT TOP (25) { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) } AS sales_person, SUM(a.SALE_PRICE) AS total_sales
FROM  SALES AS a INNER JOIN
         SALES_PEOPLE AS b ON a.SALES_PERSON_ID = b.SALES_PERSON_ID
GROUP BY { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) }
ORDER BY total_sales DESC;

--6. What is the average sale price of vehicles sold by each salesperson?

SELECT { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) } AS sales_person, CAST(AVG(a.SALE_PRICE) AS decimal(10, 2)) AS avg_price
FROM  SALES AS a INNER JOIN
         SALES_PEOPLE AS b ON a.SALES_PERSON_ID = b.SALES_PERSON_ID
GROUP BY { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) }
ORDER BY avg_price DESC;

--7. What is the percentage of total sales contributed by each salesperson?

SELECT { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) } AS sales_person, SUM(a.SALE_PRICE) /
             (SELECT SUM(SALE_PRICE) AS sum_sales
           FROM   SALES) * 100 AS total_sales
FROM  SALES AS a INNER JOIN
         SALES_PEOPLE AS b ON a.SALES_PERSON_ID = b.SALES_PERSON_ID
GROUP BY { fn CONCAT(b.FIRST_NAME, ' ', b.LAST_NAME) }
ORDER BY total_sales DESC;

--8. What is the total number of vehicles sold in 2022?

SELECT MONTH(SALE_DATE) AS month, COUNT(*) AS number_of_cars_sold_2022
FROM  SALES
WHERE (SALE_DATE >= '2022-01-01') AND (SALE_DATE < '2023-01-01')
GROUP BY MONTH(SALE_DATE)
ORDER BY month;

--9. What are the quarterly sales for 2023 across all dealerships?

SELECT 
    CASE 
        WHEN sale_date >= '2023-01-01' AND sale_date < '2023-04-01' THEN '1st quarter'
        WHEN sale_date >= '2023-04-01' AND sale_date < '2023-07-01' THEN '2nd quarter'
        WHEN sale_date >= '2023-07-01' AND sale_date < '2023-10-01' THEN '3rd quarter'
        WHEN sale_date >= '2023-10-01' AND sale_date < '2024-01-01' THEN '4th quarter'
		else 'Other Years'
    END AS sales_quarter,
    SUM(SALE_PRICE) AS revenue_2023
FROM 
    sales
GROUP BY 
    CASE 
        WHEN sale_date >= '2023-01-01' AND sale_date < '2023-04-01' THEN '1st quarter'
        WHEN sale_date >= '2023-04-01' AND sale_date < '2023-07-01' THEN '2nd quarter'
        WHEN sale_date >= '2023-07-01' AND sale_date < '2023-10-01' THEN '3rd quarter'
        WHEN sale_date >= '2023-10-01' AND sale_date < '2024-01-01' THEN '4th quarter'
		else 'Other Years'
    END
order by revenue_2023;
	
--10. What is the average sale price of vehicles sold in 2023?

SELECT AVG(SALE_PRICE) AS Expr1
FROM  SALES
WHERE (SALE_DATE BETWEEN '2023-01-01' AND '2024-01-01');

--11. What is the percentage of cars sold by color?

SELECT b.COLOR, COUNT(*) AS count_sold_by_color, COUNT(*) * 100.0 /
             (SELECT COUNT(*) AS cars_count
           FROM   CARS) AS percent_sold_by_color
FROM  SALES AS a INNER JOIN
         CARS AS b ON a.CAR_ID = b.CAR_ID
GROUP BY b.COLOR
ORDER BY percent_sold_by_color DESC;

--12. What is the percentage of vehicles sold by make?

select 
b.make, 
count(*) as count_sold_by_make,
count(*)  * 100.0/ (select count(*) from cars) percent_sold_by_make
from sales a
left join cars b ON a.car_id = b.CAR_ID
group by b.make
order by count_sold_by_make desc;

--13. What is the total number of cars sold per month in 2023?

SELECT MONTH(SALE_DATE) AS sale_month, COUNT(*) AS cars_sold
FROM  SALES
WHERE (SALE_DATE >= '2023-01-01') AND (SALE_DATE < '2024-01-01')
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month;

--14. What is the total sales by month in 2023?*

SELECT MONTH(SALE_DATE) AS sale_month, SUM(SALE_PRICE) AS sales_rev_by_month
FROM  SALES
WHERE (SALE_DATE >= '2023-01-01') AND (SALE_DATE < '2024-01-01')
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month;
	
--15. What is the average, minimum, and maximum sale price of vehicles sold by month?

SELECT MONTH(SALE_DATE) AS sale_month, MIN(SALE_PRICE) AS min_price, AVG(SALE_PRICE) AS avg_price, MAX(SALE_PRICE) AS max_price
FROM  SALES
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month

--16. Customers who have not purchased a vehicle.

SELECT CUSTOMER_ID, FIRST_NAME, LAST_NAME, ADDRESS, CITY, STATE, POSTAL_CODE, PRIMARY_PHONE, EMAIL_ADDRESS
FROM  CUSTOMERS
WHERE (CUSTOMER_ID NOT IN
             (SELECT CUSTOMER_ID
           FROM   SALES))

--17. What is the total number of vehicles that have not been sold?

SELECT COUNT(*) AS Expr1
FROM  CARS
WHERE (CAR_ID NOT IN
             (SELECT CAR_ID
           FROM   SALES));

--18. What are the top 5 selling cars?

WITH TopCars AS (
    SELECT 
        c.year,
        c.make,
        c.model,
        COUNT(*) AS num_sales,
        ROW_NUMBER() OVER (PARTITION BY c.year ORDER BY COUNT(*) DESC) AS year_partition
    FROM 
        sales s
    JOIN 
        cars c ON s.car_id = c.car_id
    GROUP BY 
        c.year,
        c.make,
        c.model
)
SELECT 
    year,
    make,
    model,
    num_sales
FROM 
    TopCars
WHERE 
    year IN (2022, 2023)  
    AND year_partition <= 5;

--19. Who were the top 10 sales people in 2023?

WITH sales_people_CTE AS (
    SELECT 
        SALES_PERSON_ID AS SalesPersonId,
        SUM(SALE_PRICE) AS TotalSales
    FROM 
        sales
    WHERE 
        sale_date >= '2023-01-01' AND sale_date < '2024-01-01'
    GROUP BY 
        SALES_PERSON_ID
)
SELECT 
    a.*, CONCAT(b.last_name, ', ', b.first_name) AS SalesPersonName
FROM 
    sales_people_CTE a
JOIN 
    SALES_PEOPLE b ON a.SalesPersonId = b.SALES_PERSON_ID
ORDER BY 
    TotalSales DESC
OFFSET 
    0 ROWS
FETCH NEXT 
    10 ROWS ONLY;

--20. What are the number of cars sold by each dealership for each car maker?

SELECT * FROM (
    SELECT 
    c.make, 
    c.car_id,
	d.DEALERSHIP_NAME
FROM 
    cars c
	join DEALERSHIPS d
		on c.DEALERSHIP_ID = d.DEALERSHIP_ID	
) derived_table

PIVOT(
    COUNT(car_id) 
    FOR make IN (
        [Lexus],
		[Jeep],
		[Bmw],
		[Audi],
		[Infiniti],
		[Acura],
		[Cadillac],
		[Nissan],
		[Chevrolet]
        )
) AS pivot_table
ORDER BY DEALERSHIP_name;
	
--21. Are there any salespeople with total sales over 1 million?

SELECT a.SALES_PERSON_ID, { fn CONCAT(a.LAST_NAME, ', ', a.FIRST_NAME) } AS 'Sales Person', b. 'Total Sales'
FROM  SALES_PEOPLE AS a INNER JOIN
             (SELECT SALES_PERSON_ID, SUM(SALE_PRICE) AS 'Total Sales'
           FROM   SALES
           GROUP BY SALES_PERSON_ID
           HAVING (SUM(SALE_PRICE) > 1000000.00)) AS b ON a.SALES_PERSON_ID = b.SALES_PERSON_ID;

--22. What are the total sales by customer zip code?

SELECT TOP (10) a.POSTAL_CODE, COUNT(a.CUSTOMER_ID) AS count_customers
FROM  CUSTOMERS AS a INNER JOIN
         SALES AS b ON a.CUSTOMER_ID = b.CUSTOMER_ID
GROUP BY a.POSTAL_CODE
ORDER BY count_customers DESC;
	
--23. What is the percentrage of customers with repeat purchases?

SELECT 
    COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN NumCarsPurchased > 1 THEN 1 ELSE 0 END) AS CustomersWithMultiplePurchases,
    (SUM(CASE WHEN NumCarsPurchased > 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS Percentage
FROM (
    SELECT 
        CUSTOMER_ID,
        COUNT(*) AS NumCarsPurchased
    FROM 
        sales
    GROUP BY 
        CUSTOMER_ID
) AS CustomerPurchases;
	
--24. What is the total purchase amount by zip code?

select
a.POSTAL_CODE,
sum(b.sale_price) as customer_totals,
sum(b.SALE_PRICE)/ (select sum(SALE_PRICE) from sales) * 100 as percent_of_sales
from customers a
join sales b on a.customer_id = b.customer_id
group by a.POSTAL_CODE
order by customer_totals DESC
OFFSET 
    0 ROWS
FETCH NEXT 
    10 ROWS ONLY;

--25. What is the total sales amount across all dealerships?

SELECT SUM(SALE_PRICE) AS total_revenue
FROM  SALES;
