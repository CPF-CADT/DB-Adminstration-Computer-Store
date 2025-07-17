import os

def keep_last_n_files(folder_path, n):
    files = [os.path.join(folder_path, f) for f in os.listdir(folder_path)
             if os.path.isfile(os.path.join(folder_path, f))]
    files.sort(key=os.path.getmtime, reverse=True)
    for file_to_delete in files[n:]:
        try:
            os.remove(file_to_delete)
            print(f"Deleted: {file_to_delete}")
        except Exception as e:
            print(f"Failed to delete {file_to_delete}: {e}")

def get_newest_file(folder_path):
    files = [os.path.join(folder_path, f) for f in os.listdir(folder_path)
             if os.path.isfile(os.path.join(folder_path, f))]
    if not files:
        return None
    newest = max(files, key=os.path.getmtime)  
    return newest