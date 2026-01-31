# deploy_schema.ps1
$envPath = "../.env"
$projectRef = "crisfmzsxqonuxkbguur"
$sqlPath = "../architecture/00_init_supabase.sql"

# 1. Obtener Token
Get-Content $envPath | ForEach-Object {
    if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
        $global:TOKEN = $matches[1].Trim()
    }
}

# 2. Leer SQL
$sqlContent = Get-Content $sqlPath -Raw

Write-Host "Deploying Schema to Project $projectRef..."

$headers = @{
    "Authorization" = "Bearer $global:TOKEN"
    "User-Agent"    = "IAmazing-Dashboard/1.0"
    "Content-Type"  = "application/json"
}

$body = @{
    query = $sqlContent
} | ConvertTo-Json

# 3. Enviar Query (Endpoint valido para ejecutar SQL raw)
try {
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects/$projectRef/query" -Method Post -Headers $headers -Body $body -ErrorAction Stop
    
    Write-Host "SUCCESS: SQL Executed."
    Write-Host ("-" * 40)
    # Output puede ser array de resultados, mostramos resumen
    if ($response) {
        Write-Host "Response received." 
    }
}
catch {
    Write-Error "Deployment Failed: $_"
    $errorDetails = $_.Exception.Response.GetResponseStream()
    $reader = New-Object System.IO.StreamReader($errorDetails)
    Write-Host $reader.ReadToEnd()
    exit 1
}
