create database reatil_sales;
use reatil_sales;
CREATE TABLE orders (
    row_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(20) NOT NULL,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    prdoduct_id VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(150),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(12,2)
);
select * from orders limit 5 ;
-- Query 1: Total sales and total profit across all orders
SELECT 
    SUM(sales) AS TotalSales, 
    SUM(profit) AS TotalProfit
FROM orders;

-- Query 2: Total orders and total sales by customer segment
SELECT 
    segment, 
    COUNT(DISTINCT order_id) AS TotalOrders, 
    SUM(sales) AS Sales
FROM orders
GROUP BY segment
ORDER BY Sales DESC;

-- Query 3: Top 5 products by revenue
SELECT 
    product_name, 
    SUM(sales) AS TotalSales
FROM orders
GROUP BY product_name
ORDER BY TotalSales DESC
LIMIT 5;

-- Query 4: Number of orders and total sales per region
SELECT 
    region, 
    COUNT(order_id) AS TotalOrders, 
    SUM(sales) AS RegionSales
FROM orders
GROUP BY region
ORDER BY RegionSales DESC;

-- Query 5: Monthly sales trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS Month, 
    SUM(sales) AS MonthlySales
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY Month;

-- Query 6: Top 5 customers by revenue and profit
SELECT 
    customer_name, 
    SUM(sales) AS Revenue, 
    SUM(profit) AS Profit
FROM orders
GROUP BY customer_name
ORDER BY Revenue DESC
LIMIT 5;

-- Query 7: Average discount and its impact on profit
SELECT 
    AVG(discount) AS AvgDiscount, 
    AVG(profit) AS AvgProfit
FROM orders;

-- Query 8: Products with highest profit margin
SELECT 
    product_name, 
    SUM(profit)/SUM(sales)*100 AS ProfitMargin
FROM orders
GROUP BY product_name
ORDER BY ProfitMargin DESC
LIMIT 5;

-- Query 9: Total sales and profit by category and sub-category
SELECT 
    category, 
    sub_category, 
    SUM(sales) AS TotalSales, 
    SUM(profit) AS TotalProfit
FROM orders
GROUP BY category, sub_category
ORDER BY TotalProfit DESC;

-- Query 10: Monthly revenue growth percentage
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS Month,
    SUM(sales) AS MonthlySales,
    (SUM(sales) - LAG(SUM(sales)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m'))) 
        / LAG(SUM(sales)) OVER (ORDER BY DATE_FORMAT(order_date, '%Y-%m')) * 100 AS GrowthPct
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY Month;

















