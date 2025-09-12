# Container Scan Action

A GitHub Action that scans container images for vulnerabilities using a custom script.

## Description

This action executes a custom scanning script located at `/usr/local/bin/script.sh` within the container image and captures its outputs. 

The script analyzes files in a specified image and provides vulnerability scan results.

## Usage

```yaml
name: Container Scan
on: [push, pull_request]

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Run Container Scan
      id: scan
      uses: fm-labs/container-scan-action@v1
      with:
        image: 'nginx:latest'
        
    - name: Display scan results
      run: |
        echo "Exit code: ${{ steps.scan.outputs.exit-code }}"
        echo "Scan output:"
        echo "${{ steps.scan.outputs.scan-output }}"
```

## Inputs

| Input | Description              | Required | Default |
|-------|--------------------------|----------|---------|
| `image` | The container image name | Yes      | `` |

## Outputs

| Output | Description |
|--------|-------------|
| `scan-output` | Complete output from the container scan script |
| `exit-code` | Exit code from the scan script (0 = success) |

## Features

- Executes custom scanning binary at `/usr/local/bin/script.sh`
- Passes the specified image as an argument to the script
- Captures both stdout and stderr from the script execution
- Provides structured outputs for use in subsequent workflow steps
- Handles script exit codes appropriately

## Example Scan Output

The scan output typically includes:
- Files analyzed count
- Vulnerability severity breakdown
- Scan completion status
- Total files scanned

## License

This project is licensed under the MIT License.
