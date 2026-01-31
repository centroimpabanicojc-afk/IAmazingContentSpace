# Cargar variables desde .env
$envPath = "../.env"
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
            $global:TOKEN = $matches[1].Trim()
        }
    }
}

if (-not $global:TOKEN) {
    Write-Error "Error: SUPABASE_ACCESS_TOKEN not found in .env"
    exit 1
}

Write-Host "Connecting to Supabase Management API via PowerShell..."

$headers = @{
    "Authorization" = "Bearer $global:TOKEN"
    "User-Agent" = "IAmazing-Dashboard/1.0"
}

try {
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects" -Method Get -Headers $headers -ErrorAction Stop
    
    Write-Host "SUCCESS: Found $($response.Count) projects."
    Write-Host ("-" * 40)
    
    foreach ($project in $response) {
        Write-Host "ID: $($project.id)"
        Write-Host "Name: $($project.name)"
        Write-Host "Status: $($project.status)"
        Write-Host "Region: $($project.region)"
        Write-Host ("-" * 40)
    }
}
catch {
    Write-Error "Request Error: $_"
    exit 1
}
