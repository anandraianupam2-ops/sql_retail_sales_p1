CREATE table retail_sales(
transactions_id INT PRIMARY KEY,
	sale_date date,
	sale_time TIME,
	customer_id INT,	gender VARCHAR (15),
	age	INT ,category VARCHAR (15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT );
    
    -- DATA CLEANING 
    
 SELECT * FROM retail_sales
 where 
 transactions_id is null
 OR
 sale_date is null
 OR
 sale_time is null
 OR
 customer_id is null
 OR
 gender is null
 OR
 age is null
 OR
 category is null
 OR
 quantiy is null
 OR
 price_per_unit is null
 OR 
 cogs is null
 OR
 total_sale is null;
 
 DELETE FROM retail_sales
 WHERE 
 transactions_id is null
 OR
 sale_date is null
 OR
 sale_time is null
 OR
 customer_id is null
 OR
 gender is null
 OR
 age is null
 OR
 category is null
 OR
 quantiy is null
 OR
 price_per_unit is null
 OR 
 cogs is null
 OR
 total_sale is null;
 
 -- DATA EXPLORATION 
 
 -- HOW MANY SALES WE HAVE ?
 
 SELECT count(*)as total_sales FROM retail_sales;
 
 -- HOW MANY UNIQUE CUSTOMERS WE HAVE ?
 
SELECT count(DISTINCT customer_id) AS Total_customer from retail_sales;

-- HOW MANY CATEGORY WE HAVE ?

SELECT count(DISTINCT category) from retail_sales;

-- WRITE A SQL QUERY TO RETRIEVE ALL COLOUMS FOR SALES MADE ON '2022-11-05'.

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGOREY IS 'CLOTHING; AND 
-- QUANTITY SOLD IS MARE THAN 3 IN THE MONTH OF NOV-2022.

SELECT * from retail_sales
where category = 'clothing' and quantiy > 3
and sale_date BETWEEN '2022-11-01' and '2022-12-01';

-- WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES FOR EACH CATEGORY.

SELECT category,sum(total_sale) ,count(*) as total_orders from retail_sales
GROUP BY category;

-- WRITE A SQL QUERY TO FIND THE AVREAGE AGE OF CUSTOMERS WHO PURCHAGED 
-- ITEAMS FROM THE 'BEAUTY' CATEGORY .

SELECT round(avg(age),2) as avg_age from retail_sales
where category = 'Beauty';

-- WRITE A SQL QUERY TO FIND ALL THE TRANSACTIONS WHERE TOTAL_SALES IS GREATER THAN 1000. 

SELECT * FROM retail_sales
WHERE total_sale >= 1000;

-- WRITE A SQL QUERY TO FIND TOTAL NUMBER OF TRANSACTIONS (TRANSACTION_ID) MADE BY EACH GENDER IN EACH CATEGORY.

SELECT gender,category, count(*) AS total_transaction from retail_sales
group by gender,category
order by 2;

--  WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH .FIND OUT BEST SELLING MONTH IN EACH YEAR.

SELECT year,Month,Avg FROM(
SELECT 
year(sale_date) as year,
month(sale_date) as Month,
AVG(total_sale) as Avg,
RANK() OVER(PARTITION BY year(sale_date) ORDER BY AVG(total_sale) DESC) as Rank_no
from retail_sales
GROUP BY 1,2) AS T1
WHERE Rank_no =1;

-- WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGEST TOTAL SALES.

SELECT customer_id,sum(total_sale) as total_sales FROM retail_sales
GROUP BY customer_id
order by 2 desc
limit 5;

--  WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEAMS FROM EACH CATEGORY.

SELECT 
category,
count(DISTINCT customer_id)as unique_customers
FROM retail_sales
GROUP BY category;


-- WRITE A SQL QUERY TO CREATE EACH SIFT AND NUMBER OF ORDERS ( EXAMPLE MORNING <= 12 o Clock, AFTERNOON BETWEEN 12 AND 17 EVENING >17).

With hourly_sale as(
SELECT * ,
CASE
     WHEN HOUR (sale_time )< 12 THEN 'Morning'
     WHEN HOUR (sale_time )BETWEEN 12 and 17 THEN 'Afternoon'
     ELSE 'Evening'
     END AS SHIFT
FROM retail_sales)
select SHIFT,count(*) AS Total_orders from hourly_sale
GROUP BY SHIFT ;

-- END OF PROJECT
