from airflow.sensors.filesystem import FileSensor
from airflow.sensors.base import BaseSensorOperator
import os

class FileChangeSensor(BaseSensorOperator):
    def __init__(self, filepath, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.filepath = filepath
        self.log.info(self.mode)

    def poke(self, context):
        self.log.info(f"Poking for file {self.filepath}")
        if not os.path.exists(self.filepath):
            self.log.info(f"File {self.filepath} does not exist.")
            return False
        
        # Get the current modification time
        current_mtime = round(os.path.getmtime(self.filepath))
        self.log.info(f"current_mtime {current_mtime}")

        # Retrieve the last known modification time from XCom
        last_mtime = context['ti'].xcom_pull(task_ids=self.task_id, key='last_mtime', default=0)
        self.log.info(f"last_mtime: {last_mtime}")
        if last_mtime == 0:
            context['ti'].xcom_push(key='last_mtime', value=current_mtime)
            last_mtime = current_mtime

        # Compare modification times
        if current_mtime != last_mtime:
            self.log.info("File has been modified.")
            # Update the last known modification time in XCom
            context['ti'].xcom_push(key='last_mtime', value=current_mtime)
            return True
        else:
            self.log.info("File has not been modified.")
            return False