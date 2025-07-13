import subprocess

def restore_database(host, user, password, db_name, input_fullbackup_file,input_diff_backup_file):
    command = [
        "mysql",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        db_name
    ]
    print(command)
    # restore fullbackup
    with open(input_fullbackup_file, "r") as infile:
        result = subprocess.run(command, stdin=infile, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(result)
    
    if result.returncode == 0:
        print(f"Restore successful from {input_fullbackup_file}.")
    else:
        print(f"Error: {result.stderr.decode('utf-8')}")
    # restore last differential file
    with open(input_diff_backup_file, "r") as infile:
        result = subprocess.run(command, stdin=infile, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(result)
    
    if result.returncode == 0:
        print(f"Restore successful from {input_diff_backup_file}.")
    else:
        print(f"Error: {result.stderr.decode('utf-8')}")

restore_database("localhost", "nak", "1234", "computer_shop", 
                input_fullbackup_file="../backup/full/full_backup_2025-07-05_23-02-10.sql",
                input_diff_backup_file="../backup/differential/diff_backup_2025-07-05_23-35-27.sql")
