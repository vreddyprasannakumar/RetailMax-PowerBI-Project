USE retailmaxdw;

-- =========================================================
-- CORRELATED SUBQUERIES
-- =========================================================

-- 01. Sales Greater Than Customer Average
SELECT
    fs.sales_id,
    fs.customer_id,
    fs.sales_amount
FROM fact_sales fs
WHERE fs.sales_amount >
(
    SELECT AVG(fs2.sales_amount)
    FROM fact_sales fs2
    WHERE fs2.customer_id = fs.customer_id
);

-- =========================================================
-- 02. Profit Greater Than Product Average
-- =========================================================
SELECT
    fs.sales_id,
    fs.product_id,
    fs.profit
FROM fact_sales fs
WHERE fs.profit >
(
    SELECT AVG(fs2.profit)
    FROM fact_sales fs2
    WHERE fs2.product_id = fs.product_id
);

-- =========================================================
-- 03. Quantity Greater Than Store Average
-- =========================================================
SELECT
    fs.sales_id,
    fs.store_id,
    fs.quantity
FROM fact_sales fs
WHERE fs.quantity >
(
    SELECT AVG(fs2.quantity)
    FROM fact_sales fs2
    WHERE fs2.store_id = fs.store_id
);

-- =========================================================
-- 04. Highest Sale Per Customer
-- =========================================================
SELECT
    fs.customer_id,
    fs.order_id,
    fs.sales_amount
FROM fact_sales fs
WHERE fs.sales_amount =
(
    SELECT MAX(fs2.sales_amount)
    FROM fact_sales fs2
    WHERE fs2.customer_id = fs.customer_id
);

-- =========================================================
-- 05. Highest Profit Per Product
-- =========================================================
SELECT
    fs.product_id,
    fs.sales_id,
    fs.profit
FROM fact_sales fs
WHERE fs.profit =
(
    SELECT MAX(fs2.profit)
    FROM fact_sales fs2
    WHERE fs2.product_id = fs.product_id
);

-- =========================================================
-- 06. Lowest Sale Per Store
-- =========================================================
SELECT
    fs.store_id,
    fs.sales_id,
    fs.sales_amount
FROM fact_sales fs
WHERE fs.sales_amount =
(
    SELECT MIN(fs2.sales_amount)
    FROM fact_sales fs2
    WHERE fs2.store_id = fs.store_id
);

-- =========================================================
-- 07. Products Costlier Than Category Average
-- =========================================================
SELECT
    dp.product_name,
    dp.selling_price
FROM dim_product dp
WHERE dp.selling_price >
(
    SELECT AVG(dp2.selling_price)
    FROM dim_product dp2
    WHERE dp2.category_id = dp.category_id
);

-- =========================================================
-- 08. Employees Earning Above Department Average
-- =========================================================
SELECT
    employee_id,
    first_name,
    salary
FROM dim_employee e
WHERE salary >
(
    SELECT AVG(e2.salary)
    FROM dim_employee e2
    WHERE e2.department = e.department
);

-- =========================================================
-- 09. Supplier Rating Above Region Average
-- =========================================================
SELECT
    supplier_name,
    supplier_rating
FROM dim_supplier s
WHERE supplier_rating >
(
    SELECT AVG(s2.supplier_rating)
    FROM dim_supplier s2
    WHERE s2.region_id = s.region_id
);

-- =========================================================
-- 10. Customers Ordering Above Their Average Quantity
-- =========================================================
SELECT
    fs.customer_id,
    fs.order_id,
    fs.quantity
FROM fact_sales fs
WHERE fs.quantity >
(
    SELECT AVG(fs2.quantity)
    FROM fact_sales fs2
    WHERE fs2.customer_id = fs.customer_id
);

-- =========================================================
-- 11. Products With Inventory Above Store Average
-- =========================================================
SELECT
    fi.product_id,
    fi.store_id,
    fi.stock_available
FROM fact_inventory fi
WHERE fi.stock_available >
(
    SELECT AVG(fi2.stock_available)
    FROM fact_inventory fi2
    WHERE fi2.store_id = fi.store_id
);

-- =========================================================
-- 12. Refund Above Product Average
-- =========================================================
SELECT
    fr.return_id,
    fr.product_id,
    fr.refund_amount
FROM fact_returns fr
WHERE fr.refund_amount >
(
    SELECT AVG(fr2.refund_amount)
    FROM fact_returns fr2
    WHERE fr2.product_id = fr.product_id
);

-- =========================================================
-- 13. Store Revenue Above Region Average
-- =========================================================
SELECT
    ds.store_name,
    SUM(fs.sales_amount) revenue
FROM fact_sales fs
JOIN dim_store ds
ON fs.store_id = ds.store_id
GROUP BY ds.store_id, ds.store_name
HAVING revenue >
(
    SELECT AVG(region_revenue)
    FROM
    (
        SELECT
            SUM(fs2.sales_amount) region_revenue
        FROM fact_sales fs2
        JOIN dim_store ds2
        ON fs2.store_id = ds2.store_id
        WHERE ds2.region_id = ds.region_id
        GROUP BY ds2.store_id
    ) x
);

-- =========================================================
-- 14. Product Profit Above Brand Average
-- =========================================================
SELECT
    dp.product_name
FROM dim_product dp
WHERE dp.cost_price >
(
    SELECT AVG(dp2.cost_price)
    FROM dim_product dp2
    WHERE dp2.brand = dp.brand
);

-- =========================================================
-- 15. Customer Spending Above Segment Average
-- =========================================================
SELECT
    dc.customer_id,
    CONCAT(dc.first_name,' ',dc.last_name) customer_name
FROM dim_customer dc
JOIN fact_sales fs
ON dc.customer_id = fs.customer_id
GROUP BY
    dc.customer_id,
    customer_name,
    dc.customer_segment
HAVING SUM(fs.sales_amount) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT
            SUM(fs2.sales_amount) customer_total
        FROM dim_customer dc2
        JOIN fact_sales fs2
        ON dc2.customer_id = fs2.customer_id
        WHERE dc2.customer_segment = dc.customer_segment
        GROUP BY dc2.customer_id
    ) y
);