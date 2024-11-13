from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.providers.microsoft.mssql.hooks.mssql import MsSqlHook
from airflow.utils.dates import days_ago
from airflow.decorators import dag, task
from datetime import datetime, timedelta

default_args = {
    'owner':'airflow',
    'tags':['mssql','postgres'],
    'start_date': days_ago(1)
}

sql_params = {
    'begin_date':'20110531',
    'end_date':'20110601'
}




@dag(
    default_args = default_args,
    catchup = False,
    schedule_interval = None,
)
def initialize_stg():

    @task
    def create_stg_sales_tbl():
        SQLExecuteQueryOperator(
            task_id = 'create_staging_sales_tbl',
            conn_id = 'stg_postgres',
            hook_params = {"enable_log_db_messages": True},
            sql = "sql_scripts/stg_sales_tbl.sql"
        )
    
    @task
    def create_stg_customers_tbl():
        SQLExecuteQueryOperator(
            task_id = 'create_staging_customers_tbl',
            conn_id = 'stg_postgres',
            hook_params = {"enable_log_db_messages": True},
            sql = "sql_scripts/stg_customers_tbl.sql"
        )

    @task
    def create_stg_products_tbl():
        SQLExecuteQueryOperator(
            task_id = 'create_staging_products_tbl',
            conn_id = 'stg_postgres',
            hook_params = {"enable_log_db_messages": True},
            sql = "sql_scripts/stg_products_tbl.sql"
        )

    @task
    def init_load_sales():
        SQLExecuteQueryOperator(
            task_id = 'init_load_stg_sales_tbl',
            conn_id = 'stg_postgres',
            hook_params = {"enable_log_db_messages": True},
            sql = ""
        )

    
    create_stg_sales

    def load_data_in_batches(source_table, stg_table, sql_script_dir, chunk_size=150):
        # Set up connections
        mssql_hook = MsSqlHook(mssql_conn_id='source_mssql')
        postgres_hook = PostgresHook(postgres_conn_id='stg_postgres')

        # Define SQL for MSSQL and PostgreSQL
        select_query = f"SELECT * FROM your_mssql_table"  # Replace with your actual table
        pg_insert_query = """
            INSERT INTO your_postgres_table (column1, column2, ...)
            VALUES (%s, %s, ...)
        """

        # MSSQL connection cursor
        mssql_conn = mssql_hook.get_conn()
        mssql_cursor = mssql_conn.cursor()
        mssql_cursor.execute(select_query)

        # Fetch data in chunks and insert into PostgreSQL
        while True:
            # Fetch a chunk of rows
            rows = mssql_cursor.fetchmany(chunk_size)
            if not rows:
                break  # Exit loop if there are no more rows

            # Insert into PostgreSQL
            postgres_hook.insert_rows(
                table='your_postgres_table',
                rows=rows,
                target_fields=['column1', 'column2', ...],  # List column names here
                commit_every=chunk_size Commit after each chunk
            )

        # Close the MSSQL connection
        mssql_cursor.close()
        mssql_conn.close()




initialize_stg()



