-- Create tables with raw data from multiple CSV files in the bronze layer
-- Raw data has not been transformed. 

-- Customer Churn Prediction
-- Bronze Layer 

-- CUSTOMERS
-- Information about customers
CREATE TABLE IF NOT EXISTS bronze.customers (
    "CustomerID" INT PRIMARY KEY,
    "Name" VARCHAR(100),
    "Age" INT,
    "Gender" VARCHAR(10),
    "SignupDate" DATE,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- DATES
-- Date-related information
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

-- PRODUCT USAGE
-- Contains information about product usage by customers on specific dates.
-- Provides insights into how customers interact with specific products or services offered by a business.
-- NumLogins: Indicates the number of times the customer logged in or interacted with the product on the given date. 
    -- This could be applicable for services where customers need to log in to access functionalities.
-- Amount: Represents the amount associated with the product usage. 
    -- This could be monetary (e.g., amount spent on a service) or non-monetary (e.g., units consumed)
-- Example: 
    -- Customer A (identified by CustomerID 101) uses Product A (identified by ProductID 401) on 2023-01-01 (DateID 20230101).
    -- They logged in 5 times (NumLogins = 5) and the total amount spent was $150.00.

CREATE TABLE IF NOT EXISTS bronze.product_usage (
    "UsageID" INT PRIMARY KEY,-- DateID: A reference to the date on which the product usage occurred. 
    -- This links to the dates.csv where detailed date information is stored.
    "CustomerID" INT,
    "DateID" INT,
    "ProductID" INT,
    "NumLogins" INT,
    "Amount" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- PRODUCTS
-- Information about products
-- Each row represents a product with its name, category, and price
CREATE TABLE IF NOT EXISTS bronze.products (
    "ProductID" INT PRIMARY KEY,
    "ProductName" VARCHAR(100),
    "Category" VARCHAR(50),
    "Price" DECIMAL(10, 2),
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);

-- SUBSCRIPTIONS
-- Information about customer subscriptions
-- Each row represents a subscription of a customer, including its type (e.g., annual, monthly) and status (e.g., active, churned)
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

-- SUPPORT INTERACTIONS
-- Information about customer support interactions, detailing the issue type and the time taken for resolution for each support interaction (InteractionID)
-- InteractionID: Each row represents a support interaction
-- DateID: A reference to the date on which the product usage occurred. 
    -- This links to the dates.csv where detailed date information is stored.
CREATE TABLE IF NOT EXISTS bronze.support_interactions (
    "InteractionID" INT PRIMARY KEY,
    "CustomerID" INT,
    "DateID" INT,
    "IssueType" VARCHAR(100),
    "ResolutionTime" INT,
    "extracted_at" TIMESTAMP,
    "inserted_at" TIMESTAMP
);