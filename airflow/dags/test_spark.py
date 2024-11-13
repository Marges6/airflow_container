from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.decorators import dag, task
from airflow.providers.apache.spark.operators.spark_submit import SparkSubmitOperator

default_args= {
    'owner': 'airflow',
    'start_date': days_ago(1)
    }

@dag(
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    tags=['spark'],
)
def test_spark_dag():
    
    @task
    def start_test():
        print("Jobs started")
    
    python_job = SparkSubmitOperator(
        task_id="spark_job_process",
        conn_id="spark_conn",
        application="spark_jobs/wordcountjob.py"
    )


        
    @task
    def finish_test():
        print("Job ended")

    start_test_step = start_test()
    finish_test_step = finish_test()

    start_test_step >> python_job >> finish_test_step

test_spark = test_spark_dag()