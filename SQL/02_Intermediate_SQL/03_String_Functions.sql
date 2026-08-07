USE retailmaxdw;

-- =========================================================
-- STRING FUNCTIONS
-- =========================================================

-- 01. Customer Full Name
SELECT
    customer_id,
    CONCAT(first_name,' ',last_name) AS customer_name
FROM dim_customer;

-- =========================================================
-- 02. Employee Full Name
-- =========================================================
SELECT
    employee_id,
    CONCAT(first_name,' ',last_name) AS employee_name
FROM dim_employee;

-- =========================================================
-- 03. Customer Name in Uppercase
-- =========================================================
SELECT
    UPPER(CONCAT(first_name,' ',last_name)) AS customer_name
FROM dim_customer;

-- =========================================================
-- 04. Customer Name in Lowercase
-- =========================================================
SELECT
    LOWER(CONCAT(first_name,' ',last_name)) AS customer_name
FROM dim_customer;

-- =========================================================
-- 05. Product Name Length
-- =========================================================
SELECT
    product_name,
    LENGTH(product_name) AS name_length
FROM dim_product
ORDER BY name_length DESC;

-- =========================================================
-- 06. First 10 Characters of Product Name
-- =========================================================
SELECT
    product_name,
    LEFT(product_name,10) AS short_name
FROM dim_product;

-- =========================================================
-- 07. Last 8 Characters of Product Name
-- =========================================================
SELECT
    product_name,
    RIGHT(product_name,8) AS ending_text
FROM dim_product;

-- =========================================================
-- 08. Customer Initials
-- =========================================================
SELECT
    CONCAT(
        LEFT(first_name,1),
        LEFT(last_name,1)
    ) AS initials
FROM dim_customer;

-- =========================================================
-- 09. Extract Email Domain
-- =========================================================
SELECT
    email,
    SUBSTRING_INDEX(email,'@',-1) AS email_domain
FROM dim_customer;

-- =========================================================
-- 10. Brand Name in Uppercase
-- =========================================================
SELECT
    brand,
    UPPER(brand) AS brand_upper
FROM dim_product;

-- =========================================================
-- 11. Customer Phone Last 4 Digits
-- =========================================================
SELECT
    phone,
    RIGHT(phone,4) AS last_four_digits
FROM dim_customer;

-- =========================================================
-- 12. Product Search (Contains 'Pro')
-- =========================================================
SELECT
    product_name
FROM dim_product
WHERE product_name LIKE '%Pro%';

-- =========================================================
-- 13. Customers Starting with A
-- =========================================================
SELECT
    first_name,
    last_name
FROM dim_customer
WHERE first_name LIKE 'A%';

-- =========================================================
-- 14. Employees Ending with 'Kumar'
-- =========================================================
SELECT
    first_name,
    last_name
FROM dim_employee
WHERE last_name LIKE '%Kumar';

-- =========================================================
-- 15. Remove Leading and Trailing Spaces
-- =========================================================
SELECT
    TRIM(product_name) AS clean_product_name
FROM dim_product;

-- =========================================================
-- 16. Replace Gmail with Company Mail
-- =========================================================
SELECT
    email,
    REPLACE(email,'gmail.com','retailmax.com') AS company_email
FROM dim_customer;

-- =========================================================
-- 17. Count Characters in Brand
-- =========================================================
SELECT
    brand,
    CHAR_LENGTH(brand) AS total_characters
FROM dim_product;

-- =========================================================
-- 18. Reverse Customer Name
-- =========================================================
SELECT
    CONCAT(first_name,' ',last_name) AS customer_name,
    REVERSE(CONCAT(first_name,' ',last_name)) AS reversed_name
FROM dim_customer;

-- =========================================================
-- 19. Product Name Without Spaces
-- =========================================================
SELECT
    product_name,
    REPLACE(product_name,' ','') AS product_code
FROM dim_product;

-- =========================================================
-- 20. Supplier Contact Summary
-- =========================================================
SELECT
    CONCAT(
        supplier_name,
        ' - ',
        city,
        ' - ',
        phone
    ) AS supplier_summary
FROM dim_supplier;