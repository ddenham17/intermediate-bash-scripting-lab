#!/bin/bash

# --- Help Feature ---
# Check if the script was called with -h or --help
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "==============================="
    echo "       SYSTEM INFO HELP       "
    echo "==============================="
    echo "This script opens a menu that allows you to view various system statistics."
    echo ""
    echo "Usage: ./sysinfo.sh [OPTION]"
    echo ""
    exit 0
fi

# Title
echo "==============================="
echo "       SYSTEM INFO MENU       "
echo "==============================="

# Menu Loop
while true; do
    echo ""
    echo "Welcome, select one of the following options using the number keys:"
    echo "-------------------------------"
    echo "1: Display System Info"
    echo "2: Display Disk Usage"
    echo "3: Display Current Users"
    echo "4: Display Top Processes"
    echo "5: Exit"

    # Capture user choice
    read -p "Please select an option [1-5]: " choice

    # Logic to handle selection using if/elif/else
    if [ "$choice" == "1" ]; then
        echo "--- System Information ---"
        echo "--- Generated on: $(date '+%Y-%m-%d %H:%M:%S') ---"
        echo "OS Name/Version: $(grep '^PRETTY_NAME=' /etc/os-release | cut -d'=' -f2 | tr -d '\"')"
        echo "Hostname: $(hostname)"
        echo "Kernel Version: $(uname -r)"
        echo "Uptime: $(uptime -p)"

    elif [ "$choice" == "2" ]; then
        echo "--- Disk Usage ---"
        echo "--- Generated on: $(date '+%Y-%m-%d %H:%M:%S') ---"
        df -h

    elif [ "$choice" == "3" ]; then
        echo "--- Current Logged-In Users & Activities ---"
        echo "--- Generated on: $(date '+%Y-%m-%d %H:%M:%S') ---"
        w

    elif [ "$choice" == "4" ]; then
        echo "--- Top 5 CPU Processes ---"
        echo "--- Generated on: $(date '+%Y-%m-%d %H:%M:%S') ---"
        echo "+------+------------+---------+--------------+"
        echo "| PID  | User       | CPU%    | Command      |"
        echo "+------+------------+---------+--------------+"
        # Formats the output with simple ASCII borders between sections
        ps -ao pid,user,pcpu,comm --sort=-pcpu | head -n 6 | tail -n 5 | \
        awk '{printf "| %-4s | %-10s | %-7s | %-12s |\n", $1, $2, $3"%", $4}'
        echo "+------+------------+---------+--------------+"

    elif [ "$choice" == "5" ]; then
        echo "Exiting the script. Goodbye!"
        echo "--- Generated on: $(date '+%Y-%m-%d %H:%M:%S') ---"
        exit 0
    else
        echo "Invalid selection! Please run the script again and choose 1-5."
    fi

    # Pause before showing the menu again
    echo ""
    read -p "Press [Enter] to return to the menu..."
done