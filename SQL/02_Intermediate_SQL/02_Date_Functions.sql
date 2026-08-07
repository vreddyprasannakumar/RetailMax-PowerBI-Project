USE retailmaxdw;

-- =========================================================
-- DATE FUNCTIONS
-- =========================================================

-- 01. Revenue by Year
SELECT
    dd.year_number,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY dd.year_number
ORDER BY dd.year_number;

-- =========================================================
-- 02. Revenue by Quarter
-- =========================================================
SELECT
    dd.year_number,
    dd.quarter_number,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.quarter_number
ORDER BY
    dd.year_number,
    dd.quarter_number;

-- =========================================================
-- 03. Revenue by Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 04. Revenue by Week Number
-- =========================================================
SELECT
    dd.week_number,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY dd.week_number
ORDER BY dd.week_number;

-- =========================================================
-- 05. Revenue by Day Name
-- =========================================================
SELECT
    dd.day_name,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY dd.day_name
ORDER BY revenue DESC;

-- =========================================================
-- 06. Weekend vs Weekday Revenue
-- =========================================================
SELECT
    CASE
        WHEN dd.is_weekend = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY day_type;

-- =========================================================
-- 07. Orders by Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    COUNT(DISTINCT fs.order_id) AS total_orders
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 08. Profit by Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    ROUND(SUM(fs.profit),2) AS total_profit
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 09. Units Sold by Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    SUM(fs.quantity) AS units_sold
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 10. Average Daily Revenue
-- =========================================================
SELECT
    dd.full_date,
    ROUND(SUM(fs.sales_amount),2) AS daily_revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY dd.full_date
ORDER BY dd.full_date;

-- =========================================================
-- 11. Monthly Average Order Value
-- =========================================================
SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    ROUND(AVG(fs.sales_amount),2) AS avg_order_value
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 12. Top Revenue Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_name,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY revenue DESC
LIMIT 1;

-- =========================================================
-- 13. Lowest Revenue Month
-- =========================================================
SELECT
    dd.year_number,
    dd.month_name,
    ROUND(SUM(fs.sales_amount),2) AS revenue
FROM fact_sales fs
JOIN dim_date dd
ON fs.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY revenue
LIMIT 1;

-- =========================================================
-- 14. Monthly Return Count
-- =========================================================
SELECT
    dd.year_number,
    dd.month_name,
    COUNT(fr.return_id) AS total_returns
FROM fact_returns fr
JOIN dim_date dd
ON fr.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

-- =========================================================
-- 15. Monthly Refund Amount
-- =========================================================
SELECT
    dd.year_number,
    dd.month_name,
    ROUND(SUM(fr.refund_amount),2) AS refund_amount
FROM fact_returns fr
JOIN dim_date dd
ON fr.date_id = dd.date_id
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;