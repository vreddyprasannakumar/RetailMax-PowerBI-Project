USE retailmaxdw;

-- =========================================================
-- SUBQUERIES
-- =========================================================

-- 01. Products Costing More Than Average Cost
SELECT
    product_id,
    product_name,
    cost_price
FROM dim_product
WHERE cost_price >
(
    SELECT AVG(cost_price)
    FROM dim_product
);

-- 02. Products Selling Above Average Selling Price
SELECT
    product_id,
    product_name,
    selling_price
FROM dim_product
WHERE selling_price >
(
    SELECT AVG(selling_price)
    FROM dim_product
);

-- 03. Customers Who Purchased Something
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer
WHERE customer_id IN
(
    SELECT DISTINCT customer_id
    FROM fact_sales
);

-- 04. Customers Who Never Purchased
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer
WHERE customer_id NOT IN
(
    SELECT DISTINCT customer_id
    FROM fact_sales
);

-- 05. Products Never Sold
SELECT
    product_id,
    product_name
FROM dim_product
WHERE product_id NOT IN
(
    SELECT DISTINCT product_id
    FROM fact_sales
);

-- 06. Stores That Made Sales
SELECT
    store_id,
    store_name
FROM dim_store
WHERE store_id IN
(
    SELECT DISTINCT store_id
    FROM fact_sales
);

-- 07. Employees Who Never Made a Sale
SELECT
    employee_id,
    first_name,
    last_name
FROM dim_employee
WHERE employee_id NOT IN
(
    SELECT DISTINCT employee_id
    FROM fact_sales
);

-- 08. Products Returned At Least Once
SELECT
    product_id,
    product_name
FROM dim_product
WHERE product_id IN
(
    SELECT DISTINCT product_id
    FROM fact_returns
);

-- 09. Stores With Inventory Below Average
SELECT
    store_id,
    store_name
FROM dim_store
WHERE store_id IN
(
    SELECT store_id
    FROM fact_inventory
    GROUP BY store_id
    HAVING AVG(stock_available) <
    (
        SELECT AVG(stock_available)
        FROM fact_inventory
    )
);

-- 10. Sales Greater Than Average Sale
SELECT
    sales_id,
    order_id,
    sales_amount
FROM fact_sales
WHERE sales_amount >
(
    SELECT AVG(sales_amount)
    FROM fact_sales
);

-- 11. Profit Greater Than Average Profit
SELECT
    sales_id,
    order_id,
    profit
FROM fact_sales
WHERE profit >
(
    SELECT AVG(profit)
    FROM fact_sales
);

-- 12. Highest Revenue Product
SELECT
    product_id,
    product_name
FROM dim_product
WHERE product_id =
(
    SELECT product_id
    FROM fact_sales
    GROUP BY product_id
    ORDER BY SUM(sales_amount) DESC
    LIMIT 1
);

-- 13. Highest Revenue Store
SELECT
    store_id,
    store_name
FROM dim_store
WHERE store_id =
(
    SELECT store_id
    FROM fact_sales
    GROUP BY store_id
    ORDER BY SUM(sales_amount) DESC
    LIMIT 1
);

-- 14. Highest Revenue Customer
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer
WHERE customer_id =
(
    SELECT customer_id
    FROM fact_sales
    GROUP BY customer_id
    ORDER BY SUM(sales_amount) DESC
    LIMIT 1
);

-- 15. Products Above Maximum Category Average
SELECT
    product_name,
    selling_price
FROM dim_product
WHERE selling_price >
(
    SELECT AVG(selling_price)
    FROM dim_product
);

-- 16. Sales With Maximum Profit
SELECT *
FROM fact_sales
WHERE profit =
(
    SELECT MAX(profit)
    FROM fact_sales
);

-- 17. Sales With Minimum Profit
SELECT *
FROM fact_sales
WHERE profit =
(
    SELECT MIN(profit)
    FROM fact_sales
);

-- 18. Store With Highest Inventory
SELECT
    store_name
FROM dim_store
WHERE store_id =
(
    SELECT store_id
    FROM fact_inventory
    GROUP BY store_id
    ORDER BY SUM(stock_available) DESC
    LIMIT 1
);

-- 19. Product With Highest Inventory
SELECT
    product_name
FROM dim_product
WHERE product_id =
(
    SELECT product_id
    FROM fact_inventory
    GROUP BY product_id
    ORDER BY SUM(stock_available) DESC
    LIMIT 1
);

-- 20. Customers With Above Average Order Count
SELECT
    customer_id,
    first_name,
    last_name
FROM dim_customer
WHERE customer_id IN
(
    SELECT customer_id
    FROM fact_sales
    GROUP BY customer_id
    HAVING COUNT(order_id) >
    (
        SELECT AVG(order_count)
        FROM
        (
            SELECT COUNT(order_id) AS order_count
            FROM fact_sales
            GROUP BY customer_id
        ) t
    )
);