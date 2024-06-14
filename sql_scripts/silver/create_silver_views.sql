-- Create view to transform and clean customer data for silver layer
-- This view transforms and cleans the raw customer data from the bronze layer, 
-- preparing it for analysis and further processing. 
-- It includes attributes from the bronze layer along with additional derived attributes
-- such as customer status based on transaction and purchase history.
CREATE VIEW churn_silver.customer_summary AS
SELECT
    customer_id,
    age,
    gender,
    total_transactions,
    last_purchase_date,
    churn_status,
    CASE
        WHEN total_transactions >= 100 AND last_purchase_date >= '2023-01-01' THEN 'active'
        ELSE 'inactive'
    END AS customer_status
FROM churn_bronze.customer_data;