#!/usr/bin/env bash

##################################### 1. Script Info ############################################
# Author: Reem Mahmoud
# Date: 2024-08-30
# Version: 1.0
# Description: Analyzes network traffic from a .pcap file and generates a summary report.
# Inputs: Path to the .pcap file
# Outputs: Summary report including packet counts and top IP addresses
#################################################################################################

##################################### 2. Source Files & Global Variables ########################
# Source files (if any)
# Example: source /path/to/your/utility.sh

# Global variables
# Example: LOG_FILE="/var/log/traffic_analysis.log"

##################################### 3. Function Declarations #################################
# Analyzes network traffic and prints statistics from the given .pcap file.
function analyze_traffic() {
    local PCAP_FILE="$1"
    local TOTAL_PACKETS
    local HTTP_PACKETS
    local HTTPS_TLS_PACKETS

    # Calculate total number of packets
    TOTAL_PACKETS=$(tshark -r "${PCAP_FILE}" | wc -l)
    
    # Calculate number of HTTP packets
    HTTP_PACKETS=$(tshark -r "${PCAP_FILE}" -Y http | wc -l)
    
    # Calculate number of HTTPS/TLS packets
    HTTPS_TLS_PACKETS=$(tshark -r "${PCAP_FILE}" -Y tls | wc -l)

    # Output analysis summary
    echo "----- Network Traffic Analysis Report -----"
    echo "1. Total Packets: ${TOTAL_PACKETS}"
    echo "2. Protocols:"
    echo "   - HTTP: ${HTTP_PACKETS} packets"
    echo "   - HTTPS/TLS: ${HTTPS_TLS_PACKETS} packets"
    echo ""
    echo "3. Top 5 Source IP Addresses:"
    # Display the top source IP addresses
    tshark -r "${PCAP_FILE}" -T fields -e ip.src | sort | uniq -c | sort -nr | head -n 5
    echo ""
    echo "4. Top 5 Destination IP Addresses:"
    # Display the top destination IP addresses
    tshark -r "${PCAP_FILE}" -T fields -e ip.dst | sort | uniq -c | sort -nr | head -n 5
    echo ""
    echo "------------- End of Report --------------"
}

##################################### 4. Main Function & Script Logic ##########################
# Main function
function main() {
    if [[ -z "$1" ]]; then
        echo "Usage: $0 <path-to-pcap-file>"
        exit 1
    fi
    analyze_traffic "$1"  # Call the analyze_traffic function with the provided .pcap file
}

##################################### 5. Calling Main Function ##################################
# Call the main function with arguments
main "$1"  # Execute the main function with the provided argument from the command line
