USE retailmaxdw;

-- =========================================================
-- 01. Total Revenue
-- =========================================================
SELECT ROUND(SUM(sales_amount),2) AS total_revenue
FROM fact_sales;

-- =========================================================
-- 02. Total Profit
-- =========================================================
SELECT ROUND(SUM(profit),2) AS total_profit
FROM fact_sales;

-- =========================================================
-- 03. Total Cost
-- =========================================================
SELECT ROUND(SUM(cost_amount),2) AS total_cost
FROM fact_sales;

-- =========================================================
-- 04. Total Discount Given
-- =========================================================
SELECT ROUND(SUM(discount),2) AS total_discount
FROM fact_sales;

-- =========================================================
-- 05. Total Orders
-- =========================================================
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM fact_sales;

-- =========================================================
-- 06. Total Sales Transactions
-- =========================================================
SELECT COUNT(*) AS total_transactions
FROM fact_sales;

-- =========================================================
-- 07. Total Units Sold
-- =========================================================
SELECT SUM(quantity) AS total_units_sold
FROM fact_sales;

-- =========================================================
-- 08. Average Order Value
-- =========================================================
SELECT ROUND(
    SUM(sales_amount) / COUNT(DISTINCT order_id),
    2
) AS average_order_value
FROM fact_sales;

-- =========================================================
-- 09. Average Profit Per Order
-- =========================================================
SELECT ROUND(
    SUM(profit) / COUNT(DISTINCT order_id),
    2
) AS average_profit_per_order
FROM fact_sales;

-- =========================================================
-- 10. Average Selling Price
-- =========================================================
SELECT ROUND(AVG(unit_price),2) AS average_selling_price
FROM fact_sales;

-- =========================================================
-- 11. Highest Sale
-- =========================================================
SELECT MAX(sales_amount) AS highest_sale
FROM fact_sales;

-- =========================================================
-- 12. Lowest Sale
-- =========================================================
SELECT MIN(sales_amount) AS lowest_sale
FROM fact_sales;

-- =========================================================
-- 13. Highest Profit
-- =========================================================
SELECT MAX(profit) AS highest_profit
FROM fact_sales;

-- =========================================================
-- 14. Lowest Profit
-- =========================================================
SELECT MIN(profit) AS lowest_profit
FROM fact_sales;

-- =========================================================
-- 15. Average Quantity Sold
-- =========================================================
SELECT ROUND(AVG(quantity),2) AS average_quantity
FROM fact_sales;

-- =========================================================
-- 16. Average Discount
-- =========================================================
SELECT ROUND(AVG(discount),2) AS average_discount
FROM fact_sales;

-- =========================================================
-- 17. Profit Margin %
-- =========================================================
SELECT ROUND(
    (SUM(profit) / SUM(sales_amount)) * 100,
    2
) AS profit_margin_percentage
FROM fact_sales;

-- =========================================================
-- 18. Total Returned Orders
-- =========================================================
SELECT COUNT(*) AS total_returns
FROM fact_returns;

-- =========================================================
-- 19. Total Refund Amount
-- =========================================================
SELECT ROUND(SUM(refund_amount),2) AS total_refund_amount
FROM fact_returns;

-- =========================================================
-- 20. Return Rate %
-- =========================================================
SELECT ROUND(
(
    (SELECT COUNT(*) FROM fact_returns) * 100.0
) /
(
    SELECT COUNT(*) FROM fact_sales
),
2) AS return_rate_percentage;