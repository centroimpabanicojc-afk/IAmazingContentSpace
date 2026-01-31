# manage_clients.ps1
# Uso: .\manage_clients.ps1 -Action create -Name "Nombre" -Type "creator" -Tier "creator_15" -WhatsApp "58412..."
#      .\manage_clients.ps1 -Action list

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("create", "list", "get")]
    [string]$Action,

    [string]$Name,
    [string]$Type,
    [string]$Tier,
    [string]$WhatsApp,
    [string]$Email,
    [string]$ID
)

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
    "Prefer"        = "return=representation"
}

if ($Action -eq "create") {
    if (-not $Name -or -not $WhatsApp -or -not $Type -or -not $Tier) {
        Write-Error "Name, WhatsApp, Type, and Tier are required for creation."
        exit 1
    }

    $body = @{
        name     = $Name
        type     = $Type
        tier     = $Tier
        whatsapp = $WhatsApp
        email    = $Email
        status   = "active"
    } | ConvertTo-Json

    try {
        $endpoint = "$url/rest/v1/clients"
        $response = Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body $body -ErrorAction Stop
        Write-Host "SUCCESS: Client created."
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to create client: $_"
        exit 1
    }
}
elseif ($Action -eq "list") {
    try {
        $endpoint = "$url/rest/v1/clients?select=id,name,type,whatsapp,status"
        $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers -ErrorAction Stop
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to list clients: $_"
        exit 1
    }
}
elseif ($Action -eq "get") {
    if (-not $ID) { Write-Error "ID is required."; exit 1 }
    try {
        $endpoint = "$url/rest/v1/clients?id=eq.$ID"
        $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers -ErrorAction Stop
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to get client: $_"
        exit 1
    }
}
