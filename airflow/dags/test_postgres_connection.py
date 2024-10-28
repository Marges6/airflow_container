from airflow import DAG
from airflow.providers.common.sql.operators.sql import SQLExecuteQueryOperator
from airflow.utils.dates import days_ago


default_args= {
    'owner': 'airflow',
    'start_date': days_ago(1)
    }


with DAG(
    dag_id="test_postgres_connection",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    tags=['postgres']
) as dag:

    get_SELECT_1 = SQLExecuteQueryOperator(
        task_id = "get_SELECT_1",
        conn_id = "stg_postgres",
        sql = "SELECT 1;",
    )

    get_SELECT_1

    



