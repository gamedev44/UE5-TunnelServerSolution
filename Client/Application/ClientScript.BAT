@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=C:\Users\Dennis\Documents\GitHub\UE5-TunnelServerSolution\Client\Application\AsterPlay.exe
REM BFCPEICON=C:\Program Files (x86)\Advanced BAT to EXE Converter v4.11\ab2econv411\icons\7127f441d8ff8b5ef2b5d105a0fe8488__storm_troopers_digital_paintings_un8_icon.ico
REM BFCPEICONINDEX=1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=0
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Aster-Server GUI Launcher Client
REM BFCPEVERDESC=ALLOWS YOU TO CONNECT TO OUR SERVERS.
REM BFCPEVERCOMPANY=PROGRESSIVE GAME DESIGN
REM BFCPEVERCOPYRIGHT=Semi-Open-Source
REM BFCPEOPTIONEND
@ECHO ON
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
    $writer.WriteLine('NAM-7890'); ^
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
