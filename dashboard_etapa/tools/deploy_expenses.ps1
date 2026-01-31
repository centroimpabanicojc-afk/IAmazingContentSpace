# deploy_expenses.ps1
$envPath = "../.env"
$projectRef = "crisfmzsxqonuxkbguur"
$sqlPath = "../architecture/03_expenses_schema.sql"

# 1. Obtener Token
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
            $global:TOKEN = $matches[1].Trim()
        }
    }
}
else {
    Write-Error ".env file not found at $envPath"
    exit 1
}

# 2. Leer SQL
$sqlContent = Get-Content $sqlPath -Raw

Write-Host "Deploying Expenses Schema to Project $projectRef..."

$headers = @{
    "Authorization" = "Bearer $global:TOKEN"
    "User-Agent"    = "IAmazing-Dashboard/1.0"
    "Content-Type"  = "application/json"
}

$body = @{
    query = $sqlContent
} | ConvertTo-Json

# 3. Enviar Query
try {
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects/$projectRef/query" -Method Post -Headers $headers -Body $body -ErrorAction Stop
    
    Write-Host "SUCCESS: SQL Executed."
    Write-Host ("-" * 40)
    if ($response) {
        Write-Host "Response received: $response" 
    }
}
catch {
    Write-Error "Deployment Failed: $_"
    if ($_.Exception.Response) {
        $errorDetails = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($errorDetails)
        Write-Host $reader.ReadToEnd()
    }
    exit 1
}
