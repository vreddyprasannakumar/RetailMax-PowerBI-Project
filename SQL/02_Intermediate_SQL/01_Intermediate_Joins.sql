USE retailmaxdw;

-- =========================================================
-- INTERMEDIATE JOINS
-- =========================================================

-- 01. Sales Report with Customer, Product and Store
SELECT
    fs.order_id,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dp.product_name,
    ds.store_name,
    fs.quantity,
    fs.sales_amount
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id = dc.customer_id
JOIN dim_product dp ON fs.product_id = dp.product_id
JOIN dim_store ds ON fs.store_id = ds.store_id;

-- =========================================================
-- 02. Complete Sales Report
-- =========================================================
SELECT
    fs.order_id,
    dd.full_date,
    CONCAT(dc.first_name,' ',dc.last_name) customer,
    dp.product_name,
    cat.category_name,
    sup.supplier_name,
    ds.store_name,
    reg.region_name,
    CONCAT(emp.first_name,' ',emp.last_name) employee,
    fs.quantity,
    fs.sales_amount,
    fs.profit
FROM fact_sales fs
JOIN dim_date dd ON fs.date_id=dd.date_id
JOIN dim_customer dc ON fs.customer_id=dc.customer_id
JOIN dim_product dp ON fs.product_id=dp.product_id
JOIN dim_category cat ON dp.category_id=cat.category_id
JOIN dim_supplier sup ON dp.supplier_id=sup.supplier_id
JOIN dim_store ds ON fs.store_id=ds.store_id
JOIN dim_region reg ON ds.region_id=reg.region_id
JOIN dim_employee emp ON fs.employee_id=emp.employee_id;

-- =========================================================
-- 03. Returns with Customer Details
-- =========================================================
SELECT
    fr.return_id,
    CONCAT(dc.first_name,' ',dc.last_name) customer,
    dp.product_name,
    fr.return_reason,
    fr.refund_amount
FROM fact_returns fr
JOIN dim_customer dc ON fr.customer_id=dc.customer_id
JOIN dim_product dp ON fr.product_id=dp.product_id;

-- =========================================================
-- 04. Inventory Report
-- =========================================================
SELECT
    ds.store_name,
    dp.product_name,
    cat.category_name,
    fi.stock_received,
    fi.stock_sold,
    fi.stock_available,
    fi.reorder_level
FROM fact_inventory fi
JOIN dim_store ds ON fi.store_id=ds.store_id
JOIN dim_product dp ON fi.product_id=dp.product_id
JOIN dim_category cat ON dp.category_id=cat.category_id;

-- =========================================================
-- 05. Revenue by Supplier
-- =========================================================
SELECT
    sup.supplier_name,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id=dp.product_id
JOIN dim_supplier sup ON dp.supplier_id=sup.supplier_id
GROUP BY sup.supplier_name
ORDER BY revenue DESC;

-- =========================================================
-- 06. Revenue by Brand
-- =========================================================
SELECT
    dp.brand,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id=dp.product_id
GROUP BY dp.brand
ORDER BY revenue DESC;

-- =========================================================
-- 07. Profit by Region
-- =========================================================
SELECT
    reg.region_name,
    ROUND(SUM(fs.profit),2) profit
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id=ds.store_id
JOIN dim_region reg ON ds.region_id=reg.region_id
GROUP BY reg.region_name
ORDER BY profit DESC;

-- =========================================================
-- 08. Employee Performance
-- =========================================================
SELECT
    CONCAT(emp.first_name,' ',emp.last_name) employee,
    emp.designation,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM fact_sales fs
JOIN dim_employee emp ON fs.employee_id=emp.employee_id
GROUP BY employee,emp.designation
ORDER BY revenue DESC;

-- =========================================================
-- 09. Customer Purchase Summary
-- =========================================================
SELECT
    CONCAT(dc.first_name,' ',dc.last_name) customer,
    COUNT(fs.order_id) orders_count,
    SUM(fs.quantity) units,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_customer dc ON fs.customer_id=dc.customer_id
GROUP BY customer
ORDER BY revenue DESC;

-- =========================================================
-- 10. Product Performance
-- =========================================================
SELECT
    dp.product_name,
    cat.category_name,
    SUM(fs.quantity) units_sold,
    ROUND(SUM(fs.sales_amount),2) revenue,
    ROUND(SUM(fs.profit),2) profit
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id=dp.product_id
JOIN dim_category cat ON dp.category_id=cat.category_id
GROUP BY dp.product_name,cat.category_name
ORDER BY revenue DESC;

-- =========================================================
-- 11. Store Performance
-- =========================================================
SELECT
    ds.store_name,
    reg.region_name,
    COUNT(fs.order_id) orders_count,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_store ds ON fs.store_id=ds.store_id
JOIN dim_region reg ON ds.region_id=reg.region_id
GROUP BY ds.store_name,reg.region_name
ORDER BY revenue DESC;

-- =========================================================
-- 12. Category Performance
-- =========================================================
SELECT
    cat.category_name,
    COUNT(fs.order_id) orders_count,
    SUM(fs.quantity) units,
    ROUND(SUM(fs.sales_amount),2) revenue
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id=dp.product_id
JOIN dim_category cat ON dp.category_id=cat.category_id
GROUP BY cat.category_name
ORDER BY revenue DESC;

-- =========================================================
-- 13. Customer Returns Summary
-- =========================================================
SELECT
    CONCAT(dc.first_name,' ',dc.last_name) customer,
    COUNT(fr.return_id) returns_count,
    ROUND(SUM(fr.refund_amount),2) refund
FROM fact_returns fr
JOIN dim_customer dc ON fr.customer_id=dc.customer_id
GROUP BY customer
ORDER BY refund DESC;

-- =========================================================
-- 14. Supplier Inventory Summary
-- =========================================================
SELECT
    sup.supplier_name,
    SUM(fi.stock_available) stock
FROM fact_inventory fi
JOIN dim_product dp ON fi.product_id=dp.product_id
JOIN dim_supplier sup ON dp.supplier_id=sup.supplier_id
GROUP BY sup.supplier_name
ORDER BY stock DESC;

-- =========================================================
-- 15. Product Sales and Returns
-- =========================================================
SELECT
    dp.product_name,
    COUNT(DISTINCT fs.sales_id) total_sales,
    COUNT(DISTINCT fr.return_id) total_returns
FROM dim_product dp
LEFT JOIN fact_sales fs
ON dp.product_id=fs.product_id
LEFT JOIN fact_returns fr
ON dp.product_id=fr.product_id
GROUP BY dp.product_name
ORDER BY total_sales DESC;