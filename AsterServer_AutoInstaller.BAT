@echo off
setlocal

REM Get paths from the user
set /p hostUePath=Enter the path to the Unreal Engine editor (e.g., C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe):
set /p hostProjectPath=Enter the path to the host project file (e.g., C:\Users\herre\OneDrive\Documents\Unreal Projects\PolyStrike\Data\Low Poly Shooter Pack v5.0\PolyStrike.uproject):
set /p clientUePath=Enter the path to the Unreal Engine client (e.g., C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe):
set /p clientProjectPath=Enter the path to the client project file (e.g., C:\Users\herre\OneDrive\Documents\Unreal Projects\PolyStrike\Data\Low Poly Shooter Pack v5.0\PolyStrike.uproject):
set /p authCodesFolderPath=Enter the path to the folder containing the AuthorizationCodes.txt file for future server areas (e.g., C:\path\to\authcodes):

REM Write the host batch file
set hostBatchPath=%hostProjectPath%\HostScript.bat
(
echo @echo off
echo setlocal
echo set hostIp=26.63.38.182
echo set port=7777
echo set code=JOIN ;REM Update this to send actual codes when needed.
echo set ueClientPath="%clientUePath%"
echo set ueProjectPath="%clientProjectPath%"
echo set ueClientParams="-game -ResX=800 -ResY=600 -WinX=0 -WinY=20 -log -nosteam"
echo powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command "try { ^
echo     $hostIp = '%%hostIp%%'; ^
echo     $port = %%port%%; ^
echo     $client = New-Object System.Net.Sockets.TcpClient; ^
echo     $client.Connect($hostIp, $port); ^
echo     $stream = $client.GetStream(); ^
echo     $reader = New-Object System.IO.StreamReader($stream); ^
echo     $writer = New-Object System.IO.StreamWriter($stream); ^
echo     $writer.AutoFlush = $true; ^
echo     $writer.WriteLine('%%code%%'); ^
echo     $response = $reader.ReadLine(); ^
echo     Write-Host 'Server response: ' $response; ^
echo } catch { Write-Host 'Error connecting to server: ' $_; } ^
echo finally { if ($client -ne $null) { $client.Close() } }"
echo start "" %ueClientPath% "%ueProjectPath%" %hostIp% %ueClientParams%
) > %hostBatchPath%

REM Write the client batch file
set clientBatchPath=%clientProjectPath%\ClientScript.bat
(
echo @echo off
echo setlocal
echo set hostIp=26.63.38.182
echo set port=7777
echo set code=JOIN ;REM Update this to send actual codes when needed.
echo set ueClientPath="%clientUePath%"
echo set ueProjectPath="%clientProjectPath%"
echo set ueClientParams="-game -ResX=800 -ResY=600 -WinX=0 -WinY=20 -log -nosteam"
echo powershell -ExecutionPolicy Bypass -NoLogo -NoProfile -Command "try { ^
echo     $hostIp = '%%hostIp%%'; ^
echo     $port = %%port%%; ^
echo     $client = New-Object System.Net.Sockets.TcpClient; ^
echo     $client.Connect($hostIp, $port); ^
echo     $stream = $client.GetStream(); ^
echo     $reader = New-Object System.IO.StreamReader($stream); ^
echo     $writer = New-Object System.IO.StreamWriter($stream); ^
echo     $writer.AutoFlush = $true; ^
echo     $writer.WriteLine('%%code%%'); ^
echo     $response = $reader.ReadLine(); ^
echo     Write-Host 'Server response: ' $response; ^
echo } catch { Write-Host 'Error connecting to server: ' $_; } ^
echo finally { if ($client -ne $null) { $client.Close() } }"
echo start "" %ueClientPath% "%ueProjectPath%" %hostIp% %ueClientParams%
) > %clientBatchPath%

echo Batch files created successfully.

:end
