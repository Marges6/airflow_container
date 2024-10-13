#!/usr/bin/env bash
#airflow db reset -s
airflow db migrate
airflow users create --username airflow --password password --firstname M --lastname G --role Admin --email admin@admin.com
airflow scheduler &
airflow webserver
