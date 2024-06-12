CREATE VIEW gold.aggregated_data AS
SELECT 
    cleaned_field1,
    cleaned_field2,
    COUNT(*) AS record_count,
    MAX(ingestion_timestamp) AS last_ingestion
FROM silver.cleaned_data
GROUP BY cleaned_field1, cleaned_field2;
