--dbo.uspShowSalePriceBySaleID stored procedure

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

--uspTotalsBySalesPerson stored procedure
  
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


