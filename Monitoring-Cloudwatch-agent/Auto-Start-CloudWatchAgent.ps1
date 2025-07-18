# Script to check CloudWatch Agent status and start it if it's stopped

$serviceName = "AmazonCloudWatchAgent"

try {
    # Get the service object
    $service = Get-Service -Name $serviceName -ErrorAction Stop

    # Check service status
    if ($service.Status -ne "Running") {
        Write-Host "CloudWatch Agent is not running. Starting it now..." -ForegroundColor Yellow
        Start-Service -Name $serviceName
        Start-Sleep -Seconds 3  # Wait a moment before rechecking
        $service = Get-Service -Name $serviceName
        if ($service.Status -eq "Running") {
            Write-Host "CloudWatch Agent successfully started." -ForegroundColor Green
        } else {
            Write-Host "Failed to start CloudWatch Agent." -ForegroundColor Red
        }
    } else {
        Write-Host "CloudWatch Agent is already running." -ForegroundColor Green
    }
}
catch {
    Write-Host "Error: Could not find or access the service '$serviceName'." -ForegroundColor Red
    Write-Host $_.Exception.Message
}
