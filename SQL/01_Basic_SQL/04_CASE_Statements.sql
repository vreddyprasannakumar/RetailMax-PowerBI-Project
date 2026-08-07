USE retailmaxdw;

-- =========================================================
-- CASE STATEMENTS
-- =========================================================

-- 01. Profit Status
SELECT
    sales_id,
    profit,
    CASE
        WHEN profit < 0 THEN 'Loss'
        WHEN profit BETWEEN 0 AND 500 THEN 'Low Profit'
        WHEN profit BETWEEN 501 AND 2000 THEN 'Medium Profit'
        ELSE 'High Profit'
    END AS profit_status
FROM fact_sales;

-- 02. Discount Category
SELECT
    sales_id,
    discount,
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 1000 THEN 'Low Discount'
        WHEN discount <= 5000 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_category
FROM fact_sales;

-- 03. Order Size
SELECT
    order_id,
    quantity,
    CASE
        WHEN quantity = 1 THEN 'Single Item'
        WHEN quantity BETWEEN 2 AND 5 THEN 'Medium Order'
        ELSE 'Bulk Order'
    END AS order_size
FROM fact_sales;

-- 04. Customer Age Group
SELECT
    customer_id,
    first_name,
    last_name,
    TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS age,
    CASE
        WHEN TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) < 25 THEN 'Young'
        WHEN TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) BETWEEN 25 AND 40 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group
FROM dim_customer;

-- 05. Inventory Status
SELECT
    inventory_id,
    stock_available,
    reorder_level,
    CASE
        WHEN stock_available <= reorder_level THEN 'Reorder Required'
        ELSE 'Stock Available'
    END AS inventory_status
FROM fact_inventory;

-- 06. Return Status
SELECT
    return_id,
    refund_amount,
    CASE
        WHEN refund_amount < 1000 THEN 'Low Refund'
        WHEN refund_amount < 5000 THEN 'Medium Refund'
        ELSE 'High Refund'
    END AS refund_category
FROM fact_returns;

-- 07. Customer Segment Label
SELECT
    customer_id,
    customer_segment,
    CASE
        WHEN customer_segment='Regular' THEN 'Bronze'
        WHEN customer_segment='Silver' THEN 'Silver'
        WHEN customer_segment='Gold' THEN 'Gold'
        ELSE 'Premium'
    END AS loyalty_level
FROM dim_customer;

-- 08. Employee Salary Band
SELECT
    employee_id,
    first_name,
    salary,
    CASE
        WHEN salary < 30000 THEN 'Low'
        WHEN salary < 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_band
FROM dim_employee;

-- 09. Product Price Category
SELECT
    product_name,
    selling_price,
    CASE
        WHEN selling_price < 1000 THEN 'Budget'
        WHEN selling_price < 10000 THEN 'Mid Range'
        ELSE 'Premium'
    END AS price_category
FROM dim_product;

-- 10. Weekend or Weekday
SELECT
    date_id,
    full_date,
    CASE
        WHEN is_weekend=1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type
FROM dim_date;

-- 11. Store Size
SELECT
    store_name,
    CASE
        WHEN store_type='Mall' THEN 'Large Store'
        WHEN store_type='Standalone' THEN 'Medium Store'
        ELSE 'Small Store'
    END AS store_size
FROM dim_store;

-- 12. Supplier Rating
SELECT
    supplier_name,
    supplier_rating,
    CASE
        WHEN supplier_rating>=4.5 THEN 'Excellent'
        WHEN supplier_rating>=3.5 THEN 'Good'
        ELSE 'Average'
    END AS supplier_grade
FROM dim_supplier;

-- 13. Payment Type
SELECT
    order_id,
    payment_mode,
    CASE
        WHEN payment_mode='UPI' THEN 'Digital'
        WHEN payment_mode='Cash' THEN 'Offline'
        ELSE 'Card/Bank'
    END AS payment_type
FROM fact_sales;

-- 14. Order Completion
SELECT
    order_id,
    order_status,
    CASE
        WHEN order_status='Completed' THEN 'Successful'
        ELSE 'Unsuccessful'
    END AS status
FROM fact_sales;

-- 15. Region Zone
SELECT
    region_name,
    zone_name,
    CASE
        WHEN zone_name='South' THEN 'Southern India'
        WHEN zone_name='North' THEN 'Northern India'
        WHEN zone_name='East' THEN 'Eastern India'
        ELSE 'Western India'
    END AS region_group
FROM dim_region;