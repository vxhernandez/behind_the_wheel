# behind_the_wheel
Auto Dealership Database Project

---
This repository serves as a showcase of my experience in database management, analysis techniques and demonstrates my end-to-end skills in handling the database development lifecycle. 

### Key Features:

- **Database Design:** Designed a database schema and created tables to store data.
- **Data Population:** Populated the database with data and ensured data integrity.
- **Data Cleansing and ETL:** Conducted data cleaning and ETL (Extract, Transform, Load) processes to prepare the data for analysis.
- **Exploratory Data Analysis (EDA):** Analyzed the data to identify patterns, trends, and insights that drive decision-making.
- **Tools and Technologies:**
    - Notion.io for requirements analysis
    - Lucidchart for designing the ERD and ETL Diagrams
    - SSIS/Visual Studios for the ETL processes
    - SQL Server for database creation/storage
    - Excel for data cleansing
    - Tableau for developing dashboard

### Roadmap for the project:

By following this roadmap, I was able to systematically progress through each stage of the project, ensuring thorough analysis and effective presentation of insights derived from the car dealership database.

1. **Choose a Topic and Define Objectives**
    - This database project focuses on car dealership sales with the objective to design and implement an efficient database system tailored to Value Voyage Auto’s needs. Through this project, I aim to deliver a valuable asset empowering the car dealership to enhance sales strategies, customer satisfaction, and overall business performance.

2. **Identify Analytical Questions**
    - In selecting 25 analytical questions for the car dealership database project, I aim to delve into various aspects of sales, customer behavior, and employee performance. By addressing these analytical questions through data analysis and interpretation, I aim to gain valuable insights that can inform strategic decision-making, enhance operational efficiency, and drive business growth.

3. **Design Entity Relationship Diagram (ERD)**
    - The creation of a Entity Relationship Diagram (ERD) is crucial for visualizing the relationships between entities within the car dealership database. The ERD serves as a blueprint that illustrates the structure of the database, including the various entities, their attributes, and the relationships between them. In designing the ERD for the auto dealership database, I identify the primary entities involved: cars, customers, sales_people, sales and dealerships. Relationships between entities are depicted by lines connecting them, with cardinality indicators to specify the nature of the relationship (one-to-one, one-to-many, or many-to-many).
    - For example, the cars entity has attributes such as car_id, make, model, year, price, and color. And has relationships with the sales entity (indicating the sale of a specific car) and dealerships (denoting the dealership that sells the car). The customers entity includes attributes customer_id, first_name, last_name address, city, state, postal_code, email and primary_phone and will be linked to the sales entity to record customer purchases. The sales_people entity contains attributes such as sales_person_id, first_name and last_name and is associated with the sales entity to track sales made by each salesperson.
    - The ERD, ensures all relevant entities and their relationships are accurately represented, providing a clear and comprehensive overview of the database structure.
    - [ERD Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/entity_relationship_diagram.jpeg)

4. **Database Design (DDL)**
    - In the database design phase, I defined the database schema and created the necessary tables using Data Definition Language (DDL). This involved translating the conceptual ERD into a concrete database structure by specifying the attributes and data types for each table, as well as defining primary keys, foreign keys and constraints.
    - In the DDL statements, I utilized SQL commands such as CREATE TABLE and ALTER TABLE to implement the database schema. I ensured data integrity by defining constraints such as NOT NULL, CHECK, PRIMARY KEY, and FOREIGN KEY constraints to enforce data validation rules and maintain referential integrity.
    - Throughout the database design process, I followed best practices to optimize performance, minimize redundancy, and ensure scalability and flexibility for future enhancements. By completing the DDL phase, I laid the foundation for the subsequent stages of data population, manipulation, and analysis in the car dealership database project.
    - [DDL](https://github.com/vxhernandez/behind_the_wheel/blob/main/DDL.sql)

5. **Design Data Pipeline Diagram**
    - In the data pipeline design phase, I visualized the end-to-end data flow and pipeline architecture for the Extract, Transform, Load (ETL) and Extract, Load, Transform (ELT) processes. The pipeline encompasses various data sources, cleansing techniques, and database operations to prepare the data for analysis and visualization.
    - [ETL Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/data_pipeline_diagram.jpeg)

6. **Data Acquisition and ETL/ELT**
    - Dealership Table: Manually inserted data for 8 dealerships using INSERT statements:
        - ```sql

          INSERT INTO DEALERSHIPS (DEALERSHIP_NAME, ADDRESS, CITY, STATE, POSTAL_CODE, PRIMARY_PHONE)
          VALUES
            ('Value Voyage Auto-Courtland', '15423 I-10', 'Houston', 'TX', '78249', '210-441-7785'),
            ('Value Voyage Auto-North', '6907 Southwest Fwy', 'Houston', 'TX', '77090', '(281) 209-1333'),
            ('Value Voyage Auto-Northwest', '19500 Northwest Fwy', 'Houston', 'TX', '77065', '(713) 774-3400'),
            ('Value Voyage Auto-CincoRanch', '19546 US-290 Frontage Rd.', 'Houston', 'TX', '77041', '(281) 970-6690'),
            ('Value Voyage Auto-Sugarland', '4200 Elkins Rd.', 'Houston', 'TX', '77479', '281-448-7744'),
            ('Value Voyage Auto-SouthHouston', '6909 Southwest Fwy', 'Houston', 'TX', '77074', NULL),
            ('Value Voyage Auto-BaylandPark', '13100 Gulf Fwy', 'Houston', 'TX', '77034', '(281) 481-4299'),
            ('Value Voyage Auto-Katy', '21636 Katy Fwy', 'Houston', 'TX', '77449', '(281) 994-6200');

          ```
    - Customers Table: Utilized Mockaroo website to generate customer data and performed a direct flat file import into the customers table using SQL Server Import Wizard. Mockaroo is a website that generates realistic-looking data for testing, development purposes and can be used to populate databases.
    - <img src="https://github.com/vxhernandez/behind_the_wheel/assets/109702488/b734f826-8b88-49d8-b23f-ef58a6718387" width="800" height="600">
    - Cars Table: Populated the cars table from Kaggle dataset containing make, model, year, and MSRP columns. Connected to SSIS using Visual Studio, created an SSIS package to remove used cars by implementing a Data Flow Task with a conditional split to retain only "new car" sales data, aligning with the database focus.
    - <img src="https://github.com/vxhernandez/behind_the_wheel/assets/109702488/d8b91f67-d302-48aa-b632-f35272f8bd36" width="800" height="600">
    - Manual Data Creation: To populate the dealership_id, sale_price, and sale_date where data was unavailable, SQL scripts were used to generate synthetic data. This SQL code creates a loop that iterates over the number of records in the cars table. Within each iteration, it generates a random integer between 1 and 8 and assigns it to the variable @i. Then, it updates the dealership_id column in the staging.cars table, setting it to the value of @i, but only for rows where car_id equals the current value of @Counter and dealership_id is equal to 9. Finally, it increments the counter @Counter by 1 to move to the next iteration. Essentially, it's assigning random dealership IDs to a subset of cars in the staging table, specifically for each dealership_id, in this case 9.
         
    ```sql
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
            
    ```
    - This code updates the sale_price column in the staging.SALES table. It sets the sale_price to a randomly adjusted value based on the msrp of corresponding cars from the staging.cars table. The adjustment is calculated using a formula that involves generating a random number between -10% and +10% of the msrp using ABS(CHECKSUM(NEWID())) % 10 + -10. Each row in the staging.SALES table is updated based on the car_id, matching it with the car_ID in the staging.cars table to determine the msrp value for the calculation.

    ```sql

        UPDATE staging.SALES
        SET sale_price = (
            SELECT msrp * (1 + (ABS(CHECKSUM(NEWID())) % 10 + -10) / 100.0)
            FROM staging.cars
            WHERE cars.car_ID = staging.SALES.car_id);
        
    ```
    - The SQL code below updates the sale_date column in the staging.sales table. It sets the sale_date to a randomly generated date within the past year. The random date is calculated by adding a random number of days (up to 365 days) to a base date. The base date is calculated as the value of the year column in the dbo.cars table, subtracting 1900 years, and adding it to January 1st, 1900. Each row in the staging.sales table is updated based on the car_id, matching it with the car_ID in the dbo.cars table to determine the corresponding year value for the calculation.

    ```sql
        
        UPDATE staging.sales
        SET sale_date = (
            SELECT DATEADD(day, ABS(CHECKSUM(NEWID())) % (365 * 1), DATEADD(year, year - 1900, '19000101'))
            FROM dbo.cars
            WHERE cars.car_ID = sales.car_id);
        
     ```
    - Staging Database: All aforementioned processes were performed within a staging database.
    - Migration to Target Database: Once data was cleansed and transformed in the staging database, it was migrated to the target database for analysis using SQL queries.

7. **Normalization and Optimization and ELT**
    - During the normalization and optimization phase, in the database structure to identify any normalization issues and implemented optimizations to enhance efficiency and performance.
    - I reviewed the database schema to ensure compliance with normalization principles, aiming to eliminate redundancy and improve data integrity. I reviewed the tables for any instances of data duplication or dependency anomalies, such as insertion, update, and deletion anomalies.

8. **Perform SQL Analysis**
    - Utilized various SQL programming techniques including GROUP BY, HAVING, window functions (PARTITION BY), Common Table Expressions (CTEs), and Pivot tables to effectively address and answer all 25 analytical questions.
    - [DML](https://github.com/vxhernandez/behind_the_wheel/blob/main/DML.sql)

11. **Create Tableau Visualizations**
    - The Value Voyage Auto database Dashboard offers a visualization and analysis of car dealership data. This dashboard provides a comprehensive overview of sales performance, customer insights, and dealership metrics. Value Voyage Auto employees can delve into various aspects of the dataset, such as total sales by dealership, top-selling vehicle models, and customer demographics. It tracks sales trends over time and compares performance across different dealership locations.
    - [Value Voyage Dealership Dashboard](https://public.tableau.com/views/BehindtheWheel/ValueVoyageAutoDashboard?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)
      
    - ![tableau_viz](https://github.com/vxhernandez/behind_the_wheel/assets/109702488/5e971ff7-5f0d-42ff-8413-29abc679715a)

13. **Lessons Learned**
    - Recognizing the time constraints associated with creating data, I've learned the importance of leveraging online datasets. This approach not only saves time but also provides diverse and real-world data for analysis.
    - To deepen analysis and extract richer insights, I need to augment existing data with additional attributes. This will enhance the granularity of analysis and enable more comprehensive understanding of each entity.

14. **Next Steps**
    - Gather feedback from colleagues and experts in the field to pinpoint avenues for improvement.
    - Develop Advanced SQL Programming to add value to the database and deepen understanding of stored procedures, triggers, views, and function development.
    - Delve into query execution plans to identify bottlenecks and optimize performance effectively.
    - Understand the impact of indexes on query performance and learn to leverage them efficiently to tune queries.
    - Review and rewrite queries to maximize efficiency, minimize resource consumption, and enhance overall database performance.

### PART II - Advanced SQL Programming

In part II, I implemented advanced SQL programming concepts to enhance data analysis and functionality to the database. Views were implemented to offer simplified data access, triggers were utilized to enforce data integrity and maintain a detailed audit trail of changes, and stored procedures were employed to encapsulate frequently executed queries, promoting modularity and improving performance.

**Views**
[VIEWS - link to code](https://github.com/vxhernandez/behind_the_wheel/blob/main/Views.sql)
1. The salesperson_totals View, calculates the total sales made by each salesperson. It joins the sales table with the sales_people table on the sales_person_id column to retrieve the salespersons first name and last name. Then, it aggregates the sales prices using the SUM() function, grouped by the salespersons ID, last name, and first name.

    <img src="https://github.com/vxhernandez/behind_the_wheel/assets/109702488/6115d7c2-81a1-4c80-b7a3-2a85cd65381d" width="400" height="300">

3. The sales_by_dealership View, provides a summary of sales by dealership. It joins the cars, sales, and dealerships tables to gather information about each sale, including the dealership_id, dealership_name, and total sales. The SUM() function is used to aggregate the sale_price, and the results are formatted as currency using the FORMAT() function. 

4. The car_inventory View, presents the list of cars from the 'cars' table along with their respective statuses. It combines two SELECT statements using UNION ALL: the first part retrieves cars that are currently in inventory by filtering out those whose IDs do not appear in the sales table, labeling them as 'In Inventory'. The second part retrieves sold cars by including only those whose IDs appear in the sales table, labeled as 'Sold'. The resulting view provides a consolidated overview of car inventory status.

**Triggers**

1. The CustomerChangeLog trigger on the customers table logs inserts into the customers table by capturing the inserted data and adding a row to the customer_audit table, which serves as an audit log.
   First, it creates the customer_audit table with columns to store the audit information such as AuditID, CustomerID, CustomerFN, CustomerLN, and TimeAdded.
   Then, it creates the trigger CustomerChangeLog, specifying that it should execute AFTER INSERT on the customers table. Inside the trigger, it inserts the relevant information (CustomerID, CustomerFN, CustomerLN, and current timestamp) into the customer_audit table using the INSERTED pseudo-table to access the newly inserted rows.
   After setting up the trigger, the script retrieves existing data from the CUSTOMERS table to demonstrate its contents and then queries the customer_audit table to display the audit log entries. Finally, it retrieves all triggers in the database using the sys.triggers system view.

3. The SalesChangeLogTrigger on the sales table is set to fire for INSERT, UPDATE, or DELETE operation.
   The trigger checks if there are any rows affected by the operation in the "inserted" pseudo table. If so, it further checks if there are rows affected by the operation in the "deleted" pseudo table. Based on these checks, it inserts records into the SalesChangeLog table to log the changes made to the sales data.

   - For an UPDATE operation, it logs the changes made to the affected rows by selecting data from the "inserted" table and marks the action as 'UPDATE'.
   - For an INSERT operation, it logs the newly inserted rows by selecting data from the "inserted" table and marks the action as 'INSERT'.
   - For a DELETE operation, it logs the deleted rows by selecting data from the "deleted" table and marks the action as 'DELETE'.
   
   The logged information includes SaleID, CustomerID, CarId, SalesPersonID, SalePrice, SaleDate, the action performed, and a timestamp indicating when the change occurred.

[TRIGGERS - link to code](https://github.com/vxhernandez/behind_the_wheel/blob/main/Triggers.sql)

**Stored Procedures**  

1. The first stored procedure, uspShowSalePriceBySaleID, retrieves specific information about a sale based on the provided sale_id parameter. It selects the sale ID, sale date, sale price (formatted as currency), and car ID from the SALES table where the sale_id matches the input parameter. This procedure allows users to quickly access details of a specific sale by providing the sale ID.

2. The uspTotalsBySalesPerson stored procedure, retrieves sales information for a particular salesperson identified by their sales_person_id. It displays details such as the salesperson's ID, dealership, vehicle make and model, vehicle color, MSRP, sale price (formatted as currency), total sales (formatted as currency), and date of sale. The sales information is filtered based on the provided sales_person_id parameter, showing only the sales attributed to that salesperson.  It also allows users to input either the sales_person_id or the last_name of the salesperson. It includes default values of NULL for both parameters, enabling users to optionally provide either one or both parameters. If both parameters are NULL, the procedure raises an error and displays a custom error message, preventing accidental retrieval of data for all salespeople. This provides more flexibility in querying sales information based on either the salesperson ID or their last name.

[STORED PROCEDURES - link to code](https://github.com/vxhernandez/behind_the_wheel/blob/main/stored_procedures.sql) 

