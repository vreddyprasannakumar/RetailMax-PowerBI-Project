USE retailmaxdw;

-- =========================================================
-- DROP VIEWS (Run if recreating)
-- =========================================================

DROP VIEW IF EXISTS vw_sales_summary;
DROP VIEW IF EXISTS vw_customer_summary;
DROP VIEW IF EXISTS vw_product_performance;
DROP VIEW IF EXISTS vw_store_performance;
DROP VIEW IF EXISTS vw_inventory_summary;
DROP VIEW IF EXISTS vw_return_summary;
DROP VIEW IF EXISTS vw_employee_performance;
DROP VIEW IF EXISTS vw_supplier_sales;

-- =========================================================
-- 01. Sales Summary View
-- =========================================================

CREATE VIEW vw_sales_summary AS
SELECT
    fs.sales_id,
    fs.order_id,
    dd.full_date,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dp.product_name,
    ds.store_name,
    fs.quantity,
    fs.sales_amount,
    fs.profit
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
JOIN dim_customer dc
ON fs.customer_id = dc.customer_id
JOIN dim_product dp
ON fs.product_id = dp.product_id
JOIN dim_store ds
ON fs.store_id = ds.store_id;

-- Test
SELECT * FROM vw_sales_summary LIMIT 20;

-- =========================================================
-- 02. Customer Summary View
-- =========================================================

CREATE VIEW vw_customer_summary AS
SELECT
    dc.customer_id,
    CONCAT(dc.first_name,' ',dc.last_name) customer_name,
    dc.customer_segment,
    COUNT(fs.order_id) total_orders,
    SUM(fs.quantity) total_units,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM dim_customer dc
LEFT JOIN fact_sales fs
ON dc.customer_id = fs.customer_id
GROUP BY
    dc.customer_id,
    customer_name,
    dc.customer_segment;

-- Test
SELECT * FROM vw_customer_summary
ORDER BY revenue DESC
LIMIT 20;

-- =========================================================
-- 03. Product Performance View
-- =========================================================

CREATE VIEW vw_product_performance AS
SELECT
    dp.product_id,
    dp.product_name,
    dc.category_name,
    SUM(fs.quantity) units_sold,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM dim_product dp
LEFT JOIN fact_sales fs
ON dp.product_id = fs.product_id
JOIN dim_category dc
ON dp.category_id = dc.category_id
GROUP BY
    dp.product_id,
    dp.product_name,
    dc.category_name;

-- Test
SELECT * FROM vw_product_performance
ORDER BY revenue DESC
LIMIT 20;

-- =========================================================
-- 04. Store Performance View
-- =========================================================

CREATE VIEW vw_store_performance AS
SELECT
    ds.store_id,
    ds.store_name,
    dr.region_name,
    COUNT(fs.order_id) total_orders,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM dim_store ds
LEFT JOIN fact_sales fs
ON ds.store_id = fs.store_id
JOIN dim_region dr
ON ds.region_id = dr.region_id
GROUP BY
    ds.store_id,
    ds.store_name,
    dr.region_name;

-- Test
SELECT * FROM vw_store_performance
ORDER BY revenue DESC;

-- =========================================================
-- 05. Inventory Summary View
-- =========================================================

CREATE VIEW vw_inventory_summary AS
SELECT
    ds.store_name,
    dp.product_name,
    fi.stock_received,
    fi.stock_sold,
    fi.stock_available,
    fi.reorder_level
FROM fact_inventory fi
JOIN dim_store ds
ON fi.store_id = ds.store_id
JOIN dim_product dp
ON fi.product_id = dp.product_id;

-- Test
SELECT * FROM vw_inventory_summary
LIMIT 20;

-- =========================================================
-- 06. Return Summary View
-- =========================================================

CREATE VIEW vw_return_summary AS
SELECT
    fr.return_id,
    dp.product_name,
    fr.return_reason,
    fr.refund_amount
FROM fact_returns fr
JOIN dim_product dp
ON fr.product_id = dp.product_id;

-- Test
SELECT * FROM vw_return_summary
LIMIT 20;

-- =========================================================
-- 07. Employee Performance View
-- =========================================================

CREATE VIEW vw_employee_performance AS
SELECT
    de.employee_id,
    CONCAT(de.first_name,' ',de.last_name) employee_name,
    COUNT(fs.order_id) total_orders,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM dim_employee de
LEFT JOIN fact_sales fs
ON de.employee_id = fs.employee_id
GROUP BY
    de.employee_id,
    employee_name;

-- Test
SELECT * FROM vw_employee_performance
ORDER BY revenue DESC;

-- =========================================================
-- 08. Supplier Sales View
-- =========================================================

CREATE VIEW vw_supplier_sales AS
SELECT
    ds.supplier_name,
    COUNT(fs.order_id) total_orders,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM dim_supplier ds
JOIN dim_product dp
ON ds.supplier_id = dp.supplier_id
JOIN fact_sales fs
ON dp.product_id = fs.product_id
GROUP BY ds.supplier_name;

-- Test
SELECT * FROM vw_supplier_sales
ORDER BY revenue DESC;