-- Create tables with raw data from multiple CSV files in the bronze layer
-- Raw data has not been transformed. 

-- Customer Churn Prediction
-- Bronze Layer 

CREATE TABLE IF NOT EXISTS bronze.customers (
    "CustomerID" INT PRIMARY KEY,
    "Name" VARCHAR(100),
    "Age" INT,
    "Gender" VARCHAR(10),
    "SignupDate" DATE,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bronze.subscriptions (
    "SubscriptionID" INT PRIMARY KEY,
    "CustomerID" INT,
    "StartDate" DATE,
    "EndDate" DATE,
    "Type" VARCHAR(50),
    "Status" VARCHAR(50),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bronze.product_usage (
    "UsageID" INT PRIMARY KEY,
    "CustomerID" INT,
    "DateID" INT,
    "ProductID" INT,
    "NumLogins" INT,
    "Amount" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bronze.support_interactions (
    "InteractionID" INT PRIMARY KEY,
    "CustomerID" INT,
    "DateID" INT,
    "IssueType" VARCHAR(100),
    "ResolutionTime" INT,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

CREATE TABLE IF NOT EXISTS bronze.dates (
    "DateID" INT PRIMARY KEY,
    "Date" DATE,
    "Week" INT,
    "Month" INT,
    "Quarter" INT,
    "Year" INT,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- Products
CREATE TABLE IF NOT EXISTS bronze.products (
    "ProductID" INT PRIMARY KEY,
    "ProductName" VARCHAR(100),
    "Category" VARCHAR(50),
    "Price" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);




-- -- Customers table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.customers (
--     customer_id INT PRIMARY KEY,
--     name VARCHAR(100),
--     age INT,
--     gender VARCHAR(10),
--     signup_date DATE,
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );

-- -- Subscriptions table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.subscriptions (
--     subscription_id INT PRIMARY KEY,
--     customer_id INT,
--     start_date DATE,
--     end_date DATE,
--     type VARCHAR(50),
--     status VARCHAR(50),
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );

-- -- Product usage table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.product_usage (
--     usage_id INT PRIMARY KEY,
--     customer_id INT,
--     date_id INT,
--     product_id INT,
--     num_logins INT,
--     amount DECIMAL(10, 2),
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );

-- -- Support interactions table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.support_interactions (
--     interaction_id INT PRIMARY KEY,
--     customer_id INT,
--     date_id INT,
--     issue_type VARCHAR(100),
--     resolution_time INT,
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );

-- -- Dates table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.dates (
--     date_id INT PRIMARY KEY,
--     date DATE,
--     week INT,
--     month INT,
--     quarter INT,
--     year INT,
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );

-- -- Products table in bronze layer
-- CREATE TABLE IF NOT EXISTS bronze.products (
--     product_id INT PRIMARY KEY,
--     product_name VARCHAR(100),
--     category VARCHAR(50),
--     price DECIMAL(10, 2),
--     extracted_at TIMESTAMP,
--     inserted_at TIMESTAMP
-- );



-- Old
-- CREATE TABLE IF NOT EXISTS bronze.customer_data (
--     customer_id INT PRIMARY KEY,
--     age INT,
--     gender VARCHAR(10),
--     total_transactions INT,
--     last_purchase_date DATE,
--     churn_status INT -- If you want to insert as boolean, do it here. We put as 'int' to make it easier for Machine Learning
-- );