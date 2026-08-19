# Superstore Sales Analysis — SQL Project

## Overview
This project analyzes the **Superstore Sales dataset** (Kaggle) using **MySQL** to answer common business questions around sales, profit, and regional performance. It reflects the type of analysis an entry-level Data Analyst would be asked to perform: sales breakdowns, top-customer analysis, trend analysis, and profitability segmentation.

## Tools Used
- MySQL Workbench
- SQL (Aggregations, Subqueries, CTEs, Window-style date functions, CASE WHEN logic)

## Dataset
Superstore Sales dataset — retail order-level data including Sales, Profit, Region, Category, Customer, and Order Date fields.

## Business Questions Answered

**Q1: What are the total sales for each product category?**
Grouped and ranked total sales by product category to identify top-performing categories.

**Q2: Who are the top 5 customers by total profit?**
Identified the highest-value customers based on total profit contribution.

**Q3: Which products have sales above the average sales (overall)?**
Compared each product's sales against the overall average using a subquery to flag above-average performers.

**Q4: What are the monthly sales trends for 2017?**
Converted string-formatted order dates and extracted month/year to analyze seasonal sales trends — solved using two different filtering approaches (`LIKE` vs. `YEAR()`).

**Q5: What is the profit margin by region, and how does each region rank into tiers?**
Calculated profit margin (Profit / Sales) by region, then used `CASE WHEN` to bucket each region into **Low / Medium / High** margin tiers. Solved using both a **CTE** and a **non-CTE (subquery)** approach to demonstrate both techniques.

## Key Takeaways
- Practiced translating business questions into SQL logic step-by-step.
- Solved several questions using more than one method (CTE vs. subquery, `LIKE` vs. `YEAR()`) to compare readability and performance trade-offs.
- Strengthened skills in `GROUP BY`, subqueries, `CASE WHEN` tiering logic, and date string conversion (`STR_TO_DATE`).

## Files
- `superstore_queries.sql` — all 5 questions with full SQL code and comments

---
*Part of a broader data analytics portfolio also including Tableau and Power BI dashboards.*
