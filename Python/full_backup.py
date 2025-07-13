import subprocess
import datetime
import re
import json
import os
from utils import keep_last_n_files

def backup_database(host, user, password, db_name, output_file_prefix):
    script_dir = os.path.dirname(os.path.abspath(__file__))

    output_file_prefix_abs = os.path.abspath(os.path.join(script_dir, output_file_prefix))
    if output_file_prefix_abs.endswith('/') or output_file_prefix_abs.endswith('\\'):
        output_file_prefix_abs = output_file_prefix_abs.rstrip('/\\')
    
    os.makedirs(output_file_prefix_abs, exist_ok=True)

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    
    output_file = os.path.join(output_file_prefix_abs, f"full_backup_{timestamp}.sql")
    
    binlog_info_file = os.path.abspath(os.path.join(script_dir, "config/last_full_backup.json"))
    
    command = [
        "mysqldump",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        db_name,
        "--single-transaction",
        "--master-data=2",
        f"--result-file={output_file}"
    ]
    
    print("Running command:", " ".join(command))
    
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    
    if result.returncode == 0:
        print(f"Backup successful. File saved as {output_file}.")

        binlog_info = {}
        with open(output_file, 'r', encoding='utf-8') as f:
            for line in f:
                match = re.search(r"CHANGE MASTER TO MASTER_LOG_FILE='(.+)', MASTER_LOG_POS=(\d+);", line)
                if match:
                    binlog_info['binlog_file'] = match.group(1)
                    binlog_info['binlog_pos'] = int(match.group(2))
                    print(f"Extracted binlog info: {binlog_info}")
                    break
        
        if binlog_info:
            # Ensure config folder exists (absolute path)
            config_folder = os.path.dirname(binlog_info_file)
            os.makedirs(config_folder, exist_ok=True)

            with open(binlog_info_file, 'w', encoding='utf-8') as jf:
                json.dump(binlog_info, jf, indent=4)
            print(f"Binlog info saved to JSON file: {binlog_info_file}")

            # keep_last_n_files expects absolute path now
            keep_last_n_files(output_file_prefix_abs, 5)
        else:
            print("Warning: Could not find binlog info in backup file.")

    else:
        print(f"Error: {result.stderr.decode('utf-8')}")

backup_database("localhost", "root", "Panhaygo7$", "computer_shop", "../backup/full")
