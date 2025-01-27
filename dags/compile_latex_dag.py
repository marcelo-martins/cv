from airflow import DAG
from airflow.providers.docker.operators.docker import DockerOperator
from datetime import datetime
from docker.types import Mount
import os
from sensors.file_change_sensor import FileChangeSensor

input_path = os.path.join(os.getenv('ABSOLUTE_PATH'), 'latex/input')
output_path = os.path.join(os.getenv('ABSOLUTE_PATH'), 'latex/output')

default_args = {
    'owner': 'airflow',
    'start_date': datetime(2023, 1, 1),
    'retries': 1,
}

with DAG(
    dag_id='latex_compilation',
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
) as dag:
    
    changed_file = FileChangeSensor(
        task_id='check_changed_file',
        filepath=os.path.join('latex/input/', 'CV_Marcelo_Martins.tex'),
        poke_interval=10,
        timeout=600,
        mode='poke',

    )
    
    compile_latex = DockerOperator(
        task_id='compile_latex',
        image='latex_compiler',
        api_version='auto',
        auto_remove='success',
        command="sh -c 'pdflatex -output-directory=/latex/output /latex/input/CV_Marcelo_Martins.tex && rm -f /latex/output/*.aux /latex/output/*.log /latex/output/*.out'",
        docker_url="unix://var/run/docker.sock",
        network_mode="bridge",
        mounts=[
            Mount(source=input_path, target="/latex/input", type="bind"),
            Mount(source=output_path, target="/latex/output", type="bind"),
        ],
        mount_tmp_dir=False,
    )

    changed_file >> compile_latex