# Tailscale-Account-Switch
Script for Windows to change tailscale account when on a different user account

This script removes the old account and restarts the tailscale service promting tailscale to ask you to authenticate

You must run this as an admin in Powershell. if the script does not work, open it in notepad and manually paste it in an admin powershell window

Here is the content of the script:
```
$serviceName = "Tailscale"
$folderPath = "C:\ProgramData\Tailscale"


Write-Host "Stopping the Tailscale service..."
Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue


if ((Get-Service -Name $serviceName).Status -eq 'Stopped') {
    Write-Host "Service stopped. Proceeding with folder deletion..."
    
        if (Test-Path $folderPath) {
        Remove-Item -Path $folderPath -Recurse -Force
        Write-Host "Folder deleted: $folderPath"
    } else {
        Write-Host "Folder does not exist: $folderPath"
    }

    # Restart the service
    Write-Host "Starting the Tailscale service..."
    Start-Service -Name $serviceName
    Write-Host "Service restarted."
} else { 
    Write-Host "Failed to stop the service. Aborting operation."
}
```
