from datetime import timedelta, datetime, date

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import days_ago

default_args = {
    'owner': 'limon',
    #'depends_on_past': False,
    'email': ['my-fluffy-airflow@yandex.ru'],
    'email_on_failure': False,
    'email_on_retry': False,
    #'retries': 1,
    #'retry_delay': timedelta(minutes=5)
    }

dag = DAG(
  'rs_dag_1',
  default_args=default_args,
  schedule_interval=None,
  description='DAG for downloading COVID19 data',  
  start_date=datetime(2020, 6, 7, 6),
  tags=['rsn'],
) 

run_this = BashOperator(
        task_id='runShellScript',
        bash_command="/home/limon/airflow/ssh-scripts/getRussianCovidStats.sh ",
        dag=dag        
    )

          

