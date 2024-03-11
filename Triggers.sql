
--CustomerChangeLog Trigger

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

---SalesChangeLogTrigger Trigger

CREATE OR ALTER TRIGGER dbo.SalesChangeLogTrigger
ON dbo.sales
FOR INSERT, UPDATE, DELETE
AS
IF EXISTS (SELECT 0 FROM inserted)
BEGIN 
	IF EXISTS (SELECT 0 FROM deleted)
    BEGIN
        INSERT INTO staging.SalesChangeLog(
            SaleID,
			customerID,
            CarId,
            SalesPersonID,
            SalePrice,
            SaleDate,
            Action,
            TimeStamp
        )
        SELECT 
            SALE_ID,
			CUSTOMER_ID,
            CAR_ID,
            SALES_PERSON_ID,
            SALE_PRICE,
            SALE_DATE,
            'UPDATE',
            GETDATE()
        FROM
            INSERTED;
	END ELSE
    BEGIN
            INSERT INTO staging.SalesChangeLog(
                SaleID,
				customerID,
                CarId,
                SalesPersonID,
                SalePrice,
                SaleDate,
                Action,
                TimeStamp
            )
            SELECT 
                SALE_ID,
				CUSTOMER_ID,
                CAR_ID,
                SALES_PERSON_ID,
                SALE_PRICE,
                SALE_DATE,
                'INSERT',
                GETDATE()
            FROM
                INSERTED;
	END
END ELSE
BEGIN
            INSERT INTO staging.SalesChangeLog(
                SaleID,
				customerID,
                CarId,
                SalesPersonID,
                SalePrice,
                SaleDate,
                Action,
                TimeStamp
            )
            SELECT 
                SALE_ID,
				CUSTOMER_ID,
                CAR_ID,
                SALES_PERSON_ID,
                SALE_PRICE,
                SALE_DATE,
                'DELETE',
                GETDATE()
            FROM
                DELETED;
END;
