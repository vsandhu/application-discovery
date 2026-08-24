$ErrorActionPreference = 'Stop'

$discoveryDir = Join-Path $PSScriptRoot '..\discovery'

if (-not (Test-Path $discoveryDir)) {
    Write-Host 'Discovery directory does not exist; validation skipped.'
    exit 0
}

$required = @(
    '00-manifest.md',
    '01-application-overview.md',
    '02-business-domains.md',
    '03-architecture.md',
    '04-technology-stack.md',
    '05-non-functional-characteristics.md',
    '06-database.md',
    '07-external-integrations.md',
    '08-evidence-index.md'
)

$failed = $false

foreach ($file in $required) {
    $path = Join-Path $discoveryDir $file
    if (-not (Test-Path $path)) {
        Write-Error "Missing discovery artifact: $path"
        $failed = $true
    }
}

$model = Join-Path $discoveryDir 'discovery-model.yaml'
if (-not (Test-Path $model)) {
    Write-Error "Missing canonical discovery model: $model"
    $failed = $true
}

if ($failed) {
    exit 1
}

Write-Host 'Discovery validation passed.'
exit 0
