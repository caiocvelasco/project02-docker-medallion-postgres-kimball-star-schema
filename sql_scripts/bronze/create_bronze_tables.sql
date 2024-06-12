CREATE TABLE bronze.raw_data (
    id SERIAL PRIMARY KEY,
    raw_field1 TEXT,
    raw_field2 TEXT,
    ingestion_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
