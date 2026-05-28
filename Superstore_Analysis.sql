CREATE DATABASE sales_analysis;
USE sales_analysis;
CREATE TABLE superstore (
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    state VARCHAR(100),
    country VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(50),
    product_id VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(255),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2),
    shipping_cost DECIMAL(10,2),
    order_priority VARCHAR(20),
    year INT
);
LOAD DATA LOCAL INFILE 'C:/Users/sahit/OneDrive/Desktop/superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM superstore;

-- Top 10 Profitable Products
SELECT product_name,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Top 10 customers by Sales
SELECT customer_name, SUM(sales) as total_sales from superstore
group by customer_name
order by sum(sales) desc
limit 10;

-- Region wise Total Sales
select region, SUM(sales) AS total_sales from superstore
group by region
order by sum(sales) DESC;

-- Category wise average profit
select category, AVG(profit) as avg_profit from superstore
group by category;

-- Highest Discount Category
SELECT category,
       MAX(discount) AS highest_discount
FROM superstore
GROUP BY category
ORDER BY highest_discount DESC
limit 1;

-- Orders with negative Profit
select order_id, profit from superstore
where profit<0
order by profit;

UPDATE superstore
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');
UPDATE superstore
SET ship_date = STR_TO_DATE(ship_date, '%d-%m-%Y');

-- Monthly Sales Trend
SELECT MONTHNAME(order_date) AS order_month,
       SUM(sales) AS total_sales
FROM superstore
GROUP BY MONTH(order_date),
         MONTHNAME(order_date)
ORDER BY MONTH(order_date);

-- Market wise Revenue Analysis
select market, SUM(sales) as revenue from superstore
group by market
order by SUM(sales) DESC;

-- Top performing sub Categories
SELECT sub_category,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC;

-- ship mode usage analysis
SELECT ship_mode,
       COUNT(*) AS total_orders
FROM superstore
GROUP BY ship_mode
ORDER BY total_orders DESC;
