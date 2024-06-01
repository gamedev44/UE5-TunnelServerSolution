@echo off
setlocal

:menu
echo Choose an option:
echo 1. Connect to AsterServer
echo 2. Exit

set /p option="Enter option number: "

if "%option%"=="1" (
    @echo off
    powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ^
    "try { ^
    $hostIp = '192.168.1.208'; ^
    $port = 7777; ^
    $client = New-Object System.Net.Sockets.TcpClient; ^
    $client.Connect($hostIp, $port); ^
    $stream = $client.GetStream(); ^
    $reader = New-Object System.IO.StreamReader($stream); ^
    $writer = New-Object System.IO.StreamWriter($stream); ^
    $writer.AutoFlush = $true; ^
    $writer.WriteLine('JOIN'); ^
    $response = $reader.ReadLine(); ^
    Write-Host 'Server response: $response'; ^
    } catch { Write-Host 'Error connecting to server: $_'; } ^
    finally { if ($client -ne $null) { $client.Close() } }"
) else if "%option%"=="2" (
    exit
) else (
    echo Invalid option
    goto menu
)
