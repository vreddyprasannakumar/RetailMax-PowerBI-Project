USE retailmaxdw;

-- =========================================================
-- WINDOW FUNCTIONS - PART 2
-- LAG | LEAD | FIRST_VALUE | LAST_VALUE
-- RUNNING TOTAL | MOVING AVERAGE
-- =========================================================

-- 01. Monthly Revenue
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
-- 02. Previous Month Revenue (LAG)
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
SELECT
    *,
    LAG(revenue) OVER(
        ORDER BY year_number, month_number
    ) previous_month_revenue
FROM MonthlyRevenue;

-- =========================================================
-- 03. Next Month Revenue (LEAD)
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
SELECT
    *,
    LEAD(revenue) OVER(
        ORDER BY year_number, month_number
    ) next_month_revenue
FROM MonthlyRevenue;

-- =========================================================
-- 04. Running Revenue
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    SUM(revenue) OVER(
        ORDER BY year_number, month_number
    ) running_revenue
FROM MonthlyRevenue;

-- =========================================================
-- 05. Running Profit
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
SELECT
    *,
    SUM(profit) OVER(
        ORDER BY year_number, month_number
    ) running_profit
FROM MonthlyProfit;

-- =========================================================
-- 06. 3-Month Moving Average Revenue
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    ROUND(
        AVG(revenue) OVER(
            ORDER BY year_number, month_number
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),2
    ) moving_average
FROM MonthlyRevenue;

-- =========================================================
-- 07. Revenue Difference from Previous Month
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    revenue -
    LAG(revenue) OVER(
        ORDER BY year_number, month_number
    ) revenue_difference
FROM MonthlyRevenue;

-- =========================================================
-- 08. Revenue Growth %
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    ROUND(
        (
            revenue -
            LAG(revenue) OVER(ORDER BY year_number,month_number)
        ) *100/
        LAG(revenue) OVER(ORDER BY year_number,month_number)
    ,2) growth_percent
FROM MonthlyRevenue;

-- =========================================================
-- 09. FIRST_VALUE Revenue
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    FIRST_VALUE(revenue)
    OVER(
        ORDER BY year_number,month_number
    ) first_month_revenue
FROM MonthlyRevenue;

-- =========================================================
-- 10. LAST_VALUE Revenue
-- =========================================================
WITH MonthlyRevenue AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    LAST_VALUE(revenue)
    OVER(
        ORDER BY year_number,month_number
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) last_month_revenue
FROM MonthlyRevenue;

-- =========================================================
-- 11. Running Units Sold
-- =========================================================
WITH MonthlyUnits AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.quantity) units_sold
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    SUM(units_sold)
    OVER(
        ORDER BY year_number,month_number
    ) running_units
FROM MonthlyUnits;

-- =========================================================
-- 12. Running Orders
-- =========================================================
WITH MonthlyOrders AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        COUNT(DISTINCT fs.order_id) orders_count
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    SUM(orders_count)
    OVER(
        ORDER BY year_number,month_number
    ) running_orders
FROM MonthlyOrders;

-- =========================================================
-- 13. Running Refund Amount
-- =========================================================
WITH MonthlyRefund AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fr.refund_amount) refund
    FROM fact_returns fr
    JOIN dim_date dd
        ON fr.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    SUM(refund)
    OVER(
        ORDER BY year_number,month_number
    ) running_refund
FROM MonthlyRefund;

-- =========================================================
-- 14. Running Inventory Received
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
SELECT
    *,
    SUM(stock_received)
    OVER(
        ORDER BY year_number,month_number
    ) running_stock
FROM MonthlyInventory;

-- =========================================================
-- 15. Running Profit Margin
-- =========================================================
WITH MonthlyData AS
(
    SELECT
        dd.year_number,
        dd.month_number,
        SUM(fs.sales_amount) revenue,
        SUM(fs.profit) profit
    FROM fact_sales fs
    JOIN dim_date dd
        ON fs.date_id = dd.date_id
    GROUP BY
        dd.year_number,
        dd.month_number
)
SELECT
    *,
    ROUND(
        SUM(profit) OVER(ORDER BY year_number,month_number)
        /
        SUM(revenue) OVER(ORDER BY year_number,month_number)
        *100,
    2) running_profit_margin
FROM MonthlyData;