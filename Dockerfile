FROM apache/airflow:latest
USER root
# Set the AIRFLOW_HOME environment variable
ENV AIRFLOW_HOME=/opt/airflow/airflow
ARG AIRFLOW_HOME=/opt/airflow/airflow

#RUN pip install apache-airflow-providers-docker

COPY ./airflow/airflow.cfg /opt/airflow/airflow.cfg
COPY ./airflow/entrypoint_scheduler.sh /opt/airflow/entrypoint_scheduler.sh
COPY ./airflow/entrypoint_webserver.sh /opt/airflow/entrypoint_webserver.sh
# COPY ./airflow/entrypoint_scheduler.sh /usr/local/airflow/entrypoint_scheduler.sh
# COPY ./airflow/entrypoint_webserver.sh /usr/local/airflow/entrypoint_webserver.sh
# COPY ./airflow/airflow-entrypoint.sh /opt/airflow/airflow-entrypoint.sh
# COPY ./etl_script ${AIRFLOW_USER_HOME}/etl_script

RUN ["chmod", "+x", "/opt/airflow/entrypoint_scheduler.sh"]
RUN ["chmod", "+x", "/opt/airflow/entrypoint_webserver.sh"]

USER airflow
RUN pip install --upgrade pip
RUN pip install apache-airflow-providers-microsoft-mssql
RUN pip install pytest
RUN pip install apache-airflow-providers-common-sql


USER ${AIRFLOW_UID}






