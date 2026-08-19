/* ============================================================
   Superstore Sales Analysis - SQL Portfolio Project
   Author: Rashmanpreet Kaur
   Tool: MySQL Workbench
   Dataset: Superstore Sales Dataset (Kaggle)
   ============================================================ */

CREATE DATABASE superstore;
USE superstore;

CREATE TABLE superstore (
  `Row ID` INT,
  `Order ID` VARCHAR(50),
  `Order Date` VARCHAR(20),
  `Ship Date` VARCHAR(20),
  `Ship Mode` VARCHAR(50),
  `Customer ID` VARCHAR(50),
  `Customer Name` VARCHAR(100),
  `Segment` VARCHAR(50),
  `Country` VARCHAR(50),
  `City` VARCHAR(100),
  `State` VARCHAR(50),
  `Postal Code` VARCHAR(20),
  `Region` VARCHAR(50),
  `Product ID` VARCHAR(50),
  `Category` VARCHAR(50),
  `Sub-Category` VARCHAR(50),
  `Product Name` VARCHAR(255),
  `Sales` DOUBLE,
  `Quantity` INT,
  `Discount` DOUBLE,
  `Profit` DOUBLE
);

SELECT * FROM superstore LIMIT 10;

/* Check categories exist */
SELECT DISTINCT Category FROM superstore;


/* ============================================================
   Q1: What are the total sales for each product category?
   ============================================================ */
SELECT Category, ROUND(SUM(Sales), 2) AS Total_sales
FROM superstore
GROUP BY Category
ORDER BY Total_sales DESC;


/* ============================================================
   Q2: Who are the top 5 customers by total profit?
   ============================================================ */
SELECT `Customer Name`, SUM(Profit) AS Total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY Total_profit DESC
LIMIT 5;


/* ============================================================
   Q3: Which products have sales above the average sales (overall)?
   ============================================================ */
SELECT ROUND(AVG(Sales), 2) FROM superstore;

SELECT `Product Name`, Sales
FROM superstore
WHERE Sales > (SELECT AVG(Sales) FROM superstore)
ORDER BY Sales DESC;


/* ============================================================
   Q4: What are the monthly sales trends for 2017?
   ============================================================ */

/* Approach 1: filter using LIKE on the date string */
SELECT ROUND(SUM(Sales), 2) AS Total_sales,
       MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Month
FROM superstore
WHERE `Order Date` LIKE '%2017'
GROUP BY Order_Month
ORDER BY Order_Month;

/* Approach 2: filter using YEAR() on the converted date */
SELECT ROUND(SUM(Sales), 2) AS Total_sales,
       MONTH(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) AS Order_Month
FROM superstore
WHERE YEAR(STR_TO_DATE(`Order Date`, '%m/%d/%Y')) = 2017
GROUP BY Order_Month
ORDER BY Order_Month;


/* ============================================================
   Q5: Find the profit margin by region, and use CASE WHEN to
   bucket each region into tiers (High / Medium / Low margin).
   ============================================================ */

/* Base calculation: total sales, total profit, profit margin by region */
SELECT Region,
       SUM(Sales) AS Total_sales,
       SUM(Profit) AS Total_profit,
       (SUM(Profit) / SUM(Sales) * 100) AS profit_margin
FROM superstore
GROUP BY Region;

/* Approach 1: Using a CTE */
WITH cte AS (
    SELECT Region,
           ROUND(SUM(Sales), 2) AS Total_sales,
           ROUND(SUM(Profit), 2) AS Total_profit,
           ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin
    FROM superstore
    GROUP BY Region
)
SELECT Region, Total_sales, Total_profit, profit_margin,
       CASE
           WHEN profit_margin < 10 THEN 'Low'
           WHEN profit_margin BETWEEN 10 AND 15 THEN 'Medium'
           ELSE 'High'
       END AS margin_tier
FROM cte;

/* Approach 2: Without a CTE */
SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_sales,
    ROUND(SUM(Profit), 2) AS Total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin,
    CASE
        WHEN (SUM(Profit) / SUM(Sales)) * 100 < 10 THEN 'Low'
        WHEN (SUM(Profit) / SUM(Sales)) * 100 BETWEEN 10 AND 15 THEN 'Medium'
        ELSE 'High'
    END AS margin_tier
FROM superstore
GROUP BY Region;
