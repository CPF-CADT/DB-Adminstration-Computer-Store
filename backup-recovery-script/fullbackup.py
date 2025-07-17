import subprocess
import json
import os
import datetime
import re
from utils import keep_last_n_files
# --- Configuration ---
DEFAULT_BACKUP_DIR = '../backup/full'
CONFIG_DIR = './config'
FULL_BACKUP_CONFIG_FILE = os.path.join(CONFIG_DIR, 'last_full_backup.json')
INCR_BACKUP_CONFIG_FILE = os.path.join(CONFIG_DIR, 'last_incremental_backup.json')

def sanitize_filename(name):
    return re.sub(r'[^a-zA-Z0-9_-]', '_', name)

def full_backup(host, user, password, db_name):
    if not isinstance(db_name, str):
        print("Error: DB name must be a string.")
        return

    print("--- Starting Full Backup ---")
    os.makedirs(DEFAULT_BACKUP_DIR, exist_ok=True)
    os.makedirs(CONFIG_DIR, exist_ok=True)

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    sanitized_name = sanitize_filename(db_name)
    output_file = os.path.join(DEFAULT_BACKUP_DIR, f"full_backup_{sanitized_name}_{timestamp}.sql")

    command = [
        "mysqldump",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        "--single-transaction",
        "--flush-logs",
        "--master-data=2",
        db_name
    ]

    print(f"Running mysqldump for database '{db_name}'...")
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            subprocess.run(command, stdout=f, stderr=subprocess.PIPE, check=True)
        print(f"Full backup successful: {output_file}")
        keep_last_n_files('../backup/full',5)
        binlog_info = {}
        with open(output_file, 'r', encoding='utf-8') as f:
            for line in f:
                match = re.search(r"--\s*CHANGE MASTER TO MASTER_LOG_FILE='(.+?)',\s*MASTER_LOG_POS=(\d+);", line)
                if match:
                    binlog_info['binlog_file'] = match.group(1)
                    binlog_info['binlog_pos'] = int(match.group(2))
                    break

        if binlog_info:
            with open(FULL_BACKUP_CONFIG_FILE, 'w', encoding='utf-8') as jf:
                json.dump(binlog_info, jf, indent=4)
            print(f"Binlog info saved: {binlog_info}")

            if os.path.exists(INCR_BACKUP_CONFIG_FILE):
                os.remove(INCR_BACKUP_CONFIG_FILE)
                print("🧹 Old incremental config removed.")
        else:
            print("⚠️ Binlog info not found in backup file.")

    except subprocess.CalledProcessError as e:
        print(f"Backup failed:\n{e.stderr.decode('utf-8')}")
    except FileNotFoundError:
        print("mysqldump not found. Ensure MySQL client tools are installed.")

if __name__ == "__main__":
    full_backup('localhost', 'root', '1234', 'computer_shop')
