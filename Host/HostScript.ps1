$listenerPort = 7777
$authCodesFilePath = "AuthCodes\AuthorizationCodes.txt"
$errorLog = "error_log.txt"
$connectionLog = "connection_log.txt"
$userLog = "user_log.txt"
$uePath = "C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe"
$projectPath = "C:\Users\herre\OneDrive\Documents\Unreal Projects\PolyStrike\Data\Low Poly Shooter Pack v5.0\PolyStrike.uproject"
$serverParams = "MainMenu_Level-server-log -nosteam"

# Function to log errors
function Write-ErrorLog {
    param (
        [string]$message
    )
    Add-Content -Path $errorLog -Value "$(Get-Date): $message"
}

# Function to log connections
function Write-ConnectionLog {
    param (
        [string]$message
    )
    Add-Content -Path $connectionLog -Value "$(Get-Date): $message"
}

# Function to log user details
function Write-UserLog {
    param (
        [string]$userIP,
        [string]$code
    )
    Add-Content -Path $userLog -Value "$(Get-Date): IP: $userIP, Code: $code"
}

# Load authorization codes from file
function Get-AuthCodes {
    if (Test-Path $authCodesFilePath) {
        Get-Content $authCodesFilePath
    } else {
        Write-ErrorLog "Authorization codes file not found at path: $authCodesFilePath"
        @()
    }
}

$allowedCodes = Get-AuthCodes

# Start the UE server
Start-Process -FilePath $uePath -ArgumentList "$projectPath $serverParams"

# Start listener
$listener = [System.Net.Sockets.TcpListener]::new($listenerPort)
$listener.Start()
Write-Host "Listening for incoming connections on port $listenerPort..."

while ($true) {
    $client = $listener.AcceptTcpClient()
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $writer = [System.IO.StreamWriter]::new($stream)
    $writer.AutoFlush = $true

    $clientIP = $client.Client.RemoteEndPoint.Address.ToString()

    try {
        $code = $reader.ReadLine()
        Write-Host "Received code: $code from $clientIP"

        if ($allowedCodes -contains $code) {
            $writer.WriteLine("Code accepted")
            Write-ConnectionLog "Connection accepted from $clientIP with code $code"
            Write-UserLog $clientIP $code
            # Here you can add any additional code to allow the connection
        } else {
            $writer.WriteLine("Invalid code")
            Write-ErrorLog "Invalid code: $code from $clientIP"
        }
    } catch {
        Write-ErrorLog "Error processing request from $clientIP: $_"
    }

    $client.Close()
}
