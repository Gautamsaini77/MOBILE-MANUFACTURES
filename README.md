# MOBILE-MANUFACTURES
📝 Project Description:
This project involves performing advanced SQL-based data analysis on a consumer electronics retail database. The data warehouse follows a star schema, with fact and dimension tables, and covers customer complaints, transactions, manufacturers, and product models across locations and dates.

The objective of the project is to derive key business insights using complex SQL queries — such as identifying top-selling models, analyzing customer behavior, tracking sales trends, and comparing manufacturers' performance over multiple years.

🧾 Data Structure Overview:
Fact Table:

FACT_TRANSACTIONS: Contains detailed records of all transactions (sales), including product model, customer, location, quantity, total price, and date.

Dimension Tables:

DIM_CUSTOMER: Customer details

DIM_DATE: Calendar and time-related data

DIM_LOCATION: Geographic data like state, city, country

DIM_MANUFACTURER: Manufacturer-level information

DIM_MODEL: Product-level information including price, model name, and manufacturer

🎯 Key Business Questions & Insights (SQL Queries):
Query No.	Description
Q1	Retrieve all US states with transactions after 2005
Q2	Identify the US state with the highest quantity of Samsung sales
Q3	Total number of transactions by model and location (zipcode + state)
Q4	Model with the lowest unit price
Q5	Top 5 manufacturers (by quantity) and their average model prices
Q6	Customers who spent more than ₹500 on average in 2009
Q7	Models that were top 5 in sales quantity across 2008, 2009, and 2010
Q8	Second top-selling manufacturer by total sales for each year (2009, 2010)
Q9	Manufacturers who sold in 2010 but not in 2009
Q10	Year-on-year % change in total spend for top 10 customers (with lag function)

🧠 Skills Demonstrated:
Advanced SQL queries

Data aggregation (GROUP BY, SUM, AVG, COUNT)

Subqueries and common table expressions (CTEs)

Window functions (LAG(), OVER())

Set operations (INTERSECT, EXCEPT, UNION)

Date-based filtering and year-wise analysis

Business-focused analytical thinking

📊 Sample Insights:
California had the highest number of Samsung product purchases.

Some models consistently ranked in the top 5 across multiple years.

Certain manufacturers entered the market in 2010 that weren't present in 2009.

Top customers saw over 20–30% yearly growth in spending.

💼 Use Case for Portfolio:
This project is an excellent demonstration of:

Data Warehousing Concepts (Star Schema)

ETL-readiness & Dimensional Modeling Understanding

SQL Reporting for Business Intelligence

Customer Segmentation & Trend Analysis

🚀 How to Run:
You can recreate this analysis by:

Loading the provided Excel data into a SQL Server / PostgreSQL / MySQL database.

Using the SQL queries above to generate analytical reports.
