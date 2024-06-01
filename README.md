# UE5 Tunnel Server Solution

This solution provides a way to host UE5 games over LAN with remote connections, allowing players from different locations to join games as if they were on the same local network.

## Prerequisites

- Windows operating system
- PowerShell

## Setup Instructions

**Notes:**
 The `AuthCodes` folder within the `Host` folder contains an `AuthorisationCodes.txt` file for each available server area/continent or country. 
Later you can Add new codes to this file for additional server areas but for now only the north american one is active for testing.

1. Clone or download this repository.
2. Run the `HostScript.ps1` on your hosting machine to start the server.
3. Run the `Client.bat` on client machines to connect to the server.

## Usage

1. **HostScript.ps1**: This script listens for incoming connections and verifies the user's authorization code.
   
   - The script logs errors, connections, and user details to separate log files.
   - Modify the `$allowedCodes` array to include your authorization codes.

2. **Client.bat**: This batch file provides a menu for connecting to our custom Aster-Server.
   

3. **StatsScript.ps1**: This script provides statistics on users currently connected to the server.


---

**Note**: Ensure that your network configuration allows incoming connections on the specified port (default is 7777) for the server to work correctly.
