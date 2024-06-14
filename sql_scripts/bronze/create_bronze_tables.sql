-- Create table for raw customer data in the bronze layer
-- This table contains raw customer data as it comes into the system
-- without any processing or transformations. Each row represents a customer
-- and includes attributes such as customer ID, age, gender, total transactions,
-- last purchase date, and churn status.
CREATE TABLE IF NOT EXISTS churn_bronze.customer_data (
    customer_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    total_transactions INT,
    last_purchase_date DATE,
    churn_status BOOLEAN
);
