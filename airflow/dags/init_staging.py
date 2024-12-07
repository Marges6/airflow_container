from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.utils.dates import days_ago
from airflow.decorators import dag, task
from datetime import datetime, timedelta
import os

from utils.data_processing import load_data_in_batches_mssql_to_pgsql


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
    params = sql_params,
    template_searchpath = '/opt/airflow/sql_scripts'
)
def initialize_stg():
    
    #test_connection = test_pgsql_connection()

     
    create_stg_sales_tbl = SQLExecuteQueryOperator(
        task_id = 'create_staging_sales_tbl',
        conn_id = 'stg_postgres',
        hook_params = {"enable_log_db_messages": True},
        sql = "stg_sales_tbl.sql",
    )
    create_stg_customers_tbl = SQLExecuteQueryOperator(
        task_id = 'create_staging_customers_tbl',
        conn_id = 'stg_postgres',
        hook_params = {"enable_log_db_messages": True},
        sql = "stg_customers_tbl.sql"
    )

    create_stg_products_tbl = SQLExecuteQueryOperator(
        task_id = 'create_staging_products_tbl',
        conn_id = 'stg_postgres',
        hook_params = {"enable_log_db_messages": True},
        sql = "stg_products_tbl.sql"
    )


    @task
    def init_load_sales():
        load_data_in_batches_mssql_to_pgsql(stg_schema = 'arf', stg_table = 'stg_sales', source_script_query_dir = '/opt/airflow/sql_scripts/sales_source.sql')
        
    
    create_stg_customers_tbl >> create_stg_products_tbl >> create_stg_sales_tbl >> init_load_sales()

   


initialize_stg()



