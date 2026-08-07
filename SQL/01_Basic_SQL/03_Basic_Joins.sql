
-- =========================================================
-- 01. Sales with Customer Details
-- =========================================================
SELECT
    fs.order_id,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_customer dc
ON fs.customer_id = dc.customer_id;

-- =========================================================
-- 02. Sales with Product Details
-- =========================================================
SELECT
    fs.order_id,
    dp.product_name,
    fs.quantity,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_product dp
ON fs.product_id = dp.product_id;

-- =========================================================
-- 03. Sales with Store Details
-- =========================================================
SELECT
    fs.order_id,
    ds.store_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_store ds
ON fs.store_id = ds.store_id;

-- =========================================================
-- 04. Sales with Employee Details
-- =========================================================
SELECT
    fs.order_id,
    CONCAT(de.first_name,' ',de.last_name) AS employee_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_employee de
ON fs.employee_id = de.employee_id;

-- =========================================================
-- 05. Product with Category
-- =========================================================
SELECT
    dp.product_name,
    dc.category_name
FROM dim_product dp
INNER JOIN dim_category dc
ON dp.category_id = dc.category_id;

-- =========================================================
-- 06. Product with Supplier
-- =========================================================
SELECT
    dp.product_name,
    ds.supplier_name
FROM dim_product dp
INNER JOIN dim_supplier ds
ON dp.supplier_id = ds.supplier_id;

-- =========================================================
-- 07. Store with Region
-- =========================================================
SELECT
    ds.store_name,
    dr.region_name,
    dr.zone_name
FROM dim_store ds
INNER JOIN dim_region dr
ON ds.region_id = dr.region_id;

-- =========================================================
-- 08. Customer with Region
-- =========================================================
SELECT
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dr.region_name
FROM dim_customer dc
INNER JOIN dim_region dr
ON dc.region_id = dr.region_id;

-- =========================================================
-- 09. Sales with Date
-- =========================================================
SELECT
    fs.order_id,
    dd.full_date,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_date dd
ON fs.date_id = dd.date_id;

-- =========================================================
-- 10. Return with Product
-- =========================================================
SELECT
    fr.return_id,
    dp.product_name,
    fr.refund_amount
FROM fact_returns fr
INNER JOIN dim_product dp
ON fr.product_id = dp.product_id;

-- =========================================================
-- 11. Return with Customer
-- =========================================================
SELECT
    fr.return_id,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    fr.refund_amount
FROM fact_returns fr
INNER JOIN dim_customer dc
ON fr.customer_id = dc.customer_id;

-- =========================================================
-- 12. Inventory with Product
-- =========================================================
SELECT
    fi.inventory_id,
    dp.product_name,
    fi.stock_available
FROM fact_inventory fi
INNER JOIN dim_product dp
ON fi.product_id = dp.product_id;

-- =========================================================
-- 13. Inventory with Store
-- =========================================================
SELECT
    fi.inventory_id,
    ds.store_name,
    fi.stock_available
FROM fact_inventory fi
INNER JOIN dim_store ds
ON fi.store_id = ds.store_id;

-- =========================================================
-- 14. Product, Category and Supplier
-- =========================================================
SELECT
    dp.product_name,
    dc.category_name,
    ds.supplier_name
FROM dim_product dp
INNER JOIN dim_category dc
ON dp.category_id = dc.category_id
INNER JOIN dim_supplier ds
ON dp.supplier_id = ds.supplier_id;

-- =========================================================
-- 15. Sales with Customer and Product
-- =========================================================
SELECT
    fs.order_id,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dp.product_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_customer dc
ON fs.customer_id = dc.customer_id
INNER JOIN dim_product dp
ON fs.product_id = dp.product_id;

-- =========================================================
-- 16. Sales with Store and Employee
-- =========================================================
SELECT
    fs.order_id,
    ds.store_name,
    CONCAT(de.first_name,' ',de.last_name) AS employee_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_store ds
ON fs.store_id = ds.store_id
INNER JOIN dim_employee de
ON fs.employee_id = de.employee_id;

-- =========================================================
-- 17. Sales with Region
-- =========================================================
SELECT
    fs.order_id,
    dr.region_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_store ds
ON fs.store_id = ds.store_id
INNER JOIN dim_region dr
ON ds.region_id = dr.region_id;

-- =========================================================
-- 18. Customer, Region and Sales
-- =========================================================
SELECT
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dr.region_name,
    fs.sales_amount
FROM fact_sales fs
INNER JOIN dim_customer dc
ON fs.customer_id = dc.customer_id
INNER JOIN dim_region dr
ON dc.region_id = dr.region_id;

-- =========================================================
-- 19. Complete Sales Report
-- =========================================================
SELECT
    fs.order_id,
    dd.full_date,
    CONCAT(dc.first_name,' ',dc.last_name) AS customer_name,
    dp.product_name,
    ds.store_name,
    CONCAT(de.first_name,' ',de.last_name) AS employee_name,
    fs.quantity,
    fs.sales_amount,
    fs.profit
FROM fact_sales fs
INNER JOIN dim_date dd
ON fs.date_id = dd.date_id
INNER JOIN dim_customer dc
ON fs.customer_id = dc.customer_id
INNER JOIN dim_product dp
ON fs.product_id = dp.product_id
INNER JOIN dim_store ds
ON fs.store_id = ds.store_id
INNER JOIN dim_employee de
ON fs.employee_id = de.employee_id;

-- =========================================================
-- 20. Complete Inventory Report
-- =========================================================
SELECT
    fi.inventory_id,
    ds.store_name,
    dp.product_name,
    dc.category_name,
    fi.stock_received,
    fi.stock_sold,
    fi.stock_available,
    fi.reorder_level
FROM fact_inventory fi
INNER JOIN dim_product dp
ON fi.product_id = dp.product_id
INNER JOIN dim_category dc
ON dp.category_id = dc.category_id
INNER JOIN dim_store ds
ON fi.store_id = ds.store_id;