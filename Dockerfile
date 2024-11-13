FROM apache/airflow:2.10.2-python3.12
USER root

RUN apt-get update && \
    apt-get install -y gcc python3-dev openjdk-17-jdk-headless && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64

ARG AIRFLOW_HOME=/opt/airflow


COPY ./airflow/airflow.cfg /opt/airflow/airflow.cfg


USER airflow
RUN pip install --upgrade pip
RUN pip install apache-airflow-providers-microsoft-mssql
RUN pip install pytest
RUN pip install apache-airflow-providers-common-sql
RUN pip install apache-airflow-providers-apache-spark
RUN pip install pyspark

USER ${AIRFLOW_UID}






