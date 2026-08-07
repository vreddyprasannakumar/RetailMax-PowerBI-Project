DESCRIBE dim_region;

INSERT INTO dim_region (region_name, zone_name)
VALUES
('Andhra Pradesh', 'South'),
('Telangana', 'South'),
('Karnataka', 'South'),
('Tamil Nadu', 'South'),
('Kerala', 'South'),
('Maharashtra', 'West'),
('Gujarat', 'West'),
('Rajasthan', 'North'),
('Delhi', 'North'),
('Uttar Pradesh', 'North'),
('West Bengal', 'East'),
('Odisha', 'East');

SELECT * FROM dim_region;

DESCRIBE dim_category;

INSERT INTO dim_category (category_name, department_name)
VALUES
('Mobiles', 'Electronics'),
('Laptops', 'Electronics'),
('Televisions', 'Electronics'),
('Refrigerators', 'Home Appliances'),
('Washing Machines', 'Home Appliances'),
('Kitchen Appliances', 'Home Appliances'),
('Furniture', 'Home & Living'),
('Men''s Fashion', 'Fashion'),
('Women''s Fashion', 'Fashion'),
('Grocery', 'FMCG');

SELECT * FROM dim_category;

DESCRIBE dim_supplier;

INSERT INTO dim_supplier
(supplier_name, contact_person, phone, email, city, region_id, supplier_rating)
VALUES
('Samsung India Pvt Ltd', 'Rahul Sharma', '9876500001', 'rahul@samsung.com', 'Hyderabad', 2, 4.80),
('Apple India Pvt Ltd', 'Amit Verma', '9876500002', 'amit@apple.com', 'Bangalore', 3, 4.90),
('Sony India Ltd', 'Priya Nair', '9876500003', 'priya@sony.com', 'Chennai', 4, 4.60),
('LG Electronics India', 'Suresh Kumar', '9876500004', 'suresh@lg.com', 'Mumbai', 6, 4.50),
('Dell Technologies', 'Anil Reddy', '9876500005', 'anil@dell.com', 'Hyderabad', 2, 4.70),
('HP India', 'Rohit Gupta', '9876500006', 'rohit@hp.com', 'Delhi', 9, 4.40),
('Godrej Appliances', 'Kiran Rao', '9876500007', 'kiran@godrej.com', 'Mumbai', 6, 4.30),
('Whirlpool India', 'Sneha Patel', '9876500008', 'sneha@whirlpool.com', 'Ahmedabad', 7, 4.20),
('Prestige Kitchen', 'Vijay Kumar', '9876500009', 'vijay@prestige.com', 'Bangalore', 3, 4.60),
('Reliance Retail Supply', 'Deepak Singh', '9876500010', 'deepak@reliance.com', 'Delhi', 9, 4.50),
('ITC Foods', 'Lakshmi Devi', '9876500011', 'lakshmi@itc.com', 'Kolkata', 11, 4.70),
('Tata Consumer Products', 'Arjun Mehta', '9876500012', 'arjun@tataconsumer.com', 'Mumbai', 6, 4.80);

SELECT *
FROM dim_supplier;

DESCRIBE dim_store;
INSERT INTO dim_store
(store_name, city, region_id, opening_date, store_type, manager_name)
VALUES
('RetailMax Bangalore Central', 'Bangalore', 3, '2022-01-15', 'Flagship', 'Ramesh Kumar'),
('RetailMax Hyderabad City', 'Hyderabad', 2, '2022-02-10', 'Flagship', 'Srinivas Rao'),
('RetailMax Chennai Express', 'Chennai', 4, '2022-03-20', 'Standard', 'Prakash Iyer'),
('RetailMax Kochi Mall', 'Kochi', 5, '2022-04-18', 'Standard', 'Anil Menon'),
('RetailMax Mumbai Central', 'Mumbai', 6, '2022-05-12', 'Flagship', 'Rajesh Mehta'),
('RetailMax Pune Plaza', 'Pune', 6, '2022-06-08', 'Standard', 'Vikas Patil'),
('RetailMax Ahmedabad One', 'Ahmedabad', 7, '2022-07-11', 'Standard', 'Harsh Patel'),
('RetailMax Jaipur Mall', 'Jaipur', 8, '2022-08-15', 'Standard', 'Deepak Sharma'),
('RetailMax Delhi Hub', 'Delhi', 9, '2022-09-05', 'Flagship', 'Amit Khanna'),
('RetailMax Noida Center', 'Noida', 10, '2022-10-14', 'Standard', 'Rahul Verma'),
('RetailMax Lucknow Plaza', 'Lucknow', 10, '2022-11-21', 'Standard', 'Abhishek Singh'),
('RetailMax Kolkata Central', 'Kolkata', 11, '2022-12-01', 'Flagship', 'Subhajit Roy'),
('RetailMax Bhubaneswar Mall', 'Bhubaneswar', 12, '2023-01-18', 'Standard', 'Manoj Das'),
('RetailMax Visakhapatnam', 'Visakhapatnam', 1, '2023-02-20', 'Standard', 'Naresh Reddy'),
('RetailMax Vijayawada', 'Vijayawada', 1, '2023-03-10', 'Standard', 'Kiran Kumar'),
('RetailMax Mysore', 'Mysore', 3, '2023-04-15', 'Express', 'Shiva Prasad'),
('RetailMax Coimbatore', 'Coimbatore', 4, '2023-05-19', 'Express', 'Senthil Kumar'),
('RetailMax Nashik', 'Nashik', 6, '2023-06-25', 'Express', 'Ganesh Patil'),
('RetailMax Surat', 'Surat', 7, '2023-07-08', 'Express', 'Nitin Shah'),
('RetailMax Warangal', 'Warangal', 2, '2023-08-14', 'Express', 'Mahesh Reddy');

SELECT * FROM dim_store;

DESCRIBE dim_employee;
SHOW CREATE TABLE dim_employee;

INSERT INTO dim_employee
(first_name, last_name, designation, department, salary, joining_date, store_id, manager_id)
VALUES
('Ramesh', 'Kumar', 'Store Manager', 'Sales', 85000.00, '2022-01-15', 1, NULL),
('Suresh', 'Reddy', 'Sales Executive', 'Sales', 35000.00, '2022-02-01', 1, 1),

('Priya', 'Sharma', 'Store Manager', 'Sales', 85000.00, '2022-02-10', 2, NULL),
('Anil', 'Verma', 'Sales Executive', 'Sales', 35000.00, '2022-03-01', 2, 3),

('Lakshmi', 'Nair', 'Store Manager', 'Sales', 85000.00, '2022-03-20', 3, NULL),
('Karthik', 'Rao', 'Sales Executive', 'Sales', 35000.00, '2022-04-01', 3, 5),

('Deepak', 'Patel', 'Store Manager', 'Sales', 85000.00, '2022-04-18', 4, NULL),
('Meena', 'Iyer', 'Sales Executive', 'Sales', 35000.00, '2022-05-01', 4, 7),

('Rahul', 'Singh', 'Store Manager', 'Sales', 85000.00, '2022-05-12', 5, NULL),
('Sneha', 'Joshi', 'Sales Executive', 'Sales', 35000.00, '2022-06-01', 5, 9);

SELECT * FROM dim_employee;

INSERT INTO dim_employee
(first_name, last_name, designation, department, salary, joining_date, store_id, manager_id)
VALUES
('Vikas', 'Patil', 'Store Manager', 'Sales', 85000.00, '2022-06-08', 6, NULL),
('Pooja', 'Desai', 'Sales Executive', 'Sales', 35000.00, '2022-06-20', 6, 11),

('Harsh', 'Patel', 'Store Manager', 'Sales', 85000.00, '2022-07-11', 7, NULL),
('Neha', 'Shah', 'Sales Executive', 'Sales', 35000.00, '2022-07-25', 7, 13),

('Deepak', 'Sharma', 'Store Manager', 'Sales', 85000.00, '2022-08-15', 8, NULL),
('Ritu', 'Meena', 'Sales Executive', 'Sales', 35000.00, '2022-08-28', 8, 15),

('Amit', 'Khanna', 'Store Manager', 'Sales', 85000.00, '2022-09-05', 9, NULL),
('Kavita', 'Malik', 'Sales Executive', 'Sales', 35000.00, '2022-09-20', 9, 17),

('Abhishek', 'Singh', 'Store Manager', 'Sales', 85000.00, '2022-10-14', 10, NULL),
('Nisha', 'Yadav', 'Sales Executive', 'Sales', 35000.00, '2022-10-30', 10, 19),

('Subhajit', 'Roy', 'Store Manager', 'Sales', 85000.00, '2022-11-21', 11, NULL),
('Ananya', 'Das', 'Sales Executive', 'Sales', 35000.00, '2022-12-05', 11, 21),

('Manoj', 'Das', 'Store Manager', 'Sales', 85000.00, '2022-12-15', 12, NULL),
('Sanjana', 'Mohanty', 'Sales Executive', 'Sales', 35000.00, '2023-01-05', 12, 23),

('Naresh', 'Reddy', 'Store Manager', 'Sales', 85000.00, '2023-01-20', 13, NULL),
('Keerthi', 'Rao', 'Sales Executive', 'Sales', 35000.00, '2023-02-01', 13, 25),

('Kiran', 'Kumar', 'Store Manager', 'Sales', 85000.00, '2023-02-10', 14, NULL),
('Divya', 'Reddy', 'Sales Executive', 'Sales', 35000.00, '2023-02-25', 14, 27),

('Shiva', 'Prasad', 'Store Manager', 'Sales', 85000.00, '2023-03-15', 15, NULL),
('Arun', 'Kumar', 'Sales Executive', 'Sales', 35000.00, '2023-03-28', 15, 29),

('Senthil', 'Kumar', 'Store Manager', 'Sales', 85000.00, '2023-04-15', 16, NULL),
('Priyanka', 'Nair', 'Sales Executive', 'Sales', 35000.00, '2023-04-28', 16, 31),

('Ganesh', 'Patil', 'Store Manager', 'Sales', 85000.00, '2023-05-10', 17, NULL),
('Asha', 'Kulkarni', 'Sales Executive', 'Sales', 35000.00, '2023-05-25', 17, 33),

('Nitin', 'Shah', 'Store Manager', 'Sales', 85000.00, '2023-06-08', 18, NULL),
('Bhavna', 'Patel', 'Sales Executive', 'Sales', 35000.00, '2023-06-22', 18, 35),

('Mahesh', 'Reddy', 'Store Manager', 'Sales', 85000.00, '2023-07-14', 19, NULL),
('Swathi', 'Rao', 'Sales Executive', 'Sales', 35000.00, '2023-07-28', 19, 37),

('Vinod', 'Gupta', 'Store Manager', 'Sales', 85000.00, '2023-08-01', 20, NULL),
('Pallavi', 'Singh', 'Sales Executive', 'Sales', 35000.00, '2023-08-15', 20, 39);

SELECT COUNT(*) AS total_employees
FROM dim_employee;

SELECT COUNT(*)
FROM dim_date;

DESCRIBE dim_customer;

SELECT *
FROM fact_sales
LIMIT 10;

DESCRIBE dim_product;

DESCRIBE fact_sales;





