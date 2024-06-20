#!/bin/bash

# Function to run SQL scripts
run_sql_script() {
    local script_name="$1"
    local script_path="./sql_scripts/$script_name"
    
    echo "Running SQL script: $script_name"
    
    # Load environment variables from .env file
    set -o allexport; source .env; set +o allexport
    
    # Run SQL script using psql
    psql -U "$POSTGRES_USER" -d "$POSTGRES_DB" -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -f "$script_path"
}

# Run create_schemas.sql
run_sql_script "schemas/create_schemas.sql"

# Run create_bronze_tables.sql
run_sql_script "bronze/create_bronze_tables.sql"

# # Run create_silver_views.sql
# run_sql_script "silver/create_silver_views.sql"

# # Run create_gold_views.sql
# run_sql_script "gold/create_gold_views.sql"