param(
    [string]$sourceFolderPath,
    [string]$replicaFolderPath,
    [string]$logFilePath
)

# Function to log messages to console and file
function LogMessage {
    param(
        [string]$Message
    )
    Write-Host $Message
    Add-Content -Path $logFilePath -Value $Message
}

# Check if the log file exists, if not, create it
if (-not (Test-Path -Path $logFilePath)) {
    New-Item -Path $logFilePath -ItemType File | Out-Null
    LogMessage "Log file created at: $(Get-Date)"
}

# Log start of synchronization
LogMessage "Synchronization started at: $(Get-Date)"

# Synchronize contents from source to replica
$sourceFiles = Get-ChildItem -Path $sourceFolderPath -Recurse
foreach ($file in $sourceFiles) {
    $destinationFile = Join-Path -Path $replicaFolderPath -ChildPath $file.FullName.Substring($sourceFolderPath.Length + 1)
    if (!(Test-Path -Path $destinationFile)) {
        Copy-Item -Path $file.FullName -Destination $destinationFile
        LogMessage "Copied file $($file.FullName) to $($destinationFile)"
    } else {
        $sourceFileLastWriteTime = (Get-Item -Path $file.FullName).LastWriteTime
        $destinationFileLastWriteTime = (Get-Item -Path $destinationFile).LastWriteTime
        if ($sourceFileLastWriteTime -ne $destinationFileLastWriteTime) {
            Copy-Item -Path $file.FullName -Destination $destinationFile -Force
            LogMessage "Updated file $($file.FullName) in $($destinationFile)"
        }
    }
}

# Remove any files in replica folder not present in source folder
$replicaFiles = Get-ChildItem -Path $replicaFolderPath -Recurse
foreach ($file in $replicaFiles) {
    $sourceFile = Join-Path -Path $sourceFolderPath -ChildPath $file.FullName.Substring($replicaFolderPath.Length + 1)
    if (!(Test-Path -Path $sourceFile)) {
        # Check if the item exists before attempting to remove it
        if (Test-Path -Path $file.FullName) {
            Remove-Item -Path $file.FullName -Force -Recurse
            LogMessage "Removed file $($file.FullName) from replica"
        }
    }
}

# Log end of synchronization
LogMessage "Synchronization completed at: $(Get-Date)"

Write-Host "Synchronization completed. Log file saved at: $logFilePath"
