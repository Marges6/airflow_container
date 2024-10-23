from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.utils.dates import days_ago

# Default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'start_date': days_ago(1),  # This sets the start date to one day ago to enable immediate DAG runs.
}

# Define the DAG
with DAG(
    dag_id="test_mssql_connection",
    default_args=default_args,
    schedule_interval=None,  # The DAG will not run on a schedule, it can be triggered manually.
    catchup=False,
    tags=["mssql", "adventureworks"]
) as dag:

    # Task: Get all countries from the AdventureWorks database
    get_all_countries = SQLExecuteQueryOperator(
        task_id="get_all_countries",
        conn_id="mssql_default",  # This should match the connection ID in Airflow
        sql="SELECT * FROM Person.CountryRegion;",
        hook_params={"enable_log_db_messages": True},
    )
    
    get_all_countries
