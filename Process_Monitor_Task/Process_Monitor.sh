#!/usr/bin/env bash

##################################### 1. Script Info ############################################
# Author: Reem Mahmoud
# Date: 2024-08-30
# Version: 1.0
# Description: This script serves as a process management tool for Unix-like systems. It allows
#              users to view, manage, and analyze running processes interactively through a menu.
# Inputs: User input via menu selection and process-related queries (e.g., process name or PID).
# Outputs: Displays process information, statistics, and alerts; allows killing of processes.
#################################################################################################

##################################### 2. Source Files & Global Variables ########################
# Source files (if any)
CONFIG_FILE="Process_Monitor.conf"

# shellcheck source=/home/rero/Downloads/Embedded_Linux-main/Process_Monitor_Task/Process_Monitor.conf
if [[ -f "$CONFIG_FILE" ]]; then
    source ${CONFIG_FILE}
else
    echo "Error: Configuration file not found."
    exit 1
fi

# Global variables
UPDATE_INTERVAL=${UPDATE_INTERVAL:-5}
CPU_ALERT_THRESHOLD=${CPU_ALERT_THRESHOLD:-90}
MEMORY_ALERT_THRESHOLD=${MEMORY_ALERT_THRESHOLD:-80}

# Function declarations
list_processes() {
    ps -eo pid,comm,%cpu,%mem  # List all processes with a custom format
}

process_info() {
    local process_name=$1   
    ps -C "${process_name}" -o pid,ppid,user,%cpu,%mem,etime,cmd  # Get details for the named process
}

kill_process() {
    local process_pid=$1  
    (kill "${process_pid}" && echo "Process with PID ${process_pid} has been terminated") || (echo "Error: Invalid PID"; exit 1)
}

process_statistics() {
    echo "----------------------- Process Count ------------------------"
    echo "Total processes: $(ps -e | wc -l)"  # Count all lines from the ps command

    echo "-------------------------- Memory Usage ------------------------"
    free -h | awk '/Mem/{print "Memory Usage: "$3"/"$2}'

    echo "---------------------------- CPU Load --------------------------"
    top -bn1 | grep "Cpu(s)" | awk '{print "CPU Load: " 100 - $8 "%"}'  # Calculate total CPU load without idle time
}

real_time_monitor() {
    while true; do
        clear
        list_processes
        sleep "${UPDATE_INTERVAL}"
    done
}

resource_alert() {
    ps aux | awk -v cpu_thresh="${CPU_ALERT_THRESHOLD}" -v mem_thresh="${MEMORY_ALERT_THRESHOLD}" '
    NR > 1 {
        if ($3 > cpu_thresh) {
            print "Alert: Process "$11" (PID: "$2") exceeds "cpu_thresh"% CPU usage."
        }
        if ($4 > mem_thresh) {
            print "Alert: Process "$11" (PID: "$2") exceeds "mem_thresh"% memory usage."
        }
    }'
}

##################################### 3. Main Function & Script Logic ##########################
# Main function
main() {
    local process_name
    local process_pid

    select option in "List Running Processes" "Process Information" "Terminate Process" "View Process Statistics" "Monitor in Real-Time" "Resource Usage Alerts" "Exit"; do
        case "${option}" in
            "List Running Processes")
                list_processes
            ;;
            "Process Information")
                read -r -p "Enter the process name: " process_name
                process_info "${process_name}"
            ;;
            "Terminate Process")
                read -r -p "Enter the process PID: " process_pid
                kill_process "${process_pid}"
            ;;
            "View Process Statistics")
                process_statistics
            ;;
            "Monitor in Real-Time")
                real_time_monitor
            ;;
            "Resource Usage Alerts")
                resource_alert
            ;;
            "Exit")
                echo "Exiting. Have a nice day!"
                exit 0
            ;;
            *)
                echo "Invalid choice. Please try again."
                exit 1
            ;;
        esac
    done
}

##################################### 4. Calling Main Function ##################################
# Call the main function with arguments
main
