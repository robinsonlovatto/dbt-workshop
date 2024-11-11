# dbt-workshop


poetry init
pyenv local 3.12.1
poetry env use 3.12.1
poetry shell
poetry add dbt-postgres
dbt init # configura o projeto

cd northwind
dbt debug # to check config
dbt deps # to install dependencies before the first dbt run
dbt seed # load csv's in the folder seed to the database, it is also possible to create tables or edit based on the files. the name of the file must be the same as the name of the table.



