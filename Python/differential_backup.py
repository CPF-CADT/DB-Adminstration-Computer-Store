import subprocess
import json
import os
import datetime
import re

# --- Configuration ---
DEFAULT_BACKUP_DIR = '../backup/differential'
CONFIG_DIR = './config'
FULL_BACKUP_CONFIG_FILE = os.path.join(CONFIG_DIR, 'last_full_backup.json')

def sanitize_filename(name):
    return re.sub(r'[^a-zA-Z0-9_-]', '_', name)

def differential_backup(host, user, password, databases):
    print("\n--- Starting Differential Backup ---")
    os.makedirs(DEFAULT_BACKUP_DIR, exist_ok=True)

    if not os.path.exists(FULL_BACKUP_CONFIG_FILE):
        print("Full backup not found. Run fullbackup.py first.")
        return

    with open(FULL_BACKUP_CONFIG_FILE, 'r') as f:
        binlog_info = json.load(f)

    start_file = binlog_info.get('binlog_file')
    start_pos = binlog_info.get('binlog_pos')

    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    db_label = sanitize_filename('_'.join(databases))
    output_file = os.path.join(DEFAULT_BACKUP_DIR, f"diff_backup_{db_label}_{timestamp}.sql")

    command = [
        "mysqlbinlog",
        f"--start-position={start_pos}",
        "--read-from-remote-server",
        f"--host={host}", f"--user={user}", f"--password={password}",
        *[f"--database={db}" for db in databases],
        start_file
    ]

    print(f"Downloading binlog '{start_file}' from pos {start_pos}...")
    try:
        with open(output_file, "w", encoding='utf-8') as f:
            subprocess.run(command, stdout=f, stderr=subprocess.PIPE, check=True)
        print(f"Differential backup saved: {output_file}")

    except subprocess.CalledProcessError as e:
        print(f"Backup failed: {e.stderr.decode('utf-8')}")
    except FileNotFoundError:
        print("mysqlbinlog not found in PATH.")

if __name__ == "__main__":
    differential_backup("localhost", "root", "1234", ["computer_shop"] )
