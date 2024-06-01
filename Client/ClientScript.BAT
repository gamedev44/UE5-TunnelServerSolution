@echo off
setlocal

:menu
echo Choose an option:
echo 1. Connect to AsterServer
echo 2. Exit

set /p option="Enter option number: "

if "%option%"=="1" (
    @echo off
    set hostIp=RADMIN_VPN_HOST_IP ;REM Replace with the actual Radmin VPN IP address of the host.
    set port=7777
    set code=JOIN ;REM Update this to send actual codes when needed.
    set ueClientPath="C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe"
    set ueProjectPath="C:\Users\herre\OneDrive\Documents\Unreal Projects\PolyStrike\Data\Low Poly Shooter Pack v5.0\PolyStrike.uproject"
    set ueClientParams="%hostIp% -game -ResX-800-ResY-600 -WinX-0 -WinY-20 -log -nosteam"

    powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command ^
    "try { ^
        $hostIp = '%hostIp%'; ^
        $port = %port%; ^
        $client = New-Object System.Net.Sockets.TcpClient; ^
        $client.Connect($hostIp, $port); ^
        $stream = $client.GetStream(); ^
        $reader = New-Object System.IO.StreamReader($stream); ^
        $writer = New-Object System.IO.StreamWriter($stream); ^
        $writer.AutoFlush = $true; ^
        $writer.WriteLine('%code%'); ^
        $response = $reader.ReadLine(); ^
        Write-Host 'Server response: ' $response; ^
    } catch { Write-Host 'Error connecting to server: ' $_; } ^
    finally { if ($client -ne $null) { $client.Close() } }"

    start "" %ueClientPath% "%ueProjectPath%" %ueClientParams%
) else if "%option%"=="2" (
    exit
) else (
    echo Invalid option
    goto menu
)
