# Run as administrator

$serviceName = "Tailscale"
$folderPath = "C:\ProgramData\Tailscale"

# Stop the Tailscale service
Write-Host "Stopping the Tailscale service..."
Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue

# Confirm service is stopped
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