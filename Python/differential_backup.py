import subprocess
import json
import os
import datetime
from utils import keep_last_n_files

def differential_backup_from_config(user, password, host, backup_dir='./backup/differential', config_path='./config/last_full_backup.json'):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    backup_dir_abs = os.path.abspath(os.path.join(script_dir, backup_dir))
    config_path_abs = os.path.abspath(os.path.join(script_dir, config_path))

    if not os.path.exists(config_path_abs):
        print(f"Error: Config file not found at {config_path_abs}. Please run full backup first.")
        return
    
    with open(config_path_abs, 'r') as f:
        binlog_info = json.load(f)
    
    binlog_file = binlog_info.get('binlog_file')
    start_position = binlog_info.get('binlog_pos')
    
    if not binlog_file or not start_position:
        print("Error: Invalid binlog info in config file.")
        return

    os.makedirs(backup_dir_abs, exist_ok=True)

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    output_file = os.path.join(backup_dir_abs, f"diff_backup_{timestamp}.sql")

    command = [
        "mysqlbinlog",
        f"--start-position={start_position}",
        "--read-from-remote-server",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        binlog_file
    ]

    print("Running command:", " ".join(command))

    with open(output_file, "w") as out_file:
        result = subprocess.run(command, stdout=out_file, stderr=subprocess.PIPE)

    if result.returncode == 0:
        print(f"Differential backup successful. File saved as {output_file}.")
        keep_last_n_files(backup_dir_abs, 105)
    else:
        print(f"Error: {result.stderr.decode('utf-8')}")

differential_backup_from_config(
    user="root",
    password="1234",
    host="localhost",
    backup_dir='../backup/differential'
)
