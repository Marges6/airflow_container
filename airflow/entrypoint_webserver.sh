#!/usr/bin/env bash
airflow webserver
airflow connections add 'mssql_default' --conn-uri ${AIRFLOW_CONN_MSSQL_DEFAULT}