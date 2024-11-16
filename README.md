# dbt-workshop

## starting from scratch
```
poetry init

pyenv local 3.12.1

poetry env use 3.12.1

poetry shell

poetry add dbt-postgres

# config the project (inclusive db connection). So, it is needed to create a database before that. I used Postgres in AWS RDS and the script sql\northwind.sql to create tables and data.
dbt init 

cd northwind

# to check config
dbt debug 

# to install dependencies before the first dbt run
dbt deps 

# load csv's in the folder seed to the database, it is also possible to create tables or edit based on the files. the name of the file must be the same as the name of the table. The region_new_table file in the folder seed will create a table with the name of the file.
dbt seed 

# default command to run the transformations
dbt run


# drop the tables and populate it again (for changes in the schema and backfilling)
dbt run -f 
```