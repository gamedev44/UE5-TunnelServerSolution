$listenerPort = 7777
$allowedCodes = @("AFR1-1234", "ANT-5678", "ASI-9012", "EUR-3456", "NAM-7890", "RUS-2345", "SAM-6789", "AFR-1122", "CAN-3344", "KOR-5566")
$errorLog = "error_log.txt"
$connectionLog = "connection_log.txt"
$userLog = "user_log.txt"

# Function to log errors
function Log-Error {
    param (
        [string]$message
    )
    Add-Content -Path $errorLog -Value "$(Get-Date): $message"
}

# Function to log connections
function Log-Connection {
    param (
        [string]$message
    )
    Add-Content -Path $connectionLog -Value "$(Get-Date): $message"
}

# Function to log user details
function Log-User {
    param (
        [string]$userIP,
        [string]$code
    )
    Add-Content -Path $userLog -Value "$(Get-Date): IP: $userIP, Code: $code"
}

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
            Log-Connection "Connection accepted from $clientIP with code $code"
            Log-User $clientIP $code

            # Start Unreal Engine server with the specified parameters
            $ueServerPath = "C:\Program Files\Epic Games\UE_5.3\Engine\Binaries\Win64\UnrealEditor.exe"
            $ueProjectPath = "C:\Users\herre\OneDrive\Documents\Unreal Projects\PolyStrike\Data\Low Poly Shooter Pack v5.0\PolyStrike.uproject"
            $ueServerParams = "MainMenu_Level-server-log -nosteam"
            Start-Process -FilePath $ueServerPath -ArgumentList "`"$ueProjectPath`" $ueServerParams" -NoNewWindow

        } else {
            $writer.WriteLine("Invalid code")
            Log-Error "Invalid code: $code from $clientIP"
        }
    } catch {
        Log-Error "Error processing request from $clientIP: $_"
    }

    $client.Close()
}
