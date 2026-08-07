USE retailmaxdw;

-- =========================================================
-- WINDOW FUNCTIONS - PART 1
-- ROW_NUMBER | RANK | DENSE_RANK | NTILE
-- =========================================================

-- 01. ROW_NUMBER - Highest Revenue Products
SELECT
    product_id,
    SUM(sales_amount) revenue,
    ROW_NUMBER() OVER(ORDER BY SUM(sales_amount) DESC) row_num
FROM fact_sales
GROUP BY product_id;

-- =========================================================
-- 02. ROW_NUMBER - Highest Revenue Customers
-- =========================================================
SELECT
    customer_id,
    SUM(sales_amount) revenue,
    ROW_NUMBER() OVER(ORDER BY SUM(sales_amount) DESC) row_num
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 03. ROW_NUMBER - Store Revenue
-- =========================================================
SELECT
    store_id,
    SUM(sales_amount) revenue,
    ROW_NUMBER() OVER(ORDER BY SUM(sales_amount) DESC) row_num
FROM fact_sales
GROUP BY store_id;

-- =========================================================
-- 04. RANK - Product Revenue
-- =========================================================
SELECT
    product_id,
    SUM(sales_amount) revenue,
    RANK() OVER(ORDER BY SUM(sales_amount) DESC) product_rank
FROM fact_sales
GROUP BY product_id;

-- =========================================================
-- 05. RANK - Customer Revenue
-- =========================================================
SELECT
    customer_id,
    SUM(sales_amount) revenue,
    RANK() OVER(ORDER BY SUM(sales_amount) DESC) customer_rank
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 06. RANK - Employee Revenue
-- =========================================================
SELECT
    employee_id,
    SUM(sales_amount) revenue,
    RANK() OVER(ORDER BY SUM(sales_amount) DESC) employee_rank
FROM fact_sales
GROUP BY employee_id;

-- =========================================================
-- 07. DENSE_RANK - Product Profit
-- =========================================================
SELECT
    product_id,
    SUM(profit) profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) dense_rank_no
FROM fact_sales
GROUP BY product_id;

-- =========================================================
-- 08. DENSE_RANK - Store Profit
-- =========================================================
SELECT
    store_id,
    SUM(profit) profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) dense_rank_no
FROM fact_sales
GROUP BY store_id;

-- =========================================================
-- 09. DENSE_RANK - Customer Profit
-- =========================================================
SELECT
    customer_id,
    SUM(profit) profit,
    DENSE_RANK() OVER(ORDER BY SUM(profit) DESC) dense_rank_no
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 10. NTILE(4) - Customer Revenue Quartiles
-- =========================================================
SELECT
    customer_id,
    SUM(sales_amount) revenue,
    NTILE(4) OVER(ORDER BY SUM(sales_amount) DESC) quartile
FROM fact_sales
GROUP BY customer_id;

-- =========================================================
-- 11. NTILE(5) - Product Revenue Quintiles
-- =========================================================
SELECT
    product_id,
    SUM(sales_amount) revenue,
    NTILE(5) OVER(ORDER BY SUM(sales_amount) DESC) quintile
FROM fact_sales
GROUP BY product_id;

-- =========================================================
-- 12. ROW_NUMBER by Category
-- =========================================================
SELECT
    dc.category_name,
    dp.product_name,
    SUM(fs.sales_amount) revenue,
    ROW_NUMBER() OVER(
        PARTITION BY dc.category_name
        ORDER BY SUM(fs.sales_amount) DESC
    ) row_num
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id = dp.product_id
JOIN dim_category dc
ON dp.category_id = dc.category_id
GROUP BY
    dc.category_name,
    dp.product_name;

-- =========================================================
-- 13. RANK by Category
-- =========================================================
SELECT
    dc.category_name,
    dp.product_name,
    SUM(fs.sales_amount) revenue,
    RANK() OVER(
        PARTITION BY dc.category_name
        ORDER BY SUM(fs.sales_amount) DESC
    ) rank_no
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id = dp.product_id
JOIN dim_category dc
ON dp.category_id = dc.category_id
GROUP BY
    dc.category_name,
    dp.product_name;

-- =========================================================
-- 14. DENSE_RANK by Store
-- =========================================================
SELECT
    ds.store_name,
    CONCAT(de.first_name,' ',de.last_name) employee_name,
    SUM(fs.sales_amount) revenue,
    DENSE_RANK() OVER(
        PARTITION BY ds.store_name
        ORDER BY SUM(fs.sales_amount) DESC
    ) rank_no
FROM fact_sales fs
JOIN dim_employee de
ON fs.employee_id = de.employee_id
JOIN dim_store ds
ON fs.store_id = ds.store_id
GROUP BY
    ds.store_name,
    employee_name;

-- =========================================================
-- 15. Top Product per Category
-- =========================================================
WITH RankedProducts AS
(
SELECT
    dc.category_name,
    dp.product_name,
    SUM(fs.sales_amount) revenue,
    ROW_NUMBER() OVER(
        PARTITION BY dc.category_name
        ORDER BY SUM(fs.sales_amount) DESC
    ) rn
FROM fact_sales fs
JOIN dim_product dp
ON fs.product_id = dp.product_id
JOIN dim_category dc
ON dp.category_id = dc.category_id
GROUP BY
    dc.category_name,
    dp.product_name
)
SELECT *
FROM RankedProducts
WHERE rn = 1;