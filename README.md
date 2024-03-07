# behind_the_wheel
Car Dealership Database Project

---
This repository serves as a showcase of my experience in database management, analysis techniques and demonstrates my end-to-end skills in handling the database development lifecycle. 

### Key Features:

- **Database Design:** Designed a robust database schema and created tables to efficiently store data.
- **Data Population:** Populated the database with relevant data and ensured data integrity.
- **Data Cleansing and ETL:** Conducted data cleaning and ETL (Extract, Transform, Load) processes to prepare the data for analysis.
- **Exploratory Data Analysis (EDA):** Analyzed the data to identify patterns, trends, and insights that drive decision-making.
- **Analytical Questions:** Defined and answered pertinent analytical questions to uncover actionable insights.
- **Tools and Technologies:**
    - Notion.io for requirements analysis
    - Lucidchart for designing the ERD and ETL Diagrams
    - SSIS/Visual Studios for the ETL processes
    - SQL Server for database creation
    - Excel for data cleansing
    - Tableau for developing dashboard

### Goals:

Follow the sequential steps outlined in the roadmap to enhance my proficiency as an SQL Developer.

### Links:

- [ERD Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/entity_relationship_diagram.jpeg)
- [ETL Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/Data%20Pipeline%20Diagram.jpeg)
- Data used: [Kaggle Dataset](https://www.kaggle.com/datasets/ahmettalhabektas/new-york-cars-big-data-2023)  [Mockaroo](https://www.mockaroo.com/)
- [DDL](https://github.com/vxhernandez/behind_the_wheel/blob/main/DDL.sql)
- [DML](https://github.com/vxhernandez/behind_the_wheel/blob/main/DML.sql)
- [Value Voyage Dealership Dashboard](https://public.tableau.com/views/BehindtheWheel/Dashboard1?:language=en-US&publish=yes&:sid=&:display_count=n&:origin=viz_share_link)

### Roadmap for the project:

By following this roadmap, I was able to systematically progress through each stage of the project, ensuring thorough analysis and effective presentation of insights derived from the car dealership database.

1. **Choose a Topic and Define Objectives**
    - This database project focuses on car dealership sales with the objective to design and implement an efficient database system tailored to Value Voyage Auto’s needs. Through this project, I aim to deliver a valuable asset empowering the car dealership to enhance sales strategies, customer satisfaction, and overall business performance.

2. **Identify Analytical Questions**
    - In selecting 25 analytical questions for the car dealership database project, I aim to delve into various aspects of sales, customer behavior, and employee performance. By addressing these analytical questions through data analysis and interpretation, I aim to gain valuable insights that can inform strategic decision-making, enhance operational efficiency, and drive business growth.

3. **Design Entity Relationship Diagram (ERD)**
    - The creation of a Entity Relationship Diagram (ERD) is crucial for visualizing the relationships between entities within the car dealership database. The ERD serves as a blueprint that illustrates the structure of the database, including the various entities, their attributes, and the relationships between them.
    - In designing the ERD for the car dealership database, I identify the primary entities involved, such as "Cars," "Customers," "Sales," "Salespeople," "Dealerships". Relationships between entities are depicted by lines connecting them, with cardinality indicators to specify the nature of the relationship (one-to-one, one-to-many, or many-to-many).
    - For example, the "Cars" entity has attributes such as "car_id," "make," "model," "year," "price," and "color." And has relationships with other entities such as "Sales" (indicating the sale of a specific car) and "Dealerships" (denoting the dealership that sells the car).
    - The "Customers" includes attributes "customer_ID," "first_name," "last_name," "email," and "primary_phone," and will be linked to the "Sales" entity to record customer purchases. The "Salespeople" entity will contain attributes such as "sales_person_id," "first_name," "last_ame," and is associated with the "Sales" entity to track sales made by each salesperson.
    - The ERD, ensures all relevant entities and their relationships are accurately represented, providing a clear and comprehensive overview of the database structure.
    - [ERD Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/entity_relationship_diagram.jpeg)

4. **Database Design (DDL)**
    - In the database design phase, I defined the database schema and created the necessary tables using Data Definition Language (DDL). This involved translating the conceptual ERD into a concrete database structure by specifying the attributes and data types for each table, as well as defining primary keys, foreign keys and constraints.
    - In the DDL statements, I utilized SQL commands such as CREATE TABLE and ALTER TABLE to implement the database schema. I ensured data integrity by defining constraints such as NOT NULL, CHECK, PRIMARY KEY, and FOREIGN KEY constraints to enforce data validation rules and maintain referential integrity.
    - Throughout the database design process, I followed best practices to optimize performance, minimize redundancy, and ensure scalability and flexibility for future enhancements. By completing the DDL phase, I laid the foundation for the subsequent stages of data population, manipulation, and analysis in the car dealership database project.
    - [DDL](https://github.com/vxhernandez/behind_the_wheel/blob/main/DDL.sql)

5. **Design Data Pipeline Diagram**
    - In the data pipeline design phase, I visualized the end-to-end data flow and pipeline architecture for the Extract, Transform, Load (ETL) and Extract, Load, Transform (ELT) processes. The pipeline encompasses various data sources, cleansing techniques, and database operations to prepare the data for analysis and visualization.
    - [ETL Diagram](https://github.com/vxhernandez/behind_the_wheel/blob/main/Data%20Pipeline%20Diagram.jpeg)

6. **Data Acquisition for ETL/ELT**
    - Gather suitable datasets for Extract, Transform, and Load (ETL) processes and or Extract Load Transform (ELT)
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
         - ![mockaroo_screenshot](https://github.com/vxhernandez/behind_the_wheel/assets/109702488/967c8e34-ba05-41c8-8051-1993e158fae0)

         - Cars Table: Populated the cars table from Kaggle dataset containing make, model, year, and MSRP columns. Connected to SSIS using Visual Studio, created an SSIS package to remove used cars by implementing a Data Flow Task with a conditional split to retain only "new car" sales data, aligning with the database focus. 






9. **Perform SQL Analysis**
    - Answer the analytical questions using SQL programming techniques.

10. **Advanced SQL Programming**
    - Implement advanced SQL programming concepts to enhance data analysis and manipulation.

11. **Create Tableau Visualizations**
    - Develop interactive and informative visualizations in Tableau to present the analyzed data.

12. **GitHub Project Portfolio**
    - Add the completed project, including documentation, code, and visualizations, to my GitHub portfolio for showcase and sharing.

13. **Lessons Learned**
    - What insights have you gained from your involvement in this project?
    - How would you approach this project differently in hindsight?
    - Pinpoint areas in need of enhancement or refinement.

14. **Next Steps**
    - Gather feedback from colleagues and experts in the field to pinpoint avenues for improvement.
    - Enumerate additional tasks or features that could enrich the SQL experience within the project.

- [T-SQL](https://github.com/vxhernandez/behind_the_wheel/blob/main/T-SQL.sql)
