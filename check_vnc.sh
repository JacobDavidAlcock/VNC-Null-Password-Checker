#!/bin/bash

# VNC Null Password Checker
#
# This script reads a list of target hosts from a file and attempts to
# connect to the VNC service (port 5900) on each one using an empty password.
#
# If the connection is successful, it takes a screenshot of the desktop and
# saves it as a JPEG file named SUCCESS-<hostname>.jpg.
#
# Usage:
# 1. Save this script as a file, e.g., check_vnc.sh
# 2. Make it executable: chmod +x check_vnc.sh
# 3. Ensure your target list (e.g., vnc.txt) exists.
# 4. Run the script: ./check_vnc.sh vnc.txt

# --- Configuration ---
# VNC Port to check
VNC_PORT=5900
# Timeout for the connection attempt in seconds
TIMEOUT=5

# --- Color Codes for Output ---
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# --- Prerequisite Check ---
# Check if the required tool 'vncsnapshot' is installed.
if ! command -v vncsnapshot &> /dev/null
then
    echo -e "${RED}[!] 'vncsnapshot' command not found.${NC}"
    echo "Please install it first. On Kali/Debian/Ubuntu, run:"
    echo "sudo apt update && sudo apt install -y vncsnapshot"
    exit 1
fi

# Check if a target file was provided as an argument.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_file>"
    echo "Example: $0 vnc.txt"
    exit 1
fi

TARGET_FILE="$1"

# Check if the target file exists.
if [ ! -f "$TARGET_FILE" ]; then
    echo -e "${RED}[!] Target file not found: $TARGET_FILE${NC}"
    exit 1
fi

# --- Main Script Logic ---
echo "[*] Starting VNC null password check on hosts from '$TARGET_FILE'..."
echo "[*] Successful connections will save a screenshot."
echo "----------------------------------------------------"

# Create a directory to store successful snapshots
mkdir -p vnc_success_screenshots
cd vnc_success_screenshots || exit

# Read each host from the provided file line by line.
while IFS= read -r host || [[ -n "$host" ]]; do
    # Skip empty lines
    if [ -z "$host" ]; then
        continue
    fi

    echo -ne "[*] Testing host: $host ... "

    # Attempt to take a snapshot with a blank password.
    # The -die C option tells it to exit if the connection fails for any reason.
    # The -quality 50 makes it faster.
    # We redirect stderr to /dev/null to hide connection error messages for cleaner output.
    if timeout "$TIMEOUT" vncsnapshot -die C -quality 50 "$host:$VNC_PORT" "SUCCESS-$host.jpg" 2>/dev/null; then
        echo -e "${GREEN}SUCCESS! Blank password accepted. Screenshot saved.${NC}"
    else
        echo -e "${RED}FAILED. No access with blank password.${NC}"
    fi
done < "../$TARGET_FILE"

echo "----------------------------------------------------"
echo "[*] VNC check completed. Successful screenshots are in the 'vnc_success_screenshots' directory."

