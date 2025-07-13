import subprocess
import os

def incremental_restore(host, user, password, db_name, full_backup_path, incremental_backup_paths):
    print("--- Starting Incremental Restore ---")

    mysql_command = [
        "mysql",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        db_name
    ]

    print(f"\n[Step 1] Restoring full backup from: {full_backup_path}")
    try:
        with open(full_backup_path, "r", encoding='utf-8') as infile:
            subprocess.run(mysql_command, stdin=infile, capture_output=True, text=True, check=True)
        print("Full backup restored successfully.")
    except FileNotFoundError:
        print(f"ERROR: Full backup file not found at '{full_backup_path}'. Aborting.")
        return
    except subprocess.CalledProcessError as e:
        print(f" ERROR restoring full backup:\n{e.stderr}")
        return

    for i, incr_path in enumerate(incremental_backup_paths):
        print(f"\n[Step {2 + i}] Applying incremental backup: {incr_path}")
        try:
            with open(incr_path, "r", encoding='utf-8') as infile:
                subprocess.run(mysql_command, stdin=infile, capture_output=True, text=True, check=True)
            print("Incremental backup applied successfully.")
        except FileNotFoundError:
            print(f" ERROR: Incremental file not found at '{incr_path}'. Restore halted.")
            return
        except subprocess.CalledProcessError as e:
            print(f" ERROR applying incremental backup:\n{e.stderr}")
            print(" Restore halted due to error.")
            return

    print("\n---Incremental Restore Completed Successfully ---")

if __name__ == "__main__":
    incremental_restore("localhost", "root", "1234", "school_db",
                full_backup_path="./backup/full/full_backup_school_db_2025-07-12_21-04-33.sql",
                incremental_backup_paths=   [
                    "./backup/incremental/incr_backup_school_db_2025-07-12_21-04-48.sql",
                    "./backup/incremental/incr_backup_school_db_2025-07-12_21-04-55.sql"
                ]
    )
