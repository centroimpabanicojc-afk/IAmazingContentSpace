# test_db_connect.ps1
$envPath = "../.env"

# 1. Cargar Variables
$env = @{}
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "([^=]+)=(.*)") {
            $env[$matches[1]] = $matches[2].Trim()
        }
    }
}

$url = $env["NEXT_PUBLIC_SUPABASE_URL"]
$key = $env["SUPABASE_SERVICE_ROLE_KEY"] # Usar Service Key para bypass RLS y verificar datos

if (-not $url -or -not $key) {
    Write-Error "Missing SUPABASE URL or KEY in .env"
    exit 1
}

Write-Host "Testing Connection to: $url"
Write-Host "Querying table: team_members..."

$headers = @{
    "apikey"        = $key
    "Authorization" = "Bearer $key"
    "Content-Type"  = "application/json"
}

try {
    # PostgREST Endpoint
    $endpoint = "$url/rest/v1/team_members?select=first_name,role,active"
    $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers -ErrorAction Stop
    
    Write-Host "SUCCESS: Connection established."
    Write-Host "Found $($response.Count) team members in database:"
    Write-Host ("-" * 40)
    
    foreach ($member in $response) {
        Write-Host "[$($member.role)] $($member.first_name) (Active: $($member.active))"
    }
    Write-Host ("-" * 40)
}
catch {
    Write-Error "Connection Failed: $_"
    exit 1
}
