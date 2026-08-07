USE retailmaxdw;

-- =========================================================
-- COMMON TABLE EXPRESSIONS (CTE)
-- =========================================================

-- 01. Total Revenue by Category
WITH CategoryRevenue AS
(
    SELECT
        dc.category_name,
        SUM(fs.sales_amount) AS revenue
    FROM fact_sales fs
    JOIN dim_product dp
        ON fs.product_id = dp.product_id
    JOIN dim_category dc
        ON dp.category_id = dc.category_id
    GROUP BY dc.category_name
)
SELECT *
FROM CategoryRevenue
ORDER BY revenue DESC;

-- =========================================================
-- 02. Total Revenue by Store
-- =========================================================
WITH StoreRevenue AS
(
    SELECT
        ds.store_name,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_store ds
        ON fs.store_id = ds.store_id
    GROUP BY ds.store_name
)
SELECT *
FROM StoreRevenue
ORDER BY revenue DESC;

-- =========================================================
-- 03. Customer Revenue
-- =========================================================
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(sales_amount) revenue
    FROM fact_sales
    GROUP BY customer_id
)
SELECT *
FROM CustomerRevenue
ORDER BY revenue DESC;

-- =========================================================
-- 04. Product Profit
-- =========================================================
WITH ProductProfit AS
(
    SELECT
        product_id,
        SUM(profit) profit
    FROM fact_sales
    GROUP BY product_id
)
SELECT *
FROM ProductProfit
ORDER BY profit DESC;

-- =========================================================
-- 05. Monthly Revenue
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        dd.month_name,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number,
        dd.month_name
)
SELECT *
FROM MonthlyRevenue
ORDER BY year_number, month_number;

-- =========================================================
-- 06. Monthly Profit
-- =========================================================
WITH MonthlyProfit AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.profit) profit
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT *
FROM MonthlyProfit
ORDER BY year_number, month_number;

-- =========================================================
-- 07. Store Wise Orders
-- =========================================================
WITH StoreOrders AS
(
    SELECT
        store_id,
        COUNT(DISTINCT order_id) total_orders
    FROM fact_sales
    GROUP BY store_id
)
SELECT *
FROM StoreOrders
ORDER BY total_orders DESC;

-- =========================================================
-- 08. Category Wise Units Sold
-- =========================================================
WITH CategoryUnits AS
(
    SELECT
        dc.category_name,
        SUM(fs.quantity) units_sold
    FROM fact_sales fs
    JOIN dim_product dp
        ON fs.product_id = dp.product_id
    JOIN dim_category dc
        ON dp.category_id = dc.category_id
    GROUP BY dc.category_name
)
SELECT *
FROM CategoryUnits
ORDER BY units_sold DESC;

-- =========================================================
-- 09. Employee Revenue
-- =========================================================
WITH EmployeeRevenue AS
(
    SELECT
        employee_id,
        SUM(sales_amount) revenue
    FROM fact_sales
    GROUP BY employee_id
)
SELECT *
FROM EmployeeRevenue
ORDER BY revenue DESC;

-- =========================================================
-- 10. Product Sales Summary
-- =========================================================
WITH ProductSales AS
(
    SELECT
        product_id,
        SUM(quantity) qty,
        SUM(sales_amount) revenue
    FROM fact_sales
    GROUP BY product_id
)
SELECT *
FROM ProductSales
ORDER BY revenue DESC;

-- =========================================================
-- 11. Average Revenue by Store
-- =========================================================
WITH StoreRevenue AS
(
    SELECT
        store_id,
        AVG(sales_amount) avg_revenue
    FROM fact_sales
    GROUP BY store_id
)
SELECT *
FROM StoreRevenue
ORDER BY avg_revenue DESC;

-- =========================================================
-- 12. Average Profit by Product
-- =========================================================
WITH ProductProfit AS
(
    SELECT
        product_id,
        AVG(profit) avg_profit
    FROM fact_sales
    GROUP BY product_id
)
SELECT *
FROM ProductProfit
ORDER BY avg_profit DESC;

-- =========================================================
-- 13. Customer Order Count
-- =========================================================
WITH CustomerOrders AS
(
    SELECT
        customer_id,
        COUNT(order_id) total_orders
    FROM fact_sales
    GROUP BY customer_id
)
SELECT *
FROM CustomerOrders
ORDER BY total_orders DESC;

-- =========================================================
-- 14. Refund Summary
-- =========================================================
WITH RefundSummary AS
(
    SELECT
        product_id,
        SUM(refund_amount) refund
    FROM fact_returns
    GROUP BY product_id
)
SELECT *
FROM RefundSummary
ORDER BY refund DESC;

-- =========================================================
-- 15. Inventory Summary
-- =========================================================
WITH InventorySummary AS
(
    SELECT
        store_id,
        SUM(stock_available) stock
    FROM fact_inventory
    GROUP BY store_id
)
SELECT *
FROM InventorySummary
ORDER BY stock DESC;

-- =========================================================
-- 16. Top Customers (> 1 Million Revenue)
-- =========================================================
WITH CustomerRevenue AS
(
    SELECT
        customer_id,
        SUM(sales_amount) revenue
    FROM fact_sales
    GROUP BY customer_id
)
SELECT *
FROM CustomerRevenue
WHERE revenue > 1000000
ORDER BY revenue DESC;

-- =========================================================
-- 17. High Profit Products
-- =========================================================
WITH ProductProfit AS
(
    SELECT
        product_id,
        SUM(profit) profit
    FROM fact_sales
    GROUP BY product_id
)
SELECT *
FROM ProductProfit
WHERE profit > 500000
ORDER BY profit DESC;

-- =========================================================
-- 18. High Revenue Stores
-- =========================================================
WITH StoreRevenue AS
(
    SELECT
        store_id,
        SUM(sales_amount) revenue
    FROM fact_sales
    GROUP BY store_id
)
SELECT *
FROM StoreRevenue
WHERE revenue > 50000000
ORDER BY revenue DESC;

-- =========================================================
-- 19. Monthly Returns
-- =========================================================
WITH MonthlyReturns AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        COUNT(fr.return_id) total_returns
    FROM fact_returns fr
    JOIN dim_date dd
        ON fr.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT *
FROM MonthlyReturns
ORDER BY year_number, month_number;

-- =========================================================
-- 20. Monthly Inventory Received
-- =========================================================
WITH MonthlyInventory AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fi.stock_received) stock_received
    FROM fact_inventory fi
    JOIN dim_date dd
        ON fi.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT *
FROM MonthlyInventory
ORDER BY year_number, month_number;