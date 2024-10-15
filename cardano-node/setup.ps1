# Read .env file
$envConfig = @{}
Get-Content .env | ForEach-Object {
    if ($_ -match '^([^=]+)=(.*)$') {
        $key = $matches[1].Trim()
        $value = $matches[2].Trim()
        $envConfig[$key] = $value
    }
}

# Create necessary directories
$dataDir = $envConfig.DATA_DIR -replace '\\', '/'
$ipcDir = $envConfig.IPC_DIR -replace '\\', '/'

New-Item -ItemType Directory -Force -Path $dataDir
New-Item -ItemType Directory -Force -Path "$dataDir/config"
New-Item -ItemType Directory -Force -Path $ipcDir

# Download configuration files
$baseUrl = "https://book.world.dev.cardano.org/environments/$($envConfig.NETWORK)"
$files = @("config", "topology", "byron-genesis", "shelley-genesis", "alonzo-genesis")

foreach ($file in $files) {
    $outputFile = Join-Path $dataDir "config/$($envConfig.NETWORK)-$file.json"
    if (-not (Test-Path $outputFile)) {
        Invoke-WebRequest -Uri "$baseUrl/$file.json" -OutFile $outputFile
        Write-Host "Downloaded $file.json"
    } else {
        Write-Host "$file.json already exists"
    }
}

Write-Host "Setup complete. You can now run 'docker-compose up -d' to start your Cardano node."