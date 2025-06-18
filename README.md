# VNC Null Password Checker

A simple and efficient Bash script to scan a list of hosts for VNC (Virtual Network Computing) services that allow access with a blank/null password. This tool is designed for penetration testers and network administrators to quickly identify a common and critical misconfiguration.

## Features

- **Bulk Scanning**: Reads a list of target hosts from a specified file.
- **Null Password Check**: Specifically tests for the empty password vulnerability.
- **Proof of Concept**: Automatically takes a screenshot upon successful connection and saves it as `SUCCESS-<hostname>.jpg`.
- **Color-Coded Output**: Provides clear, color-coded terminal output for easy identification of successful (`SUCCESS`) versus failed (`FAILED`) attempts.
- **Lightweight & Fast**: A simple Bash script with minimal dependencies, making it fast and portable.
- **Configurable**: Easily change the target port and connection timeout within the script.

## Prerequisites

Before running this script, you need to have the following tool installed:

- `vncsnapshot`: A command-line utility for taking VNC screenshots.

### Installing `vncsnapshot`

On Debian-based systems like Kali Linux or Ubuntu, you can install it easily with `apt`:

```bash
sudo apt update && sudo apt install -y vncsnapshot
```

## Installation & Usage

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/vnc-null-checker.git
cd vnc-null-checker
```

### 2. Make the Script Executable

```bash
chmod +x check_vnc.sh
```

### 3. Create Your Target File

Create a text file (e.g., `targets.txt`) and populate it with the IP addresses or hostnames you want to scan, one per line.

```
192.168.1.10
192.168.1.15
some-server.local
```

### 4. Run the Script

Execute the script and provide your target file as an argument:

```bash
./check_vnc.sh targets.txt
```

Successful connections will be highlighted in green, and screenshots will be saved in the `vnc_success_screenshots/` directory, which is created automatically.

## Disclaimer

This tool is intended for use in authorized security testing and network administration scenarios only. Unauthorized scanning of networks is illegal. The user is responsible for ensuring they have explicit, written permission to test any targets. The author is not responsible for any misuse or damage caused by this script.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
