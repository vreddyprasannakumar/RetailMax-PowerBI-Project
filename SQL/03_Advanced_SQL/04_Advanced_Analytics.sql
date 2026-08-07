USE retailmaxdw;

-- =========================================================
-- ADVANCED ANALYTICS
-- =========================================================

-- 01. Top 10 Customers by Revenue
SELECT
    customer_id,
    ROUND(SUM(sales_amount),2) AS revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- 02. Bottom 10 Customers by Revenue
-- =========================================================
SELECT
    customer_id,
    ROUND(SUM(sales_amount),2) AS revenue
FROM fact_sales
GROUP BY customer_id
ORDER BY revenue
LIMIT 10;

-- =========================================================
-- 03. Top 10 Products by Revenue
-- =========================================================
SELECT
    dp.product_name,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
GROUP BY dp.product_name
ORDER BY revenue DESC
LIMIT 10;

-- =========================================================
-- 04. Bottom 10 Products by Revenue
-- =========================================================
SELECT
    dp.product_name,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
GROUP BY dp.product_name
ORDER BY revenue
LIMIT 10;

-- =========================================================
-- 05. Revenue Contribution %
-- =========================================================
SELECT
    dp.product_name,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(
        SUM(fs.sales_amount) *100 /
        (SELECT SUM(sales_amount) FROM fact_sales),
    2) contribution_percent
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
GROUP BY dp.product_name
ORDER BY revenue DESC;

-- =========================================================
-- 06. Profit Contribution %
-- =========================================================
SELECT
    dp.product_name,
    ROUND(SUM(fs.profit),2) profit,
    ROUND(
        SUM(fs.profit)*100/
        (SELECT SUM(profit) FROM fact_sales),
    2) contribution_percent
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
GROUP BY dp.product_name
ORDER BY profit DESC;

-- =========================================================
-- 07. Customer Lifetime Value
-- =========================================================
SELECT
    customer_id,
    COUNT(DISTINCT order_id) orders_count,
    ROUND(SUM(sales_amount),2) lifetime_value
FROM fact_sales
GROUP BY customer_id
ORDER BY lifetime_value DESC;

-- =========================================================
-- 08. Average Revenue per Customer
-- =========================================================
SELECT
    ROUND(
        SUM(sales_amount)/
        COUNT(DISTINCT customer_id),
    2) avg_customer_revenue
FROM fact_sales;

-- =========================================================
-- 09. Revenue by Customer Segment
-- =========================================================
SELECT
    dc.customer_segment,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_customer dc
ON fs.customer_id=dc.customer_id
GROUP BY dc.customer_segment
ORDER BY revenue DESC;

-- =========================================================
-- 10. Average Revenue per Store
-- =========================================================
SELECT
    ds.store_name,
    ROUND(AVG(fs.sales_amount),2) avg_revenue
FROM fact_sales fs
JOIN dim_store ds
ON fs.store_id=ds.store_id
GROUP BY ds.store_name
ORDER BY avg_revenue DESC;

-- =========================================================
-- 11. Revenue by Brand
-- =========================================================
SELECT
    dp.brand,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
GROUP BY dp.brand
ORDER BY revenue DESC;

-- =========================================================
-- 12. Revenue by Supplier
-- =========================================================
SELECT
    ds.supplier_name,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
JOIN dim_supplier ds
ON dp.supplier_id=ds.supplier_id
GROUP BY ds.supplier_name
ORDER BY revenue DESC;

-- =========================================================
-- 13. Store Contribution %
-- =========================================================
SELECT
    ds.store_name,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(
        SUM(fs.sales_amount)*100/
        (SELECT SUM(sales_amount) FROM fact_sales),
    2) contribution_percent
FROM fact_sales fs
JOIN dim_store ds
ON fs.store_id=ds.store_id
GROUP BY ds.store_name
ORDER BY revenue DESC;

-- =========================================================
-- 14. Category Contribution %
-- =========================================================
SELECT
    dc.category_name,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(
        SUM(fs.sales_amount)*100/
        (SELECT SUM(sales_amount) FROM fact_sales),
    2) contribution_percent
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id=dp.product_id
JOIN dim_category dc
ON dp.category_id=dc.category_id
GROUP BY dc.category_name
ORDER BY revenue DESC;

-- =========================================================
-- 15. Top Store in Every Region
-- =========================================================
WITH StoreRevenue AS
(
SELECT
    dr.region_name,
    ds.store_name,
    SUM(fs.sales_amount) revenue,
    ROW_NUMBER() OVER(
        PARTITION BY dr.region_name
        ORDER BY SUM(fs.sales_amount) DESC
    ) rn
FROM fact_sales fs
JOIN dim_store ds
ON fs.store_id=ds.store_id
JOIN dim_region dr
ON ds.region_id=dr.region_id
GROUP BY
    dr.region_name,
    ds.store_name
)
SELECT *
FROM StoreRevenue
WHERE rn=1;