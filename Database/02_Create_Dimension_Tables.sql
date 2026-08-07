CREATE TABLE dim_region (
    region_id INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(50) NOT NULL,
    zone_name VARCHAR(50) NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY AUTO_INCREMENT,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    region_id INT NOT NULL,
    opening_date DATE,
    store_type VARCHAR(30),
    manager_name VARCHAR(100),
    FOREIGN KEY (region_id)
        REFERENCES dim_region(region_id)
);
CREATE TABLE dim_category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    department_name VARCHAR(50) NOT NULL
);
CREATE TABLE dim_supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50),
    region_id INT,
    supplier_rating DECIMAL(3,2),
    FOREIGN KEY (region_id)
        REFERENCES dim_region(region_id)
);

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day_number TINYINT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    week_number TINYINT NOT NULL,
    month_number TINYINT NOT NULL,
    month_name VARCHAR(15) NOT NULL,
    quarter_number TINYINT NOT NULL,
    year_number SMALLINT NOT NULL,
    is_weekend BOOLEAN NOT NULL
);
CREATE TABLE dim_customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50),
    region_id INT,
    customer_segment ENUM('Regular','Silver','Gold','Platinum'),
    registration_date DATE,
    FOREIGN KEY(region_id)
        REFERENCES dim_region(region_id)
);

CREATE TABLE dim_employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    designation VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE,
    store_id INT,
    manager_id INT NULL,
    FOREIGN KEY(store_id)
        REFERENCES dim_store(store_id)
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    brand VARCHAR(50),
    category_id INT,
    supplier_id INT,
    cost_price DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    warranty_months INT,
    launch_date DATE,
    is_active BOOLEAN,
    FOREIGN KEY(category_id)
        REFERENCES dim_category(category_id),
    FOREIGN KEY(supplier_id)
        REFERENCES dim_supplier(supplier_id)
);

SHOW TABLES;

