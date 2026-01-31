# debug_sql.ps1
$envPath = "../.env"
$projectRef = "crisfmzsxqonuxkbguur"

# 1. Obtener Token
Get-Content $envPath | ForEach-Object {
    if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
        $token = $matches[1].Trim()
    }
}

$sql = "SELECT 1;"

$headers = @{
    "Authorization" = "Bearer $token"
    "Content-Type"  = "application/json"
}

$bodyObj = @{ query = $sql }
$bodyJson = $bodyObj | ConvertTo-Json -Compress

Write-Host "Body: $bodyJson"

try {
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects/$projectRef/database/query" -Method Post -Headers $headers -Body $bodyJson -ErrorAction Stop
    Write-Host "Response: $($response | ConvertTo-Json)"
}
catch {
    Write-Host "Error: $_"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        Write-Host "Server Message: $($reader.ReadToEnd())"
    }
}
