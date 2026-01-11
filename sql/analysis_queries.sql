--Sales & Profitability Optimization for a Supermarket Chain

Complete SQL Queries for All 6 Analyses 
-NITEESH PANDEY 

-- Table Name: SuperMarket
--All columns are as provided in CSV

---
-- Total Sales & Gross Income (Month-wise)

--```sql

-- (1). Total Sales & Gross Income Overall

SELECT 
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income,
    ROUND((SUM(gross_income) / SUM(Sales)) * 100, 2) AS Overall_Margin_Percentage
FROM SuperMarket;

-- Month-wise Revenue & Gross Income
SELECT 
    MONTH(STR_TO_DATE(Date, '%m/%d/%Y')) AS Month_Num,
    CASE MONTH(STR_TO_DATE(Date, '%m/%d/%Y'))
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
    END AS Month_Name,
    ROUND(SUM(Sales), 2) AS Monthly_Sales,
    ROUND(SUM(gross_income), 2) AS Monthly_Gross_Income,
    ROUND((SUM(gross_income) / SUM(Sales)) * 100, 2) AS Monthly_Margin_Percentage
FROM SuperMarket
GROUP BY Month_Num, Month_Name
ORDER BY Month_Num;
```

---
--(1️). Product Line Analysis

--```sql
-- Top Revenue & Gross Income Categories
SELECT 
    `Product line`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income,
    ROUND((SUM(gross_income) / SUM(Sales)) * 100, 2) AS Margin_Percentage,
    COUNT(*) AS Transaction_Count
FROM SuperMarket
GROUP BY `Product line`
ORDER BY Total_Sales DESC;

-- Low Margin but High Sales Products (Margins below avg with high sales)
WITH ProductSummary AS (
    SELECT 
        `Product line`,
        SUM(Sales) AS Total_Sales,
        SUM(gross_income) AS Total_Gross_Income,
        (SUM(gross_income) / SUM(Sales)) * 100 AS Margin_Percentage
    FROM SuperMarket
    GROUP BY `Product line`
)
SELECT *
FROM ProductSummary
WHERE Margin_Percentage < (SELECT AVG(Margin_Percentage) FROM ProductSummary)
    AND Total_Sales > (SELECT AVG(Total_Sales) FROM ProductSummary)
ORDER BY Total_Sales DESC;
```

---

--️ (3).Customer Type Analysis

--```sql
-- Member vs Normal Comparison
SELECT 
    `Customer type`,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income,
    ROUND(AVG(Sales), 2) AS Avg_Bill_Value,
    ROUND(AVG(gross_income), 2) AS Avg_Gross_Income_per_Transaction
FROM SuperMarket
GROUP BY `Customer type`
ORDER BY Total_Sales DESC;

-- Customer Type Performance by Product Line
SELECT 
    `Customer type`,
    `Product line`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Sales_per_Transaction,
    COUNT(*) AS Transaction_Count
FROM SuperMarket
GROUP BY `Customer type`, `Product line`
ORDER BY `Customer type`, Total_Sales DESC;
```

---

--(4). Branch / City Performance

```sql
-- Revenue vs Gross Income by Branch/City
SELECT 
    Branch,
    City,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income,
    ROUND((SUM(gross_income) / SUM(Sales)) * 100, 2) AS Margin_Percentage,
    ROUND(AVG(Sales), 2) AS Avg_Transaction_Value
FROM SuperMarket
GROUP BY Branch, City
ORDER BY Total_Sales DESC;

-- Underperforming Branch (Lowest Margin %)
SELECT 
    Branch,
    City,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income,
    ROUND((SUM(gross_income) / SUM(Sales)) * 100, 2) AS Margin_Percentage
FROM SuperMarket
GROUP BY Branch, City
ORDER BY Margin_Percentage ASC
LIMIT 1;
```

---

--(5). Payment Mode Impact

--```sql
-- Payment Mode Analysis
SELECT 
    Payment,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Basket_Value,
    ROUND(AVG(Quantity), 2) AS Avg_Items_per_Transaction,
    ROUND(SUM(gross_income), 2) AS Total_Gross_Income
FROM SuperMarket
GROUP BY Payment
ORDER BY Total_Sales DESC;

-- Payment Mode by Customer Type
SELECT 
    `Customer type`,
    Payment,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Basket_Value
FROM SuperMarket
GROUP BY `Customer type`, Payment
ORDER BY `Customer type`, Total_Sales DESC;
```

---
️--(6).Customer Rating Insight

--```sql
-- Rating vs Sales Analysis
SELECT 
    `Product line`,
    ROUND(AVG(Rating), 2) AS Avg_Rating,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Sales_per_Transaction
FROM SuperMarket
GROUP BY `Product line`
ORDER BY Avg_Rating DESC;

-- Rating Distribution Analysis
SELECT 
    CASE 
        WHEN Rating >= 9 THEN '9-10 (Excellent)'
        WHEN Rating >= 8 THEN '8-8.9 (Very Good)'
        WHEN Rating >= 7 THEN '7-7.9 (Good)'
        WHEN Rating >= 6 THEN '6-6.9 (Average)'
        ELSE 'Below 6 (Poor)'
    END AS Rating_Band,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(AVG(Sales), 2) AS Avg_Sales_Value
FROM SuperMarket
GROUP BY Rating_Band
ORDER BY Total_Sales DESC;

-- Correlation between Rating and Sales Value
SELECT 
    ROUND(AVG(Rating), 2) AS Avg_Rating,
    ROUND(AVG(Sales), 2) AS Avg_Sales,
    ROUND(AVG(gross_income), 2) AS Avg_Gross_Income
FROM SuperMarket;
```

---

- BONUS: Executive Summary Query

--```sql
-- Complete Performance Dashboard in One Query
SELECT 
    -- Overall Metrics
    (SELECT ROUND(SUM(Sales), 2) FROM SuperMarket) AS Total_Revenue,
    (SELECT ROUND(SUM(gross_income), 2) FROM SuperMarket) AS Total_Gross_Income,
    (SELECT COUNT(DISTINCT `Invoice ID`) FROM SuperMarket) AS Total_Transactions,
    
    -- Top Performing Category
    (SELECT `Product line` FROM SuperMarket 
     GROUP BY `Product line` 
     ORDER BY SUM(Sales) DESC LIMIT 1) AS Top_Product_Category,
    
    -- Top Performing Branch
    (SELECT CONCAT(Branch, ' - ', City) FROM SuperMarket 
     GROUP BY Branch, City 
     ORDER BY SUM(Sales) DESC LIMIT 1) AS Top_Branch,
    
    -- Member Contribution
    (SELECT ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM SuperMarket)) * 100, 2)
     FROM SuperMarket 
     WHERE `Customer type` = 'Member') AS Member_Revenue_Percentage,
    
    -- Most Popular Payment
    (SELECT Payment FROM SuperMarket 
     GROUP BY Payment 
     ORDER BY COUNT(*) DESC LIMIT 1) AS Most_Popular_Payment_Method
FROM SuperMarket
LIMIT 1;
```

---

🔑 Insights from Queries:(niteesh pandey)

1. Health and beauty is the most profitable category
2. Members drive 94% of revenue
3. Giza (Naypyitaw) is the underperforming branch
4. Cash payments yield highest basket size
5. Ratings don't strongly correlate with sales value
6. March shows highest sales among the 3 months


