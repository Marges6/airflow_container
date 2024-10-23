FROM apache/airflow:latest
USER root

ARG AIRFLOW_HOME=/opt/airflow


COPY ./airflow/airflow.cfg /opt/airflow/airflow.cfg


USER airflow
RUN pip install --upgrade pip
RUN pip install apache-airflow-providers-microsoft-mssql
RUN pip install pytest
RUN pip install apache-airflow-providers-common-sql

USER ${AIRFLOW_UID}






