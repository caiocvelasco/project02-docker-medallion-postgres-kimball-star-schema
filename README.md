# ETL Pipeline with Medallion Architecture & Star Schema (with Dockerized Postgres, Jupyter Notebook, and Python). 

<img src = "img/project02-XYZ.png">

## Table of Contents

- [Project Structure](#Project-Structure)
- [Setup Instructions](#Setup-Instructions)
  - [Prerequisites](#Prerequisites)
  - [Environment Variables](#Environment-Variables)
  - [Build and Run](#Build-and-Run)
- [Services](#services)
- [Project Definition](#Project-Definition)
  - [Medallion Architecture](#Medallion-Architecture)
  - [Creating Schemas-Tables-Views](#Creating-Schemas-Tables-Views)
  - [Ingesting Data](#Ingesting-Data)
  - [The ETL Jupyter Notebook](#The-ETL-Jupyter-Notebook)
  - [The ETL Process](#The-ETL-Process)
  

## Project Structure

- **name_of_your_project_repo (project-root)/**
    - **.devcontainer/**
      - devcontainer.json
    - **sql_scripts/**
      - **schemas/**
        - create_schemas.sql
      - **bronze/**
        - create_bronze_tables.sql
      - **silver/**
        - create_silver_views.sql
      - **gold/**
        - create_gold_views.sql
    - **data/**
      - **raw/**
        - the_raw_CSV_files.csv
    - **img/**
      - your_README_images.png
    - **your_jup_notebooks/**
      - etl_pipeline.ipynb
    - **run_sql_scripts**
    - **.env**
    - **.gitignore**
    - **.python-version**
    - **Dockerfile**
    - **docker-compose.yml**
    - **requirements.txt**
    - **README.md**

## Setup Instructions

### Prerequisites

Make sure you have the following installed on your local development environment:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [VSCode](https://code.visualstudio.com/) with the [Remote - Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

Make sure to inclue a .gitignore file with the following information:
- *.pyc (to ignore python bytecode files)
- .env (to ignore sensitive information, such as database credentials)
- data/* (to ignore the source data, such as CSV files)

### Environment Variables

The .gitignore file, ignores the ´.env´ file for security reasons. However, since this is just for educational purposes, follow the step below to include it in your project. If you do not include it, the docker will not work.

Create a `.env` file in the project root with the following content:

- POSTGRES_USER=your_postgres_user
- POSTGRES_PASSWORD=your_postgres_password
- POSTGRES_DB=your_postgres_db
- POSTGRES_HOST=postgres
- JUPYTER_TOKEN=123

### Build and Run

1. **Clone the repository:**

   ```bash
   git clone https://github.com/caiocvelasco/project02-docker-medallion-postgres-kimball-star-schema.git
   cd my-first-docker-project

2. **Build and start the containers:**

    When you open VSCode, it will automatically ask if you want to reopen the repo folder in a container and it will build for you.

    **Note:** I have included the command `"postCreateCommand": "docker image prune -f"` in the __.devcontainer.json__ file. Therefore, whenever the docker containeirs are rebuilt this command will make sure to delete the `unused (dangling)` images. The `-f` argument ensures you don't need to confirm if you want to perform this action.

### Services

- **Postgres**: 
  - A PostgreSQL database instance.
  - Docker exposes port 5432 of the PostgreSQL container to port 5432 on your host machine. This makes service is accessible via `localhost:5432` on your local machine for visualization tools such as PowerBI and Tableau. However, within the docker container environment, the other services will use the postgres _hostname_ as specified in the `.env` file (`POSTGRES_HOST`).
  - To test the database from within the container's terminal: `psql -h $POSTGRES_HOST -p 5432 -U $POSTGRES_USER -d $POSTGRES_DB`
- **Python**: A container running Python 3.9.13 with necessary dependencies.
- **Jupyter Notebook**: A Jupyter Notebook instance to build your ETL Pipeline and interact with the data. 

## Project Definition

### Medallion Architecture
  * I created 3 schemas within the PostgreSQL database to mimic the Medallion Architecture (bronze, silver, and gold layers) usually found in Data Warehouse solutions. 
  * The schemas can be found within the __sql_scripts__ folder and are called:
    * bronze (the raw layer, where we store raw data, no transformations)
    * silver (the data model layer, where we transform the data following the Star Schema Data Model (Kimball), a type of Dimensional Modelling)
    * gold (the analytics layer, where we build the final tables ready to be consumed by analysts)

### Creating Schemas-Tables-Views
  * Step 1: Running __run_sql_scripts.sh__
    * You should run the __run_sql_scripts.sh__ file within the docker container's terminal. It will request the password for each time it tries to run a DDL (CREATE SCHEMA, CREATE TABLE, CREATE VIEW) from within the shell file.

### Ingesting Data
  * Step 2: Running __data_ingestion__ jupyter notebook
    * You should run the this notebook file in order to ingest data into the first layer of the Medallion Architecture.

### The ETL Jupyter Notebook
  The jupyter notebook that performs the ETL process is located under the `project-root > your_jupyter_notebooks` folder. 

### The ETL Process
  The __etl_pipeline_medallion__ jupyter notebook contains 3 functions that perform the 3 parts of the ETL process. In this case, extracting from a CSV file into a Python DataFrame, then transforming it, then loading it to a PostgreSQL database.