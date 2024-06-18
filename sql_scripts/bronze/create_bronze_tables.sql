-- Create tables with raw date from multiple CSV files in the bronze layer
-- raw data has not been transformed.

-- Customer Churn Prediction
CREATE TABLE IF NOT EXISTS bronze.customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    SignupDate DATE
);

CREATE TABLE IF NOT EXISTS bronze.subscriptions (
    SubscriptionID INT PRIMARY KEY,
    CustomerID INT,
    StartDate DATE,
    EndDate DATE,
    Type VARCHAR(50),
    Status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS bronze.product_usage (
    UsageID INT PRIMARY KEY,
    CustomerID INT,
    DateID INT,
    ProductID INT,
    NumLogins INT,
    Amount DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS bronze.support_interactions (
    InteractionID INT PRIMARY KEY,
    CustomerID INT,
    DateID INT,
    IssueType VARCHAR(100),
    ResolutionTime INT
);

CREATE TABLE IF NOT EXISTS bronze.dates (
    DateID INT PRIMARY KEY,
    Date DATE,
    Week INT,
    Month INT,
    Quarter INT,
    Year INT
);


-- Old
-- CREATE TABLE IF NOT EXISTS bronze.customer_data (
--     customer_id INT PRIMARY KEY,
--     age INT,
--     gender VARCHAR(10),
--     total_transactions INT,
--     last_purchase_date DATE,
--     churn_status INT -- If you want to insert as boolean, do it here. We put as 'int' to make it easier for Machine Learning
-- );
