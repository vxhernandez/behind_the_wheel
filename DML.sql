
/***************************************************************************/
/************************ Analytical Questions *****************************/
/***************************************************************************/

--1. What is the total sales amount by dealership?

SELECT 
c.DEALERSHIP_ID, 
d.DEALERSHIP_NAME AS Dealership, 
SUM(s.SALE_PRICE) AS 'Total Sales'
FROM  CARS c 
JOIN SALES s
ON c.CAR_ID = s.CAR_ID 
JOIN DEALERSHIPS d 
ON c.DEALERSHIP_ID = d.DEALERSHIP_ID
GROUP BY c.DEALERSHIP_ID, d.DEALERSHIP_NAME
ORDER BY c.DEALERSHIP_ID;

--2. What is the average sale price of vehicles sold by each dealership?

SELECT 
d.DEALERSHIP_ID, 
d.DEALERSHIP_NAME, 
AVG(s.SALE_PRICE) AS avg_price, 
SUM(s.SALE_PRICE) AS total_sales
FROM  CARS c 
JOIN SALES s 
ON c.CAR_ID = s.CAR_ID 
JOIN DEALERSHIPS d 
ON c.DEALERSHIP_ID = d.DEALERSHIP_ID
GROUP BY d.DEALERSHIP_ID, d.DEALERSHIP_NAME
ORDER BY d.DEALERSHIP_ID;

--3. What is the percentage of vehicles sold by each dealership compared to total sales?

SELECT 
c.DEALERSHIP_ID, 
COUNT(*) AS cars_sold, 
SUM(s.SALE_PRICE) AS dealership_sales, 
SUM(s.SALE_PRICE) / (SELECT SUM(SALE_PRICE) AS sum_price FROM SALES) * 100 AS percentage_of_total_sales
FROM  SALES s 
JOIN CARS c 
ON s.CAR_ID = c.CAR_ID
GROUP BY c.DEALERSHIP_ID;

--4. What is the number of vehicles sold by each salesperson?

SELECT TOP (25) 
CONCAT(sp.FIRST_NAME, ' ', sp.LAST_NAME) AS sales_person, 
COUNT(*) AS total_cars_sold
FROM SALES s
JOIN SALES_PEOPLE sp 
ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
GROUP BY sp.FIRST_NAME, sp.LAST_NAME
ORDER BY total_cars_sold DESC;

--5. What is the total sales generated by each salesperson?

SELECT TOP (25) 
CONCAT(sp.FIRST_NAME, ' ', sp.LAST_NAME) AS sales_person, 
SUM(s.SALE_PRICE) AS total_sales
FROM SALES s
JOIN SALES_PEOPLE sp 
ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
GROUP BY sp.FIRST_NAME, sp.LAST_NAME
ORDER BY total_sales DESC;

--6. What is the average sale price of vehicles sold by each salesperson?

SELECT 
CONCAT(sp.FIRST_NAME, ' ', sp.LAST_NAME) AS sales_person, 
CAST(AVG(s.SALE_PRICE) AS DECIMAL(10,2)) AS avg_price
FROM SALES s
JOIN SALES_PEOPLE sp 
ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
GROUP BY sp.FIRST_NAME, sp.LAST_NAME
ORDER BY avg_price DESC;

--7. What is the percentage of total sales contributed by each salesperson?

SELECT 
CONCAT(sp.FIRST_NAME, ' ', sp.LAST_NAME) AS sales_person, 
CAST((SUM(s.SALE_PRICE) * 100.0 / total_sales.sum_sales)*100 AS DECIMAL(10,2)) AS sales_percentage
FROM SALES AS s
JOIN SALES_PEOPLE AS sp ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
CROSS JOIN (
    SELECT SUM(SALE_PRICE) AS sum_sales FROM SALES
) AS total_sales
GROUP BY sp.FIRST_NAME, sp.LAST_NAME, total_sales.sum_sales
ORDER BY sales_percentage DESC;

--8. What is the total number of vehicles sold in 2022?

SELECT 
MONTH(SALE_DATE) AS month, 
COUNT(*) AS number_of_cars_sold_2022
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

SELECT 
AVG(SALE_PRICE) AS Expr1
FROM  SALES
WHERE (SALE_DATE BETWEEN '2023-01-01' AND '2024-01-01');

--11. What is the percentage of cars sold by color?

SELECT 
c.COLOR, 
COUNT(*) AS count_sold_by_color, 
COUNT(*) * 100.0 / (SELECT COUNT(*) AS cars_count FROM cars) AS percent_sold_by_color
FROM  SALES AS s 
JOIN CARS AS c 
ON s.CAR_ID = c.CAR_ID
GROUP BY c.COLOR
ORDER BY percent_sold_by_color DESC;

--12. What is the percentage of vehicles sold by make?

select 
c.make, 
count(*) as count_sold_by_make,
count(*)  * 100.0/ (select count(*) from cars) percent_sold_by_make
from sales s
left join cars c ON s.car_id = c.CAR_ID
group by c.make
order by count_sold_by_make desc;

--13. What is the total number of cars sold per month in 2023?

SELECT 
MONTH(SALE_DATE) AS sale_month, 
COUNT(*) AS cars_sold
FROM SALES
WHERE (SALE_DATE >= '2023-01-01') AND (SALE_DATE < '2024-01-01')
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month;

--14. What is the total sales by month in 2023?*

SELECT 
MONTH(SALE_DATE) AS sale_month, 
SUM(SALE_PRICE) AS sales_rev_by_month
FROM SALES
WHERE (SALE_DATE >= '2023-01-01') AND (SALE_DATE < '2024-01-01')
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month;
	
--15. What is the average, minimum, and maximum sale price of vehicles sold by month?

SELECT 
MONTH(SALE_DATE) AS sale_month, 
MIN(SALE_PRICE) AS min_price, 
AVG(SALE_PRICE) AS avg_price, 
MAX(SALE_PRICE) AS max_price
FROM  SALES
GROUP BY MONTH(SALE_DATE)
ORDER BY sale_month

--16. Customers who have not purchased a vehicle.

SELECT 
CUSTOMER_ID, 
FIRST_NAME, 
LAST_NAME, 
ADDRESS, 
CITY, 
STATE, 
POSTAL_CODE, 
PRIMARY_PHONE, 
EMAIL_ADDRESS
FROM  CUSTOMERS
WHERE (CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM SALES))

--17. What is the total number of vehicles that have not been sold?

SELECT 
COUNT(*) AS not_sold
FROM  CARS
WHERE (CAR_ID NOT IN(SELECT CAR_ID FROM SALES));

--18. What are the top 5 selling cars?

WITH TopCars AS (
	SELECT 
	c.year,
	c.make,
	c.model,
	COUNT(*) AS num_sales,
	ROW_NUMBER() OVER (PARTITION BY c.year ORDER BY COUNT(*) DESC) AS year_partition
	FROM sales s
	JOIN cars c 
	ON s.car_id = c.car_id
	GROUP BY c.year, c.make, c.model)
SELECT 
year,
make,
model,
num_sales
FROM TopCars
WHERE year IN (2022, 2023) AND year_partition <= 5;

--19. Who were the top 10 sales people in 2023?

WITH top_sales_people AS (
	SELECT 
	SALES_PERSON_ID,
	SUM(SALE_PRICE) AS total_sales
	FROM sales
	WHERE sale_date >= '2023-01-01' AND sale_date < '2024-01-01'
	GROUP BY SALES_PERSON_ID)
SELECT 
tsp.*, CONCAT(sp.last_name, ', ', sp.first_name) AS SalesPersonName
FROM top_sales_people tsp
JOIN SALES_PEOPLE sp 
ON tsp.SALES_PERSON_ID = sp.SALES_PERSON_ID
ORDER BY total_sales DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--20. What are the number of cars sold by each dealership for each car maker?


SELECT * FROM 
(SELECT c.make, c.car_id, d.DEALERSHIP_NAME FROM cars c
join DEALERSHIPS d
on c.DEALERSHIP_ID = d.DEALERSHIP_ID) derived_table
PIVOT(COUNT(car_id) 
FOR make IN (
[Lexus],
[Jeep],
[Bmw],
[Audi],
[Infiniti],
[Acura],
[Cadillac],
[Nissan],
[Chevrolet])) AS pivot_table
ORDER BY DEALERSHIP_name;
	
--21. Are there any salespeople with total sales over 1 million?

SELECT 
sp.SALES_PERSON_ID, 
CONCAT(sp.LAST_NAME, ', ', sp.FIRST_NAME) AS sales_person, 
ts.total_sales
FROM SALES_PEOPLE sp
JOIN (
	SELECT 
	SALES_PERSON_ID, 
	SUM(SALE_PRICE) AS total_sales
	FROM SALES
	GROUP BY SALES_PERSON_ID
	HAVING SUM(SALE_PRICE) > 1000000.00
) ts 
ON sp.SALES_PERSON_ID = ts.SALES_PERSON_ID;

--22. What are the total sales by customer zip code?

SELECT TOP (10) 
c.POSTAL_CODE, 
COUNT(c.CUSTOMER_ID) AS count_customers
FROM  CUSTOMERS AS c 
JOIN SALES AS s 
ON c.CUSTOMER_ID = s.CUSTOMER_ID
GROUP BY c.POSTAL_CODE
ORDER BY count_customers DESC;
	
--23. What is the percentrage of customers with repeat purchases?

SELECT 
COUNT(*) AS total_customers,
SUM(CASE 
	WHEN cars_purchased > 1 THEN 1 
	ELSE 0 
	END) AS multiple_purchases,
SUM(CASE 
	WHEN cars_purchased > 1 THEN 1 
	ELSE 0 
	END) * 100.0 / COUNT(*) AS Percentage
FROM (
	SELECT 
	CUSTOMER_ID,
	COUNT(*) AS cars_purchased
	FROM sales
	GROUP BY CUSTOMER_ID
) AS customer_purchases;
	
--24. What is the total purchase amount by zip code?

select
c.POSTAL_CODE,
sum(s.sale_price) as customer_totals,
sum(s.SALE_PRICE) / (select sum(SALE_PRICE) from sales) * 100 as percent_of_sales
from customers c
join sales s 
on c.customer_id = s.customer_id
group by c.POSTAL_CODE
order by customer_totals DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--25. What is the total sales amount across all dealerships?

SELECT 
SUM(SALE_PRICE) AS total_revenue
FROM SALES;
