CREATE TABLE fact_sales (
    sales_id BIGINT PRIMARY KEY AUTO_INCREMENT,

    order_id BIGINT NOT NULL,

    date_id INT NOT NULL,

    customer_id INT NOT NULL,

    product_id INT NOT NULL,

    employee_id INT NOT NULL,

    store_id INT NOT NULL,

    quantity INT NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    discount DECIMAL(10,2) DEFAULT 0,

    sales_amount DECIMAL(12,2) NOT NULL,

    cost_amount DECIMAL(12,2) NOT NULL,

    profit DECIMAL(12,2) NOT NULL,

    payment_mode VARCHAR(20),

    order_status VARCHAR(20),

    FOREIGN KEY(date_id)
        REFERENCES dim_date(date_id),

    FOREIGN KEY(customer_id)
        REFERENCES dim_customer(customer_id),

    FOREIGN KEY(product_id)
        REFERENCES dim_product(product_id),

    FOREIGN KEY(employee_id)
        REFERENCES dim_employee(employee_id),

    FOREIGN KEY(store_id)
        REFERENCES dim_store(store_id)
);

CREATE TABLE fact_returns (

    return_id BIGINT PRIMARY KEY AUTO_INCREMENT,

    sales_id BIGINT,

    date_id INT,

    customer_id INT,

    product_id INT,

    return_quantity INT,

    return_reason VARCHAR(100),

    refund_amount DECIMAL(10,2),

    FOREIGN KEY(sales_id)
        REFERENCES fact_sales(sales_id),

    FOREIGN KEY(date_id)
        REFERENCES dim_date(date_id),

    FOREIGN KEY(customer_id)
        REFERENCES dim_customer(customer_id),

    FOREIGN KEY(product_id)
        REFERENCES dim_product(product_id)

);

CREATE TABLE fact_inventory (

    inventory_id BIGINT PRIMARY KEY AUTO_INCREMENT,

    date_id INT,

    product_id INT,

    store_id INT,

    stock_received INT,

    stock_sold INT,

    stock_available INT,

    reorder_level INT,

    FOREIGN KEY(date_id)
        REFERENCES dim_date(date_id),

    FOREIGN KEY(product_id)
        REFERENCES dim_product(product_id),

    FOREIGN KEY(store_id)
        REFERENCES dim_store(store_id)

);







