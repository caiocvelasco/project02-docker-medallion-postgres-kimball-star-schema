-- Create view to transform and clean customer data for silver layer
-- These views transform and clean the raw customer data from the bronze layer, 
-- preparing it for analysis and further processing. 

-- Note: "CREATE OR REPLACE VIEW" is the correct syntax for PostgreSQL.
-- Note: Columns names are quoted (e.g.: CustomerID is now "CustomerID"). 
-- -- This prevents errors such as UndefinedColumn when PostgreSQL tries to reference columns.

-- Customer Churn Prediction
-- Silver Layer

-- Folowing Kimball's Dimensional Modelling Approach (Star Schema) 
-- Dimensions
-- CUSTOMER
CREATE OR REPLACE VIEW silver.dim_customers AS
SELECT
    "CustomerID" AS customer_id,
    "Name" AS name,
    "Age" AS age,
    "Gender" AS gender,
    "SignupDate" AS signup_date
FROM bronze.customers;

-- DATES
CREATE OR REPLACE VIEW silver.dim_dates AS
SELECT
    "DateID" AS date_id,
    "Date" AS date,
    "Week" AS week,
    "Month" AS month,
    "Quarter" AS quarter,
    "Year" AS year
FROM bronze.dates;

-- PRODUCTS
CREATE OR REPLACE VIEW silver.dim_products AS
SELECT
    "ProductID" AS product_id,
    "ProductName" AS product_name,
    "Category" AS category,
    "Price" AS price
FROM bronze.products;

-- Facts
-- PRODUCT USAGE
-- Aggregates product usage metrics from the product_usage table in the bronze layer,
-- allowing analysis of customer interactions with products over time.
CREATE OR REPLACE VIEW silver.fact_product_usage AS
SELECT
    "UsageID" AS usage_id,
    "CustomerID" AS customer_id,
    "DateID" AS date_id,
    "ProductID" AS product_id,
    "NumLogins" AS num_logins,
    "Amount" AS amount
FROM bronze.product_usage;

-- SUPPORT INTERACTIONS
-- Aggregates support interaction data from the support_interactions table in the bronze layer,
-- providing insights into customer service performance and customer satisfaction trends.
CREATE OR REPLACE VIEW silver.fact_support_interactions AS
SELECT
    "InteractionID" AS interaction_id,
    "CustomerID" AS customer_id,
    "DateID" AS date_id,
    "IssueType" AS issue_type,
    "ResolutionTime" AS resolution_time
FROM bronze.support_interactions;

-- SUBSCRIPTIONS
-- Tracks subscription status (active or churned) over time based on data from the subscriptions table
-- in the bronze layer, facilitating churn analysis and subscription management insights.
CREATE OR REPLACE VIEW silver.fact_subscriptions AS
SELECT
    "SubscriptionID" AS subscription_id,
    "CustomerID" AS customer_id,
    "StartDate" AS start_date,
    "EndDate" AS end_date,
    "Type" AS type,
    "Status" AS status
FROM bronze.subscriptions;

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