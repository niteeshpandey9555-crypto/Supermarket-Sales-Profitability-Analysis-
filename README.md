
# Sales & Profitability Optimization for a Supermarket Chain

##  Project Overview
This project focuses on analyzing supermarket transactional sales data to identify
profitability drivers, high-margin product categories, valuable customer segments,
and underperforming branches. The goal is to support data-driven business decisions
using SQL-based analysis.

The analysis answers real-world business questions related to revenue, margins,
customer behavior, and operational performance.

---

## Business Objectives
- Identify overall sales and gross income trends
- Analyze product lines contributing to high revenue vs high margins
- Compare customer segments (Member vs Normal)
- Evaluate branch and city-level performance
- Understand the impact of payment methods on basket size
- Assess whether customer ratings influence sales value

---

## Dataset Information
- **Source:** Supermarket sales transactional dataset
- **Records:** ~1,000 transactions
- **Columns:** 17
- **Time Period:** 3 months
- **Data Quality:** No missing or null values

**Key Columns:**
- Date, Time
- Branch, City
- Product line
- Customer type
- Payment method
- Quantity, Sales, Gross Income
- Rating

---

##  Tools & Technologies
- **SQL (MySQL-compatible syntax)**
- CSV dataset
- GitHub for version control and documentation

> Note: Date parsing functions are written assuming a MySQL environment.
> Minor syntax changes may be required for other SQL dialects.

---

## Business Questions Answered
1. What are the total sales and gross income, overall and month-wise?
2. Which product lines generate the highest revenue and margins?
3. Which product categories have high sales but below-average margins?
4. How do Member and Normal customers differ in spending behavior?
5. Which branch or city is underperforming in terms of profitability?
6. How do payment methods affect basket size and sales value?
7. Is there a relationship between customer ratings and sales?

---

##  Analysis Performed
- Revenue and margin aggregation
- Month-wise trend analysis
- Product line profitability comparison
- Customer segmentation analysis
- Branch and city performance evaluation
- Payment mode impact analysis
- Rating-based sales analysis

All analyses were performed using structured SQL queries with grouping,
aggregations, conditional logic, and CTEs where required.

---

##  Key Insights
- Certain product lines generate high revenue but operate on lower margins
- Member customers contribute a significantly larger share of total revenue
- One branch underperforms on margin despite reasonable sales volume
- Cash payments show higher average basket value compared to other payment modes
- Customer ratings do not show a strong correlation with sales value
- March records the highest sales among the three months analyzed

---

##  Business Recommendations
- Focus on high-margin product categories to improve profitability
- Review pricing and discount strategies for low-margin, high-volume products
- Strengthen customer membership programs to increase repeat purchases
- Investigate operational or pricing issues at underperforming branches
- Encourage payment methods associated with higher basket size

---

<br>
AUTHOR--NITEESH PANDEY 
