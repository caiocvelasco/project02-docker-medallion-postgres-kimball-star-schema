-- Create table to aggregate customer data for gold layer

-- Prediction Target: Identify churned customers. 
    -- For example, a churned customer might be one who has not renewed their subscription for a certain period.

--  Identify Churned Customers
-- Note: Create a churn label (1 for churned, 0 for not churned).
-- A table to identify whether a customer has churned based on their subscription end date
-- If end date < current date, then we have a churn
CREATE TABLE IF NOT EXISTS gold.churn_customers AS
SELECT 
    dim_c.customer_id,
    dim_c.name,
    dim_c.age,
    dim_c.gender,
    dim_c.signup_date,
    fc_s.subscription_id,
    fc_s.type AS subscription_type,
    fc_s.start_date,
    fc_s.end_date,
    CASE
        WHEN fc_s.end_date IS NOT NULL AND fc_s.end_date < CURRENT_DATE THEN 1
        ELSE 0
    END AS is_churned
FROM silver.dim_customers dim_c
LEFT JOIN silver.fact_subscriptions fc_s ON dim_c.customer_id = fc_s.customer_id;

-- Aggregate Product Usage Data
-- This table aggregates product usage data by customers.
-- It includes total logins, average logins per day, total amount spent, and the span of usage days, for each customer.
CREATE TABLE IF NOT EXISTS gold.product_usage_features AS
SELECT 
    fc_pu.customer_id,                                                                  -- We will group by customer
    COUNT(fc_pu.usage_id)                                       AS total_logins,        -- Counts all instances of logins across all days for each customer.
    COUNT(DISTINCT fc_pu.date_id)                               AS total_days,          -- Counts the unique days a customer has logged product usage
    COUNT(fc_pu.usage_id) * 1.0 / COUNT(DISTINCT fc_pu.date_id) AS avg_logins_per_day,  -- Calculates the average logins per day by dividing total_logins by total_days. Multiplying by 1.0 ensures that the division is performed with decimal precision.
    SUM(fc_pu.amount)                                           AS total_spent,
    MAX(fc_pu.date_id) - MIN(fc_pu.date_id)                     AS usage_days_span
FROM silver.fact_product_usage fc_pu                                                    -- Source table: fact_product_usage from silver layer
GROUP BY fc_pu.customer_id;                                                             -- Grouping the results by customer ID

-- Aggregate Support Interactions Data
-- A table to aggregate support interaction features
CREATE TABLE IF NOT EXISTS gold.support_interaction_features AS
SELECT 
    fact_si.customer_id,                                          -- We will group by customer
    COUNT(fact_si.interaction_id) AS total_support_interactions,  -- Counts the number of support interactions per customer
    AVG(fact_si.resolution_time)  AS avg_resolution_time          -- Average time taken to resolve support issues for each customer
FROM silver.fact_support_interactions fact_si                     -- Source table: fact_support_interactions from silver layer
GROUP BY fact_si.customer_id;                                     -- Grouping the results by customer ID


-- Combine all the aggregated features into a single Gold table
CREATE TABLE IF NOT EXISTS gold.churn_features AS
SELECT 
    cc.customer_id,
    cc.name,
    cc.age,
    cc.gender,
    cc.signup_date,
    cc.subscription_type,
    cc.start_date,
    cc.end_date,
    cc.is_churned,
    puf.total_logins,
    puf.avg_logins_per_day,
    puf.total_spent,
    puf.usage_days_span,
    sif.total_support_interactions,
    sif.avg_resolution_time
FROM gold.churn_customers cc
LEFT JOIN gold.product_usage_features puf       ON cc.customer_id = puf.customer_id
LEFT JOIN gold.support_interaction_features sif ON cc.customer_id = sif.customer_id;