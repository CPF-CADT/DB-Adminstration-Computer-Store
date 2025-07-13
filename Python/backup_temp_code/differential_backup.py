import subprocess
import json
import os
import datetime
import mysql.connector # You need to install this: pip install mysql-connector-python
from utils import keep_last_n_files

def get_subsequent_binlogs(user, password, host, start_file):
    """
    Connects to MySQL and gets a list of all binary log files
    from the start_file to the most recent one.
    """
    try:
        cnx = mysql.connector.connect(user=user, password=password, host=host)
        cursor = cnx.cursor()
        cursor.execute("SHOW BINARY LOGS;")
        all_logs = [row[0] for row in cursor.fetchall()] # type: ignore
        cursor.close()
        cnx.close()
        try:
            start_index = all_logs.index(start_file)
            return all_logs[start_index:]
        except ValueError:
            print(f"CRITICAL ERROR: The starting binlog file '{start_file}' was not found on the server. It may have been purged. A new full backup is required.")
            return None
            
    except mysql.connector.Error as err:
        print(f"MySQL Connection Error: {err}")
        return None


def differential_backup_from_config(user, password, host, db_name, backup_dir='./backup/differential', config_path='./config/last_full_backup.json'):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    backup_dir_abs = os.path.abspath(os.path.join(script_dir, backup_dir))
    config_path_abs = os.path.abspath(os.path.join(script_dir, config_path))

    if not os.path.exists(config_path_abs):
        print(f"Error: Config file not found at {config_path_abs}. Please run full backup first.")
        return
    
    with open(config_path_abs, 'r') as f:
        binlog_info = json.load(f)
    
    start_binlog_file = binlog_info.get('binlog_file')
    start_position = binlog_info.get('binlog_pos')
    
    if not start_binlog_file or not start_position:
        print("Error: Invalid binlog info in config file.")
        return

    binlog_files_to_process = get_subsequent_binlogs(user, password, host, start_binlog_file)
    
    if not binlog_files_to_process:
        print("Aborting differential backup due to binlog file issue.")
        return
    
    print(f"Found binlog files to process: {binlog_files_to_process}")
    
    os.makedirs(backup_dir_abs, exist_ok=True)

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    output_file = os.path.join(backup_dir_abs, f"diff_backup_{timestamp}.sql")

    command = [
        "mysqlbinlog",
        f"--database={db_name}",
        f"--start-position={start_position}",
        "--read-from-remote-server",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
    ] + binlog_files_to_process

    printable_command = [p if not p.startswith('--password=') else '--password=*****' for p in command] # type: ignore
    print("Running command:", " ".join(printable_command)) # type: ignore

    with open(output_file, "w") as out_file:
        result = subprocess.run(command, stdout=out_file, stderr=subprocess.PIPE, text=True) # type: ignore # Use text=True for easier decoding

    if result.returncode == 0:
        print(f"Differential backup successful. File saved as {output_file}.")
        if os.path.getsize(output_file) == 0:
            print("Warning: The differential backup file is empty. This is normal if no changes were made to the database.")
        keep_last_n_files(backup_dir_abs, 105)
    else:
        print(f"Error: {result.stderr}")

differential_backup_from_config(
    user="root",
    password="1234",
    host="localhost",
    db_name="computer_shop", 
    backup_dir='../backup/differential'
)