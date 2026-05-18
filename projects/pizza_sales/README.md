# 🍕 Pizza Sales Analysis (SQL | Google BigQuery)

## 📊 Project Overview

This project is an end-to-end SQL-driven business analysis of a pizza sales dataset using Google BigQuery.

The objective is to transform raw transactional data into actionable business insights that support decision-making in:
- Revenue optimization
- Product performance analysis
- Customer demand understanding
- Operational planning

---

## 🧠 Business Objective

The analysis focuses on answering key business questions:

- What are the main drivers of revenue and order volume?
- Which products and categories generate the most value?
- When is customer demand at its peak?
- Which products are underperforming?
- How can the business improve operational efficiency?

---

## 🔍 Analytical Approach

A structured analytics workflow was applied:

1. Data exploration and schema understanding
2. KPI definition and validation
3. Product, category, and time-based segmentation
4. Advanced SQL analysis using CTEs and window functions
5. Insight extraction and business interpretation
6. Recommendation development for decision support

---

## 📂 Dataset Structure

The dataset follows a **star-schema model**:

- `orders` → order-level data (date, time, order_id)
- `order_details` → transactional line items (pizza_id, quantity)
- `pizzas` → product attributes (size, price, type)
- `pizza_types` → category and product naming

### Key Relationships:
- orders → order_details (order_id)
- order_details → pizzas (pizza_id)
- pizzas → pizza_types (pizza_type_id)

---

## 🛠️ Tools & Technologies

- Google BigQuery
- SQL
- CTEs (WITH clauses)
- Window Functions (RANK, SUM OVER)
- Time-based analysis (EXTRACT functions)

---

## 📊 Key Business Metrics

- **Total Orders:** 21,350  
- **Total Pizzas Sold:** 49,574  
- **Total Revenue:** $817,860.05  
- **Average Order Value:** $38.31  

---

## 🍕 Product Performance Insights

### Top Performing Pizzas
- Big Meat S — 1,914 units sold  
- Thai Chicken L — 1,410 units sold  
- Five Cheese L — 1,409 units sold  

### 📌 Insight:
A small group of products contributes a disproportionately large share of total sales, indicating strong revenue concentration among top-performing SKUs.

---

## 🏷️ Category Performance

| Category | Revenue  |  Share |
|----------|----------|--------|
| Classic  | $220,053 | 26.91% |
| Supreme  | $208,197 | 25.46% |
| Chicken  | $195,919 | 23.96% |
| Veggie   | $193,690 | 23.68% |

### 📌 Insight:
Revenue is relatively balanced across categories, indicating a diversified product portfolio with low dependency risk on a single category.

---

## ⏰ Demand & Time Analysis

### Peak Ordering Hours
- 12:00 → highest demand (2,520 orders)
- 13:00 → 2,455 orders
- 18:00 → 2,399 orders

### 📌 Insight:
Customer demand is heavily concentrated around lunch and early evening hours, reflecting predictable consumption behavior tied to meal times.

---

## 📏 Product Size Analysis

- Large (L): 18,956 orders  
- Medium (M): 15,635 orders  
- Small (S): 14,403 orders  
- XL / XXL: very low demand  

### 📌 Insight:
Customer preference is strongly skewed toward large-sized pizzas, while XL and XXL sizes show minimal demand and may require repositioning or removal.

---

## 📈 Revenue Trends

- Revenue remains stable over time with no major downward trend
- Total cumulative revenue: **$817,860.05**
- Consistent daily performance indicates steady customer demand

---

## 📈 Key Improvements During Analysis

- Structured SQL using CTEs for readability and modular logic
- Improved query efficiency using window functions
- Standardized KPI definitions for consistency
- Added time-based segmentation for operational insights
- Strengthened business interpretation layer

---

## ⚠️ Challenges & How They Were Solved

### 1. Data Ingestion Issues (BigQuery)
- Resolved CSV formatting and schema mismatch errors
- Standardized encoding and delimiter structure (UTF-8)

### 2. Schema Understanding
- Mapped star-schema relationships across multiple tables
- Validated joins through exploratory SQL queries

### 3. Query Optimization
- Reduced redundant joins
- Introduced CTEs and window functions for cleaner logic

---

## 🧭 Business Recommendations

Based on the analysis:

1. Optimize staffing during peak hours (12:00–13:00, 17:00–19:00)
2. Focus marketing on top-performing pizzas
3. Re-evaluate low-performing sizes (XL, XXL)
4. Introduce bundle deals during peak demand periods

---

## 📌 Business Impact

This analysis enables data-driven decision-making across:

- Menu optimization and product strategy
- Revenue growth opportunities
- Operational efficiency planning
- Customer demand forecasting

It transforms raw transactional data into structured business intelligence for strategic decision-making.

---

## 📊 Dashboard

An interactive Tableau dashboard complements this analysis, visualizing:
- Revenue trends over time
- Category performance
- Peak ordering periods
- Product-level contribution to revenue

---

## 🚀 Summary

This project demonstrates end-to-end SQL analytics capability, combining technical SQL skills with business thinking to deliver actionable insights.

It reflects real-world analytical workflows used in data analyst roles.
