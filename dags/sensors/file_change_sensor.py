from airflow.sensors.base import BaseSensorOperator
import os
import hashlib

class FileChangeSensor(BaseSensorOperator):
    def __init__(self, filepath, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.filepath = filepath
        self.last_hash = None

    def poke(self, context):
        self.log.info(f"Poking for file {self.filepath}")
        if not os.path.exists(self.filepath):
            self.log.info(f"File {self.filepath} does not exist.")
            return False

        with open(self.filepath, "rb") as f:
            current_hash = hashlib.md5(f.read()).hexdigest()
    
        if self.last_hash is None:
            self.last_hash = current_hash
        
        if current_hash != self.last_hash:
            self.last_hash = current_hash
            self.log.info(f'File {self.filepath} has changed!')
            return True

        return False