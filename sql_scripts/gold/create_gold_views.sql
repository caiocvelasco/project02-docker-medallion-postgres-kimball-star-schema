-- Create view to aggregate customer data for gold layer
CREATE VIEW churn_gold.aggregated_summary AS
SELECT
    customer_status,
    COUNT(*) AS customer_count,
    AVG(age) AS avg_age,
    AVG(total_transactions) AS avg_transactions
FROM churn_silver.customer_summary
GROUP BY customer_status;