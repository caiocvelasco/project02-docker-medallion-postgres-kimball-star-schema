CREATE VIEW silver.cleaned_data AS
SELECT 
    id,
    CAST(raw_field1 AS INTEGER) AS cleaned_field1,
    raw_field2 AS cleaned_field2,
    ingestion_timestamp
FROM bronze.raw_data
WHERE raw_field1 IS NOT NULL;
