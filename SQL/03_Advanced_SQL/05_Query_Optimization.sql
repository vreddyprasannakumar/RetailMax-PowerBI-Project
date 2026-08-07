USE retailmaxdw;

-- =========================================================
-- QUERY OPTIMIZATION & BEST PRACTICES
-- =========================================================

-- =========================================================
-- 01. View Execution Plan
-- =========================================================
EXPLAIN
SELECT *
FROM fact_sales
WHERE customer_id = 100;

-- =========================================================
-- 02. Avoid SELECT *
-- =========================================================
SELECT
    sales_id,
    order_id,
    sales_amount
FROM fact_sales;

-- =========================================================
-- 03. Filter Before JOIN
-- =========================================================
SELECT
    fs.sales_id,
    dc.first_name,
    fs.sales_amount
FROM fact_sales fs
JOIN dim_customer dc
ON fs.customer_id = dc.customer_id
WHERE fs.sales_amount > 100000;

-- =========================================================
-- 04. EXISTS Instead of IN
-- =========================================================
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer dc
WHERE EXISTS
(
    SELECT 1
    FROM fact_sales fs
    WHERE fs.customer_id = dc.customer_id
);

-- =========================================================
-- 05. NOT EXISTS
-- =========================================================
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer dc
WHERE NOT EXISTS
(
    SELECT 1
    FROM fact_sales fs
    WHERE fs.customer_id = dc.customer_id
);

-- =========================================================
-- 06. UNION
-- =========================================================
SELECT customer_id
FROM fact_sales

UNION

SELECT customer_id
FROM fact_returns;

-- =========================================================
-- 07. UNION ALL
-- =========================================================
SELECT customer_id
FROM fact_sales

UNION ALL

SELECT customer_id
FROM fact_returns;

-- =========================================================
-- 08. Sales Between Range
-- =========================================================
SELECT
    sales_id,
    sales_amount
FROM fact_sales
WHERE sales_amount BETWEEN 10000 AND 50000;

-- =========================================================
-- 09. Use LIMIT
-- =========================================================
SELECT
    product_name,
    selling_price
FROM dim_product
ORDER BY selling_price DESC
LIMIT 10;

-- =========================================================
-- 10. Indexed Search
-- =========================================================
SELECT
    *
FROM dim_product
WHERE product_id = 250;

-- =========================================================
-- 11. Revenue by Store
-- =========================================================
SELECT
    store_id,
    SUM(sales_amount) revenue
FROM fact_sales
GROUP BY store_id;

-- =========================================================
-- 12. Revenue by Product
-- =========================================================
SELECT
    product_id,
    SUM(sales_amount) revenue
FROM fact_sales
GROUP BY product_id;

-- =========================================================
-- 13. Revenue by Customer
-- =========================================================
SELECT
    customer_id,
    SUM(sales_amount) revenue
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 14. Top Customers
-- =========================================================
SELECT
    customer_id,
    SUM(sales_amount) revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- 15. Explain Join
-- =========================================================
EXPLAIN
SELECT
    fs.sales_id,
    dp.product_name
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id = dp.product_id;

-- =========================================================
-- 16. Explain Aggregate
-- =========================================================
EXPLAIN
SELECT
    SUM(sales_amount)
FROM fact_sales;

-- =========================================================
-- 17. Explain Group By
-- =========================================================
EXPLAIN
SELECT
    customer_id,
    SUM(sales_amount)
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 18. Explain Order By
-- =========================================================
EXPLAIN
SELECT
    product_name,
    selling_price
FROM dim_product
ORDER BY selling_price DESC;

-- =========================================================
-- 19. Explain Window Function
-- =========================================================
EXPLAIN
SELECT
    customer_id,
    SUM(sales_amount),
    RANK() OVER(ORDER BY SUM(sales_amount) DESC)
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 20. Check Existing Indexes
-- =========================================================
SHOW INDEX
FROM fact_sales;