# Container Scan Action

A GitHub Action that scans container images for vulnerabilities.

## Description

The script the specified image and provides vulnerability scan results.

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

- Compiles SBOM (Software Bill of Materials)
- Scans for vulnerabilities
- Scans for license compliance issues


## License

This project is licensed under the MIT License.
