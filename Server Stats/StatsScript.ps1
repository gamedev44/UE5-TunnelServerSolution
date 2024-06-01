# This script will continuously update and display statistics about connected users

while ($true) {
    $userLog = Get-Content -Path "user_log.txt" -ErrorAction SilentlyContinue
    $userCount = $userLog.Count
    Write-Host "Current connected users: $userCount"
    Start-Sleep -Seconds 30  # Update every 30 seconds
}
