# deploy_v3.ps1
$envPath = "../.env"
$projectRef = "crisfmzsxqonuxkbguur"
$sqlPath = "../architecture/04_kanban_assets.sql"

# 1. Obtener Token
Get-Content $envPath | ForEach-Object {
    if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
        $global:TOKEN = $matches[1].Trim()
    }
}

# 2. Leer SQL
if (Test-Path $sqlPath) {
    $sqlContent = Get-Content $sqlPath -Raw
}
else {
    Write-Error "SQL file not found at $sqlPath"
    exit 1
}

Write-Host "Deploying Payments Schema to Project $projectRef..."

$headers = @{
    "Authorization" = "Bearer $global:TOKEN"
    "Content-Type"  = "application/json"
}

$body = @{ query = "$sqlContent" } | ConvertTo-Json -Compress

# 3. Enviar Query
try {
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects/$projectRef/database/query" -Method Post -Headers $headers -Body $body -ErrorAction Stop
    Write-Host "SUCCESS: Payments Table Created."
    if ($response) {
        Write-Host "Records affected/Result: $response"
    }
}
catch {
    Write-Error "Deployment Failed: $_"
    if ($_.Exception.Response) {
        $errorStream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorStream)
        Write-Host "Server Message: $($reader.ReadToEnd())"
    }
    exit 1
}
