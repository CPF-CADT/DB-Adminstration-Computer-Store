import subprocess
import json
import os
import datetime
import re

# --- Configuration ---
INCR_BACKUP_DIR = '../backup/incremental'
CONFIG_DIR = './config'
FULL_BACKUP_CONFIG_FILE = os.path.join(CONFIG_DIR, 'last_full_backup.json')
INCR_BACKUP_CONFIG_FILE = os.path.join(CONFIG_DIR, 'last_incremental_backup.json')

DB_HOST = "localhost"
DB_USER = "root"
DB_PASS = "1234"
DB_NAMES = ["computer_shop"] 

def sanitize_filename(name):
    return re.sub(r'[^a-zA-Z0-9_-]', '_', name)

def _get_master_status(host, user, password):
    command = [
        "mysql",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        "-e", "SHOW MASTER STATUS"
    ]
    try:
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        lines = result.stdout.strip().split('\n')
        if len(lines) > 1:
            parts = lines[1].split('\t')
            return {'binlog_file': parts[0], 'binlog_pos': int(parts[1])}
    except Exception as e:
        print(f"Error getting master status: {e}")
    return None

def incremental_backup(host, user, password, databases):
    print("\n--- Starting Incremental Backup ---")
    os.makedirs(INCR_BACKUP_DIR, exist_ok=True)

    config_to_use = INCR_BACKUP_CONFIG_FILE if os.path.exists(INCR_BACKUP_CONFIG_FILE) else FULL_BACKUP_CONFIG_FILE
    if not os.path.exists(config_to_use):
        print("Full backup not found. Run fullbackup.py first.")
        return

    with open(config_to_use, 'r') as f:
        binlog_info = json.load(f)

    start_file = binlog_info.get('binlog_file')
    start_pos = binlog_info.get('binlog_pos')
    end_info = _get_master_status(host, user, password)
    if not end_info:
        print("Could not get current binlog status.")
        return

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    db_label = sanitize_filename('_'.join(databases))
    output_file = os.path.join(INCR_BACKUP_DIR, f"incr_backup_{db_label}_{timestamp}.sql")

    command = [
        "mysqlbinlog",
        f"--start-position={start_pos}",
        f"--stop-position={end_info['binlog_pos']}",
        "--read-from-remote-server",
        f"--host={host}", f"--user={user}", f"--password={password}",
        *[f"--database={db}" for db in databases],
        start_file
    ]

    print(f"Downloading from {start_file}:{start_pos} to {end_info['binlog_pos']}")
    try:
        with open(output_file, "w", encoding='utf-8') as f:
            subprocess.run(command, stdout=f, stderr=subprocess.PIPE, check=True)
        print(f"Incremental backup saved: {output_file}")

        with open(INCR_BACKUP_CONFIG_FILE, 'w', encoding='utf-8') as jf:
            json.dump(end_info, jf, indent=4)
        print(f"Updated incremental binlog info: {end_info}")

    except subprocess.CalledProcessError as e:
        print(f"Backup failed: {e.stderr.decode('utf-8')}")
    except FileNotFoundError:
        print("mysqlbinlog not found in PATH.")
        
if __name__ == "__main__":
    incremental_backup(DB_HOST, DB_USER, DB_PASS, DB_NAMES)
