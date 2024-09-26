# Define a log file path
$logFilePath = "$env:TEMP\wiresharkupdate_log.txt"

# Function to log messages
function Log-Message {
    param (
        [string]$message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp - $message"
    Add-Content -Path $logFilePath -Value $logMessage
}

try {
$Wiresharkinstaller = "https://2.na.dl.wireshark.org/win64/Wireshark-4.4.0-x64.exe"
$Wiresharkinstallerpath = "$env:TEMP\Wireshark-4.4.0-x64.exe"
Log-Message "Downloading wireshark latest version"
Invoke-WebRequest -Uri $Wiresharkinstaller -OutFile $Wiresharkinstallerpath
Log-Message "Download completed." 

#Running the installer
Log-Message "Now installing Wireshark"
Start-Process -FilePath $Wiresharkinstallerpath -ArgumentList "/silent /install" -Wait
Log-Message "Application installed successfully"

#Remove installer
Remove-Item $Wiresharkinstallerpath
Log-Message "Installer has been removed"
}

catch {
#Error handling
$errorMessage = $_.Exception.Message
Log-Message "Error: $errorMessage"
Write-Host "An error occurred: $errorMessage" -ForegroundColor Red
}

finally {
    Log-Message "Wireshark update script completed."
}
