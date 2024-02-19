# PowerShell Folder Synchronization Script

## Overview

This PowerShell script is designed to synchronize two folders: a source folder and a replica folder. The script ensures that the contents of the replica folder exactly match the contents of the source folder, maintaining a full, identical copy.

## Features

- **One-way synchronization:** Changes made in the source folder are reflected in the replica folder.
- **Logging:** File creation, copying, and removal operations are logged to both a file and the console output.
- **Customizable folder paths:** Source folder, replica folder, and log file paths can be provided as command-line arguments.
- **No reliance on external utilities:** The script is implemented solely using built-in PowerShell cmdlets, avoiding the use of tools like robocopy.

## Usage

### Prerequisites

- PowerShell (version 5.1 or later) installed on the system.

### Running the Script

1. Open PowerShell as administrator.
2. Navigate to the directory containing the script.
3. Run the script with the following command, replacing the placeholders with the appropriate folder paths:
    ```
    .\SyncScript.ps1 -sourceFolderPath "<source_folder_path>" -replicaFolderPath "<replica_folder_path>" -logFilePath "<log_file_path>"
    ```

    Example:
    ```
    .\SyncScript.ps1 -sourceFolderPath "C:\powersync\Source" -replicaFolderPath "C:\powersync\Replica" -logFilePath "C:\powersync\Log\sync_log.txt"
    ```

### Additional Notes

- Ensure that the user running the script has appropriate permissions to read from the source folder and write to the replica folder.
- If the log file does not exist, the script will create it automatically.
- For more information and options, refer to the comments within the script file.

## Author

[VDGQ]
