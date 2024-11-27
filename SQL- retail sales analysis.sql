CREATE DATABASE retail_sales_p1;
USE retail_sales_p1;

CREATE TABLE retail_sales (
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	 INT,
gender VARCHAR(20),
age	INT,
category VARCHAR(20),
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT);

SELECT COUNT(*) FROM retail_sales;

 -- DATA CLEANING

SELECT * FROM retail_sales
WHERE
transactions_id IS NULL
or
sale_date IS NULL
or
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
or
age IS NULL
OR
category IS NULL
OR
quantiy IS NULL
or
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- DATA EXPLORATION

-- HOW MANY SALES WE HAVE?

SELECT COUNT(*) total_sale from retail_sales;

-- HOW MANY CUSTOMERS WE HAVE?

SELECT COUNT(DISTINCT(customer_id)) FROM retail_sales;

-- HOW MANY CATEGORIES WE HAVE ?

SELECT COUNT(DISTINCT(category)) FROM retail_sales;

-- DATA ANALYSIS AND KEY BUSINESS PROBLEMS AND ANSWERS;

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Analysis

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT * FROM retail_sales 
WHERE sale_date = "2022-11-05";


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than or equals to 4 in the month of Nov-2022.

SELECT * FROM retail_sales
WHERE category = "clothing"
AND quantiy >= 4
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';



-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS total_sales_by_category
FROM retail_sales
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS avg_age FROM retail_sales
WHERE category ='Beauty' ;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT transactions_id, customer_id
FROM retail_sales
WHERE total_sale > 1000;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT COUNT(transactions_id), gender, category
FROM retail_sales
GROUP BY gender, category;



-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT sale_year, sale_month, avg_sale, annual_rank
FROM
(SELECT YEAR(sale_date) AS sale_year,
    MONTHNAME(sale_date) AS sale_month,
    avg(total_sale) AS avg_sale,
    (RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY avg(total_sale) DESC)) AS annual_rank
FROM retail_sales
GROUP BY sale_year, sale_month
ORDER BY sale_year, avg_sale DESC) AS t1
WHERE annual_rank = 1 ;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT COUNT(DISTINCT(customer_id)) AS no_of_customers, category
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT COUNT(transactions_id) AS no_of_orders,
CASE
WHEN HOUR(sale_time) <=12 THEN "Morning"
WHEN HOUR(sale_time) > 12 AND HOUR(sale_time) <= 17 THEN "Afternoon"
WHEN HOUR(sale_time) > 17 THEN "Evening"
END AS shift
FROM retail_sales
GROUP BY shift;



