#!/bin/bash

# This script simulates a container scanning tool
# It takes a image as an argument and performs a mock scan

set -e

PATH_TO_SCAN="${1:-.}"

echo "Container Scan Action - Starting scan..."
echo "Scanning image: $PATH_TO_SCAN"
echo ""

# Simulate scanning process
echo "Analyzing files in $PATH_TO_SCAN..."
sleep 1

# Count files in the directory
FILE_COUNT=$(find "$PATH_TO_SCAN" -type f 2>/dev/null | wc -l)
echo "Found $FILE_COUNT files to analyze"

# Simulate vulnerability detection with GitHub annotation format
echo ""
echo "Vulnerability scan results:"
# GitHub annotation format: ::error file=<file>,line=<line>,title=<title>::<message>
# For demonstration, annotate some sample vulnerabilities

echo "::notice file=Dockerfile,line=10,title=Medium severity issue detected::Potential use of outdated base image"
echo "::warning file=app.py,line=42,title=Medium severity issue detected::Unpinned dependency may introduce vulnerabilities"
echo "::error file=main.go,line=101,title=Low severity issue detected::Use of deprecated API detected"
echo "::notice file=README.md,line=5,title=Low severity issue detected::Sensitive info in documentation"
echo "::warning file=entrypoint.sh,line=22,title=Low severity issue detected::Unsafe shell command detected"
echo "::notice file=config.yaml,line=3,title=Low severity issue detected::Default credentials present"
echo ""

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
