# UE5 Tunnel Server Solution

This solution provides a way to host UE5 games over LAN with remote connections, allowing players from different locations to join games as if they were on the same local network.

## Prerequisites

- Windows operating system


## Setup Instructions

# AsterServer Auto Installer

This script (`AsterServer_AutoInstaller.bat`) simplifies the setup process for hosting and connecting to an AsterServer using Unreal Engine. It prompts the user to enter the necessary paths and generates the required batch files for hosting and connecting.

## Usage

1. Run `AsterServer_AutoInstaller.bat`.
2. Enter the path to the Unreal Engine editor executable when prompted.
3. Enter the path to the host project file.
4. Enter the path to the Unreal Engine client executable.
5. Enter the path to the client project file.
6. Enter the path to the folder containing the `AuthorizationCodes.txt` file for future server areas.

The script will generate two batch files:
- `HostScript.bat`: Use this file to host the AsterServer.
- `ClientScript.bat`: Use this file to connect to the AsterServer as a client.

Ensure that the paths provided are correct and point to valid Unreal Engine and project files. Modify the batch files if additional customization is needed.

## License

This project is SEMI-OPEN SOURCED TO CHOSEN PARTIES AND COLLABORATORS AND FULLY OPEN SOURCE TO MODDERS


---

**Note**: Ensure that your network configuration allows incoming connections on the specified port (default is 7777) for the server to work correctly.
