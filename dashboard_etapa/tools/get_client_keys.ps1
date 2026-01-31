# Cargar variables
$envPath = "../.env"
$projectRef = "crisfmzsxqonuxkbguur" # ID encontrado en el paso anterior

Get-Content $envPath | ForEach-Object {
    if ($_ -match "SUPABASE_ACCESS_TOKEN=(.*)") {
        $global:TOKEN = $matches[1].Trim()
    }
}

$headers = @{
    "Authorization" = "Bearer $global:TOKEN"
    "User-Agent"    = "IAmazing-Dashboard/1.0"
}

Write-Host "Fetching API Keys for Project $projectRef..."

# Endpoint para obtener claves (No documentado públicamente a veces, pero estándar en v1)
# Intento 1: /api-keys (Puede no funcionar, fallback a /settings si falla)
try {
    # Nota: El endpoint oficial puede ser diferente. Probemos obtener la info del proyecto que a veces incluye config de conexión.
    # En realidad, api.supabase.com/v1/projects/{ref}/api-keys es válido.
    $response = Invoke-RestMethod -Uri "https://api.supabase.com/v1/projects/$projectRef/api-keys" -Method Get -Headers $headers -ErrorAction Stop
    
    Write-Host "SUCCESS: Keys retrieved."
    Write-Host ("-" * 40)
    
    $anonKey = ($response | Where-Object { $_.name -eq "anon" }).api_key
    $serviceKey = ($response | Where-Object { $_.name -eq "service_role" }).api_key
    
    # Escribir en un archivo temporal json para que el agente lo lea (seguro)
    $keys = @{
        "NEXT_PUBLIC_SUPABASE_URL"      = "https://$projectRef.supabase.co"
        "NEXT_PUBLIC_SUPABASE_ANON_KEY" = $anonKey
        "SUPABASE_SERVICE_ROLE_KEY"     = $serviceKey
    }
    
    $keys | ConvertTo-Json | Out-File "temp_keys.json"
    Write-Host "Keys saved to temp_keys.json"
}
catch {
    Write-Error "Failed to get keys: $_"
    # Si falla, quizás no tengamos permisos, intentaremos instruir al usuario.
    exit 1
}
