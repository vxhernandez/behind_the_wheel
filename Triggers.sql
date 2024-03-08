
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
