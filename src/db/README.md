Installing and Setup for the Database
=====================================

This readme file containts the installation instructions for Postgres, 
as well as all of the setup instructions you need to create the required users, database, and tables.


Installing Postgres
-------------------
1. Download PostgresSQL 11 from here: https://www.postgresql.org/download/
    * Make sure that when you are configuring it you leave the port settings on 5432
    * Make sure that you memorize your login password
1. (OPTIONAL) Install pgAdmin 4 from here: https://www.pgadmin.org/download/
    * This is an optional step, because you can do everything from the command line
    * Make sure you **download pgAdmin 4 and NOT 3**
1. Done.


Setting up the Users and Database
---------------------------------
Run the script `create-users_postgres.sql`

Setting up the Tables (NO CONTENT)
---------------------
1. Login as either the `root user (postgres)` or `ece651_scraper` and run the script `./database-create_postgres.sql`

Setting up the Tables (WITH CONTENT)
---------------------
1. Set up the following variables:
    * **Windows:**
    ```
    set PGDATABASE=ece651
    set PGUSER=ece651_scraper
    set PGPASSWORD=wxJcTdJYUU3mMAsAa5YD
    ```
    * **Linux:**
    ```
    export PGDATABASE=ece651
    export PGUSER=ece651_scraper
    export PGPASSWORD=wxJcTdJYUU3mMAsAa5YD
    ```
1. Run the following scripts:
    1. `psql -q -f ./create_tables_insert_data/AmazonDetails.sql`
    1. `psql -q -f ./create_tables_insert_data/Author.sql`
    1. `psql -q -f ./create_tables_insert_data/AuthorBooks.sql`
    1. `psql -q -f ./create_tables_insert_data/BookCategories.sql`
    1. `psql -q -f ./create_tables_insert_data/BookOfTheDay.sql`
    1. `psql -q -f ./create_tables_insert_data/Books.sql`
    1. `psql -q -f ./create_tables_insert_data/Categories.sql`
    1. `psql -q -f ./create_tables_insert_data/Reviews.sql`
    1. `psql -q -f ./create_tables_insert_data/Users.sql`
    1. `psql -q -f ./create_tables_insert_data/Views.sql`
    1. `psql -q -f ./grant_tables_add_constraint.sql`
    1. `psql -q -f ./create_tables_insert_data/Recommendations.sql`

Testing your Connection
-----------------------
1. `pip install psycopg2 configparser requests xmltodict unidecode threading time datetime queue`
1. `python test_connection.py`
    ```
    >"C:/Program Files/Python36/python.exe" "d:/Work/Masters_Phd/workspace (GradSchool)/ece651-project/src/scraper/test_connection.py"
    Connecting to the PostgreSQL database...

    PostgreSQL database version:
    ('PostgreSQL 11.1, compiled by Visual C++ build 1914, 64-bit',)
    Database connection closed.
    ```
    * If you have an error, check google and then ask Jon if you still have trouble solving it


Adding/Updating Recommendations
===============================
Periodically the machine learning algorithm will need to be run to ensure that we have better recommendations.
To update your database run the following script (make sure your export settings are set above).

1. `psql -q -f ./create_tables_insert_data/Recommendations.sql`

Updating the Database
=====================
**Leave it to Jon**

If you are Jon, here are the steps:
1. Edit the WorkBench File
1. Export the SQL from WorkBench, uncheck all checkboxes
1. Convert to Postgres `python3 mysql_workbench_to_postgres.py database-create.sql --schema public`
    1. Remove line about creating the schema
1. If there isn't too much data in the database, and there is an automated way to reimport the data, then drop all tables in `ece651` and rerun the SQL script
1. Otherwise you will need to manually update each table that was changed and write a script to fill in an potentially NULL information

Manual Updates
--------------
You must make these changes to the postgres SQL file:
1. Replace this line:
    ```sql
    CREATE SCHEMA IF NOT EXISTS  "ece651"  ;
    ```
    with:
    ```sql
    CREATE SCHEMA IF NOT EXISTS  "public"  ;
    ```
1. Users table will not be finished, replace the end comma with a `);`
    ```sql
    CREATE TABLE  "public"."Users" (
    "user_id" INT NOT NULL ,
    "display_name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(200) NOT NULL,
    "password_hash" VARCHAR(65) NOT NULL,
    "password_salt" VARCHAR(50) NOT NULL,
    "creation_time" TIMESTAMP NOT NULL DEFAULT now(),
    "preferences_json" TEXT NOT NULL DEFAULT '{}',
    "created_from" TEXT NOT NULL,
    "login_allowed" int NOT NULL DEFAULT 0,
    PRIMARY KEY ("user_id"));
    ```
1. Add all unique columns at the end of the sql file: 
    ```sql
    ALTER TABLE public."Users" ADD CONSTRAINT unique_email UNIQUE (email);
    ```
1. Replace all TINYINT with INT