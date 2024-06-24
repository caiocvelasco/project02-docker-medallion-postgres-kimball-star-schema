-- Create table to transform and clean customer data for silver layer
-- These tables transform and clean the raw customer data from the bronze layer, 
-- preparing it for analysis and further processing. 

-- Note: "CREATE OR REPLACE VIEW" is the correct syntax for PostgreSQL for Views (just in case).
-- Note: Columns names are quoted (e.g.: CustomerID is now "CustomerID"). 
-- -- This prevents errors such as UndefinedColumn when PostgreSQL tries to reference columns.

-- Customer Churn Prediction
-- Silver Layer

-- Following Kimball's Dimensional Modelling Approach (Star Schema) 
-- Dimensions
-- CUSTOMER 
CREATE TABLE IF NOT EXISTS silver.dim_customers (
    "customer_id" INT PRIMARY KEY,
    "name" VARCHAR(100),
    "age" INT,
    "gender" VARCHAR(10),
    "signup_date" DATE,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- DATES
CREATE TABLE IF NOT EXISTS silver.dim_dates (
    "date_id" INT PRIMARY KEY,
    "date" DATE,
    "week" INT,
    "month" INT,
    "quarter" INT,
    "year" INT,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- PRODUCTS
CREATE TABLE IF NOT EXISTS silver.dim_products (
    "product_id" INT PRIMARY KEY,
    "product_name" VARCHAR(100),
    "category" VARCHAR(50),
    "price" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- Facts
-- PRODUCT USAGE
-- Aggregates product usage metrics from the product_usage table in the bronze layer,
-- allowing analysis of customer interactions with products over time.
CREATE TABLE IF NOT EXISTS silver.fact_product_usage (
    "usage_id" INT PRIMARY KEY,
    "customer_id" INT,
    "date_id" INT,
    "product_id" INT,
    "num_logins" INT,
    "amount" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- SUPPORT INTERACTIONS
-- Aggregates support interaction data from the support_interactions table in the bronze layer,
-- providing insights into customer service performance and customer satisfaction trends.
CREATE TABLE IF NOT EXISTS silver.fact_support_interactions (
    "interaction_id" INT PRIMARY KEY,
    "customer_id" INT,
    "date_id" INT,
    "issue_type" VARCHAR(100),
    "resolution_time" INT,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- SUBSCRIPTIONS
-- Tracks subscription status (active or churned) over time based on data from the subscriptions table
-- in the bronze layer, facilitating churn analysis and subscription management insights.
CREATE TABLE IF NOT EXISTS silver.fact_subscriptions (
    "subscription_id" INT PRIMARY KEY,
    "customer_id" INT,
    "start_date" DATE,
    "end_date" DATE,
    "type" VARCHAR(50),
    "status" VARCHAR(50),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);



-- -- CUSTOMER 
-- CREATE TABLE IF NOT EXISTS silver.dim_customers (
--     "customer_id" INT PRIMARY KEY,
--     "name" VARCHAR(100),
--     "age" INT,
--     "gender" VARCHAR(10),
--     "signup_date" DATE,
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );

-- -- DATES
-- CREATE TABLE IF NOT EXISTS silver.dim_dates (
--     "date_id" INT PRIMARY KEY,
--     "date" DATE,
--     "week" INT,
--     "month" INT,
--     "quarter" INT,
--     "year" INT,
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );

-- -- PRODUCTS
-- CREATE TABLE IF NOT EXISTS silver.dim_products (
--     "product_id" INT PRIMARY KEY,
--     "product_name" VARCHAR(100),
--     "category" VARCHAR(50),
--     "price" DECIMAL(10, 2),
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );

-- -- Facts
-- -- PRODUCT USAGE
-- -- Aggregates product usage metrics from the product_usage table in the bronze layer,
-- -- allowing analysis of customer interactions with products over time.
-- CREATE TABLE IF NOT EXISTS silver.fact_product_usage (
--     "usage_id" INT PRIMARY KEY,
--     "customer_id" INT,
--     "date_id" INT,
--     "product_id" INT,
--     "num_logins" INT,
--     "amount" DECIMAL(10, 2),
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );


-- -- SUPPORT INTERACTIONS
-- -- Aggregates support interaction data from the support_interactions table in the bronze layer,
-- -- providing insights into customer service performance and customer satisfaction trends.
-- CREATE TABLE IF NOT EXISTS silver.fact_support_interactions (
--     "interaction_id" INT PRIMARY KEY,
--     "customer_id" INT,
--     "date_id" INT,
--     "issue_type" VARCHAR(100),
--     "resolution_time" INT,
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );

-- -- SUBSCRIPTIONS
-- -- Tracks subscription status (active or churned) over time based on data from the subscriptions table
-- -- in the bronze layer, facilitating churn analysis and subscription management insights.
-- CREATE TABLE IF NOT EXISTS silver.fact_subscriptions (
--     "subscription_id" INT PRIMARY KEY,
--     "customer_id" INT,
--     "start_date" DATE,
--     "end_date" DATE,
--     "type" VARCHAR(50),
--     "status" VARCHAR(50),
--     "extracted_at" TIMESTAMP,
--     "inserted_at" TIMESTAMP
-- );

-- old
-- CREATE OR REPLACE VIEW churn_silver.customer_summary AS
-- SELECT
--     customer_id,
--     age,
--     gender,
--     total_transactions,
--     last_purchase_date,
--     churn_status,
--     CASE
--         WHEN total_transactions >= 100 AND last_purchase_date >= '2023-01-01' THEN 'active'
--         ELSE 'inactive'
--     END AS customer_status
-- FROM churn_bronze.customer_data;