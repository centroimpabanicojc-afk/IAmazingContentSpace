# calc_metrics.ps1
# Uso: .\calc_metrics.ps1

$envPath = "../.env"
$env = @{}
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "([^=]+)=(.*)") {
            $env[$matches[1]] = $matches[2].Trim()
        }
    }
}

$url = $env["NEXT_PUBLIC_SUPABASE_URL"]
$key = $env["SUPABASE_SERVICE_ROLE_KEY"]

if (-not $url -or -not $key) {
    Write-Error "Missing SUPABASE URL or KEY in .env"
    exit 1
}

$headers = @{
    "apikey"        = $key
    "Authorization" = "Bearer $key"
    "Content-Type"  = "application/json"
    "Prefer"        = "return=representation,resolution=merge-duplicates"
}

Write-Host "Calculating daily metrics..."

try {
    # 1. Obtener proyectos
    $endpoint = "$url/rest/v1/projects?select=status"
    $projects = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers -ErrorAction Stop
    
    $total = $projects.Count
    $completed = ($projects | Where-Object { $_.status -eq "completed" }).Count
    
    # 2. Calcular Revenue (Modelo base)
    $revenue = $total * 15 

    # 3. Guardar en production_metrics
    $today = (Get-Date).ToString("yyyy-MM-dd")
    $body = @{
        date               = $today
        total_projects     = $total
        completed_projects = $completed
        revenue            = $revenue
        avg_cycle_time     = 0 
    } | ConvertTo-Json

    $metricsEndpoint = "$url/rest/v1/production_metrics"
    
    $response = Invoke-RestMethod -Uri $metricsEndpoint -Method Post -Headers $headers -Body $body -ErrorAction Stop
    Write-Host "SUCCESS: Metrics updated for $today."
    $response | ConvertTo-Json
}
catch {
    Write-Error "Failed to calculate metrics: $_"
    exit 1
}
