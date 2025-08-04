-- SQL Retail Sales Analysis --
CREATE DATABASE sql_project_2


--Create Table
DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT * FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

--
DELETE FROM retail_sales
WHERE
     transactions_id IS NULL
	 OR
	 sale_date IS NULL
	 OR
	 sale_time IS NULL
	 OR
	 customer_id IS NULL
	 OR
	 gender IS NULL
	 OR
	 category IS NULL
	 OR
	 quantity IS NULL
	 OR
	 cogs IS NULL
	 OR
	 total_sale IS NULL;

SELECT 
     COUNT(*)
FROM retail_sales

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?
SELECT COUNT(*) as total_sale FROM retail_sales

__ HOW MANY DISTINCT CUSTOMERS WE HAVE?
SELECT COUNT (DISTINCT customer_id) as total_sale FROM retail_sales

__DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS

__WRITE A SQL QUERY TO RETRIEVE ALL COLUMS FOR SALES MADE ON '2022-11-05'

SELECT *
FROM retail_sales 
WHERE sale_date = '2022-11-05';

--WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTION WHERE THE CATEGORY IS "CLOTHING" AND THE QUANTITY SOLD IS MORE THAN 10 IN THE MONTH OF NOV-2022

SELECT 
*
FROM retail_sales
WHERE category ='Clothing'
AND
TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND
quantity>=4

-- WRITE A SQL query to calculate the total sales(total_sales)fot each category
SELECT 
   category,
   SUM(total_sale) as net_sale,
   COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

__ WWRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE "BEAUTY" CATEGORY.
SELECT 
    ROUND(AVG(age)) as avg_sale
FROM retail_sales
WHERE category = 'Beauty'

--	WRITE A SQL query to find all transactions where the total_sale id greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 100

__Write a SQL query to find the total number of transactions (transactiob_id) made by each gender in each category
SELECT
   category,
   gender,
   COUNT(*) as total_trans
FROM retail_sales
GROUP
    BY
	category,
	gender
ORDER BY 1

__WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH .FIND OUT BEST SELLING MONTH IN EACH YEAR.
SELECT 
    year,
    month,
    avg_sale
FROM 
(
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY year, month
) AS t1
WHERE rank = 1;

__WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
SELECT
    customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

__WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED 1 ITEMS FROM EACH CATEGORY.

SELECT 
    category,
	COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

__WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING<=12, AFTERNOON BETWEEN 12 AND 17,EVENING >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
	WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
	ELSE'Evening'
  END as shift 
FROM retail_sales
)
SELECT 
     shift,
	 COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift

__	END OF PROJECT


