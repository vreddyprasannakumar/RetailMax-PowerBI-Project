
-- =========================================================
-- 01. Revenue by Region
-- =========================================================
SELECT
    r.region_name,
    ROUND(SUM(fs.sales_amount),2) AS total_revenue
FROM fact_sales fs
JOIN dim_store s
    ON fs.store_id = s.store_id
JOIN dim_region r
    ON s.region_id = r.region_id
GROUP BY r.region_name
ORDER BY total_revenue DESC;

-- =========================================================
-- 02. Revenue by Store
-- =========================================================
SELECT
    s.store_name,
    ROUND(SUM(fs.sales_amount),2) AS total_revenue
FROM fact_sales fs
JOIN dim_store s
    ON fs.store_id = s.store_id
GROUP BY s.store_name
ORDER BY total_revenue DESC;

-- =========================================================
-- 03. Revenue by Category
-- =========================================================
SELECT
    c.category_name,
    ROUND(SUM(fs.sales_amount),2) AS total_revenue
FROM fact_sales fs
JOIN dim_product p
    ON fs.product_id = p.product_id
JOIN dim_category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

-- =========================================================
-- 04. Profit by Category
-- =========================================================
SELECT
    c.category_name,
    ROUND(SUM(fs.profit),2) AS total_profit
FROM fact_sales fs
JOIN dim_product p
    ON fs.product_id = p.product_id
JOIN dim_category c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_profit DESC;

-- =========================================================
-- 05. Revenue by Payment Mode
-- =========================================================
SELECT
    payment_mode,
    ROUND(SUM(sales_amount),2) AS total_revenue
FROM fact_sales
GROUP BY payment_mode
ORDER BY total_revenue DESC;

-- =========================================================
-- 06. Orders by Order Status
-- =========================================================
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM fact_sales
GROUP BY order_status
ORDER BY total_orders DESC;

-- =========================================================
-- 07. Revenue by Customer Segment
-- =========================================================
SELECT
    dc.customer_segment,
    ROUND(SUM(fs.sales_amount),2) AS total_revenue
FROM fact_sales fs
JOIN dim_customer dc
    ON fs.customer_id = dc.customer_id
GROUP BY dc.customer_segment
ORDER BY total_revenue DESC;

-- =========================================================
-- 08. Average Order Value by Store
-- =========================================================
SELECT
    ds.store_name,
    ROUND(AVG(fs.sales_amount),2) AS avg_order_value
FROM fact_sales fs
JOIN dim_store ds
    ON fs.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY avg_order_value DESC;

-- =========================================================
-- 09. Total Units Sold by Category
-- =========================================================
SELECT
    dc.category_name,
    SUM(fs.quantity) AS total_units
FROM fact_sales fs
JOIN dim_product dp
    ON fs.product_id = dp.product_id
JOIN dim_category dc
    ON dp.category_id = dc.category_id
GROUP BY dc.category_name
ORDER BY total_units DESC;

-- =========================================================
-- 10. Revenue by Employee
-- =========================================================
SELECT
    CONCAT(de.first_name,' ',de.last_name) AS employee_name,
    ROUND(SUM(fs.sales_amount),2) AS total_revenue
FROM fact_sales fs
JOIN dim_employee de
    ON fs.employee_id = de.employee_id
GROUP BY employee_name
ORDER BY total_revenue DESC;

-- =========================================================
-- 11. Stores with Revenue > 300 Million
-- =========================================================
SELECT
    ds.store_name,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_store ds
    ON fs.store_id = ds.store_id
GROUP BY ds.store_name
HAVING revenue > 300000000
ORDER BY revenue DESC;

-- =========================================================
-- 12. Categories with Profit > 50 Million
-- =========================================================
SELECT
    dc.category_name,
    ROUND(SUM(fs.profit),2) AS profit
FROM fact_sales fs
JOIN dim_product dp
    ON fs.product_id = dp.product_id
JOIN dim_category dc
    ON dp.category_id = dc.category_id
GROUP BY dc.category_name
HAVING profit > 50000000
ORDER BY profit DESC;

-- =========================================================
-- 13. Payment Modes with More Than 5000 Orders
-- =========================================================
SELECT
    payment_mode,
    COUNT(*) AS total_orders
FROM fact_sales
GROUP BY payment_mode
HAVING total_orders > 5000
ORDER BY total_orders DESC;

-- =========================================================
-- 14. Customer Segments with Revenue > 500 Million
-- =========================================================
SELECT
    dc.customer_segment,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_customer dc
    ON fs.customer_id = dc.customer_id
GROUP BY dc.customer_segment
HAVING revenue > 500000000
ORDER BY revenue DESC;

-- =========================================================
-- 15. Average Discount by Category
-- =========================================================
SELECT
    dc.category_name,
    ROUND(AVG(fs.discount),2) AS avg_discount
FROM fact_sales fs
JOIN dim_product dp
    ON fs.product_id = dp.product_id
JOIN dim_category dc
    ON dp.category_id = dc.category_id
GROUP BY dc.category_name
ORDER BY avg_discount DESC;

-- =========================================================
-- 16. Average Profit by Store
-- =========================================================
SELECT
    ds.store_name,
    ROUND(AVG(fs.profit),2) AS avg_profit
FROM fact_sales fs
JOIN dim_store ds
    ON fs.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY avg_profit DESC;

-- =========================================================
-- 17. Total Refund Amount by Return Reason
-- =========================================================
SELECT
    return_reason,
    ROUND(SUM(refund_amount),2) AS refund_amount
FROM fact_returns
GROUP BY return_reason
ORDER BY refund_amount DESC;

-- =========================================================
-- 18. Total Returns by Product
-- =========================================================
SELECT
    dp.product_name,
    COUNT(*) AS total_returns
FROM fact_returns fr
JOIN dim_product dp
    ON fr.product_id = dp.product_id
GROUP BY dp.product_name
ORDER BY total_returns DESC
LIMIT 10;

-- =========================================================
-- 19. Inventory Available by Store
-- =========================================================
SELECT
    ds.store_name,
    SUM(fi.stock_available) AS available_stock
FROM fact_inventory fi
JOIN dim_store ds
    ON fi.store_id = ds.store_id
GROUP BY ds.store_name
ORDER BY available_stock DESC;

-- =========================================================
-- 20. Products Below Average Available Stock
-- =========================================================
SELECT
    product_id,
    AVG(stock_available) AS avg_stock
FROM fact_inventory
GROUP BY product_id
HAVING avg_stock < (
    SELECT AVG(stock_available)
    FROM fact_inventory
)
ORDER BY avg_stock;