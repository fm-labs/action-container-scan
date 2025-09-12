#!/bin/bash

# This script simulates a container scanning tool
# It takes a path as an argument and performs a mock scan

set -e

PATH_TO_SCAN="${1:-.}"

echo "Container Scan Action - Starting scan..."
echo "Scanning path: $PATH_TO_SCAN"
echo ""

# Simulate scanning process
echo "Analyzing files in $PATH_TO_SCAN..."
sleep 1

# Count files in the directory
FILE_COUNT=$(find "$PATH_TO_SCAN" -type f 2>/dev/null | wc -l)
echo "Found $FILE_COUNT files to analyze"

# Simulate vulnerability detection
echo ""
echo "Vulnerability scan results:"
echo "- No critical vulnerabilities found"
echo "- 2 medium severity issues detected"
echo "- 5 low severity issues detected"
echo ""

# Output scan summary
echo "Scan completed successfully!"
echo "Total files scanned: $FILE_COUNT"
echo "Scan status: COMPLETED"

# Exit with success
exit 0