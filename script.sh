#!/bin/bash

set -e

# Get the image argument passed from the action
IMAGE="${1:-.}"

echo "Container Image Scan Action"
echo "Image to scan: $IMAGE"
echo ""

# Write the result somewhere the runner can see it (bind-mounted from the host)
RESULT_DIR="$GITHUB_WORKSPACE/.scan"
mkdir -p "$RESULT_DIR"
OUTPUT_FILE="$RESULT_DIR/image-scan-result.json"

# Scan with trivy
# Temporarily disable exit-on-error to capture exit code
set +e
trivy image --scanners vuln --format json -o "${OUTPUT_FILE}" "${IMAGE}" 2>&1
SCRIPT_EXIT_CODE=$?
set -e

echo "Script execution completed with exit code: $SCRIPT_EXIT_CODE"

# Read the captured output
SCAN_OUTPUT=$(cat "$OUTPUT_FILE")
echo "-- SCAN OUTPUT START --"
cat "$OUTPUT_FILE"
echo "-- SCAN OUTPUT END --"

# Set GitHub Action outputs
# The output needs to be properly escaped for multiline content
if [ -n "$GITHUB_OUTPUT" ]; then
  # Path as seen from the runner: /github/workspace inside == ${{ github.workspace }} outside,
  # so return a workspace-relative path
  echo "scan-file=.scan/image-scan-result.json" >> "$GITHUB_OUTPUT"
  echo "exit-code=$SCRIPT_EXIT_CODE" >> "$GITHUB_OUTPUT"

  # keep the inline output too, with a unique delimiter
  DELIM="EOF_$(openssl rand -hex 8 2>/dev/null || date +%s%N)"
  { echo "scan-output<<$DELIM"; cat "$OUTPUT_FILE"; echo "$DELIM"; } >> "$GITHUB_OUTPUT"
  
  echo ""
  echo "GitHub Action outputs have been set:"
  echo "- scan-output: Contains the full scan output"
  echo "- scan-file": Path to scan result json file
  echo "- exit-code: $SCRIPT_EXIT_CODE"
fi


# Clean up temporary file
#rm -f "$OUTPUT_FILE"

# Exit with the same code as the script
exit $SCRIPT_EXIT_CODE