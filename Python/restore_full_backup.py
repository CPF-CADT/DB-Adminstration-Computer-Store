import subprocess

def restore_database(host, user, password, db_name, input_file):
    command = [
        "mysql",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        db_name
    ]
    print(command)
    
    with open(input_file, "r") as infile:
        result = subprocess.run(command, stdin=infile, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(result)
    
    if result.returncode == 0:
        print(f"Restore successful from {input_file}.")
    else:
        print(f"Error: {result.stderr.decode('utf-8')}")

restore_database("localhost", "root", "1234", "computer_shop", "../backup/full/full_backup_2025-07-05_23-02-10.sql")
