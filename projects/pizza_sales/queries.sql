-- =====================================================
-- PROJECT: Pizza Sales Analysis
-- AUTHOR: Nonyameko Portia Ntsele
-- PLATFORM: Google BigQuery
-- DATE: May 2026
-- DESCRIPTION:
-- End-to-end SQL analysis of pizza sales including KPIs,
-- product performance, and time-based business insights
-- =====================================================


-- =====================================================
-- PHASE 1: DATA UNDERSTANDING
-- =====================================================

-- List all tables
SELECT table_name
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.INFORMATION_SCHEMA.TABLES`;


-- Preview datasets
SELECT * FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` LIMIT 5;
SELECT * FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` LIMIT 5;
SELECT * FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders` LIMIT 5;
SELECT * FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizza_types` LIMIT 5;


-- Table relationships (documented logic)
/*
orders → order_details (order_id)
order_details → pizzas (pizza_id)
pizzas → pizza_types (pizza_type_id)
*/


-- =====================================================
-- PHASE 2: BUSINESS KPIs
-- =====================================================

-- Total orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders`;


-- Total pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details`;


-- Total revenue
SELECT
  ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id;


-- Average order value
SELECT
  ROUND(
    SUM(od.quantity * p.price) / COUNT(DISTINCT od.order_id),
    2
  ) AS avg_order_value
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id;


-- Top 10 pizzas by quantity sold
SELECT
  pizza_id,
  SUM(quantity) AS total_sold
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details`
GROUP BY pizza_id
ORDER BY total_sold DESC
LIMIT 10;


-- Top 10 pizzas by revenue
SELECT
  od.pizza_id,
  ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
GROUP BY od.pizza_id
ORDER BY total_revenue DESC
LIMIT 10;


-- =====================================================
-- PHASE 3: BUSINESS INSIGHTS
-- =====================================================

-- Daily order trend
SELECT
  date,
  COUNT(DISTINCT order_id) AS total_orders
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders`
GROUP BY date
ORDER BY date DESC;


-- Peak ordering hours
SELECT
  EXTRACT(HOUR FROM time) AS order_hour,
  COUNT(order_id) AS total_orders
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders`
GROUP BY order_hour
ORDER BY total_orders DESC;


-- Revenue by category
SELECT
  pt.category,
  ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizza_types` pt
  ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;


-- Pizza size performance
SELECT
  p.size,
  SUM(od.quantity) AS total_sold
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_sold DESC;


-- =====================================================
-- PHASE 4: ADVANCED ANALYSIS
-- =====================================================

-- Revenue contribution by pizza
WITH pizza_revenue AS (
  SELECT
    od.pizza_id,
    SUM(od.quantity * p.price) AS revenue
  FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
    ON od.pizza_id = p.pizza_id
  GROUP BY od.pizza_id
)
SELECT
  pizza_id,
  revenue,
  ROUND((revenue / SUM(revenue) OVER()) * 100, 2) AS revenue_percentage
FROM pizza_revenue
ORDER BY revenue_percentage DESC;


-- Best pizza per category
WITH category_sales AS (
  SELECT
    pt.category,
    p.pizza_id,
    SUM(od.quantity) AS total_sold
  FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
    ON od.pizza_id = p.pizza_id
  JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizza_types` pt
    ON p.pizza_type_id = pt.pizza_type_id
  GROUP BY pt.category, p.pizza_id
)
SELECT
  category,
  pizza_id,
  total_sold,
  RANK() OVER (
    PARTITION BY category
    ORDER BY total_sold DESC
  ) AS rank_in_category
FROM category_sales;


-- Revenue by category
WITH category_revenue AS (
  SELECT
    pt.category,
    SUM(od.quantity * p.price) AS revenue
  FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
    ON od.pizza_id = p.pizza_id
  JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizza_types` pt
    ON p.pizza_type_id = pt.pizza_type_id
  GROUP BY pt.category
)
SELECT
  category,
  revenue,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
  ROUND((revenue / SUM(revenue) OVER()) * 100, 2) AS revenue_percentage
FROM category_revenue
ORDER BY revenue_rank DESC;


-- Hourly revenue distribution (peak demand analysis)
SELECT
  EXTRACT(HOUR FROM o.time) AS order_hour,
  ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders` o
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  ON o.order_id = od.order_id
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
GROUP BY order_hour
ORDER BY revenue DESC;


-- Daily revenue trend 
SELECT
  o.date,
  ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders` o
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  ON o.order_id = od.order_id
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date DESC;


-- Cumulative revenue trend 
SELECT
  o.date,
  ROUND(SUM(od.quantity * p.price), 2) AS daily_revenue,
  ROUND(
    SUM(SUM(od.quantity * p.price)) OVER (ORDER BY o.date),
    2
  ) AS cumulative_revenue
FROM `project-8a19fb9c-cff3-4d83-820.pizza_sales.orders` o
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.order_details` od
  ON o.order_id = od.order_id
JOIN `project-8a19fb9c-cff3-4d83-820.pizza_sales.pizzas` p
  ON od.pizza_id = p.pizza_id
GROUP BY o.date
ORDER BY o.date DESC;
