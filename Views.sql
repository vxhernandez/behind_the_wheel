--salesperson_totals View

CREATE or ALTER VIEW salesperson_totals AS
SELECT
    s.SALES_PERSON_ID,
    sp.LAST_NAME,
    sp.FIRST_NAME,
    SUM(s.SALE_PRICE) AS 'Total Sales'
FROM
    sales s
JOIN
    SALES_PEOPLE sp ON s.SALES_PERSON_ID = sp.SALES_PERSON_ID
GROUP BY
    s.SALES_PERSON_ID,
    sp.LAST_NAME,
    sp.FIRST_NAME;

--sales_by_dealership View

CREATE
OR ALTER VIEW sales_by_dealership AS
SELECT     a.dealership_id,
           c.dealership_name               AS Dealership,
           Format(Sum(b.sale_price), 'C2') AS 'Total Sales'
FROM       dbo.cars                        AS a
INNER JOIN sales                           AS b
ON         a.car_id = b.car_id
INNER JOIN dealerships AS c
ON         a.dealership_id = c.dealership_id
GROUP BY   a.dealership_id,
           c.dealership_name;

--car_inventory View

CREATE
OR ALTER VIEW car_inventory AS
SELECT car_id,
       make,
       model,
       color,
       msrp,
       'In Inventory' AS 'Car Status'
FROM   cars
WHERE  car_id NOT IN
       (
              SELECT car_id
              FROM   sales)
UNION ALL
SELECT car_id,
       make,
       model,
       color,
       msrp,
       'Sold' AS 'Car Status'
FROM   cars
WHERE  car_id IN
       (
              SELECT car_id
              FROM   sales);
