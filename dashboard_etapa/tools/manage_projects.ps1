# manage_projects.ps1
# Uso: .\manage_projects.ps1 -Action create -ClientID "..." -Service "video" -Deadline "2026-02-15"
#      .\manage_projects.ps1 -Action assign -ID "..." -MemberID "..."
#      .\manage_projects.ps1 -Action list

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("create", "assign", "set_status", "list")]
    [string]$Action,

    [string]$ID,
    [string]$ClientID,
    [string]$MemberID,
    [string]$Service,
    [string]$Status,
    [string]$Deadline,
    [int]$Priority = 3
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
    if (-not $ClientID -or -not $Service -or -not $Deadline) {
        Write-Error "ClientID, Service, and Deadline are required."
        exit 1
    }

    $body = @{
        client_id    = $ClientID
        service_type = $Service
        deadline     = $Deadline
        priority     = $Priority
        status       = "briefing"
    } | ConvertTo-Json

    try {
        $endpoint = "$url/rest/v1/projects"
        $response = Invoke-RestMethod -Uri $endpoint -Method Post -Headers $headers -Body $body -ErrorAction Stop
        Write-Host "SUCCESS: Project created."
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to create project: $_"
        exit 1
    }
}
elseif ($Action -eq "assign") {
    if (-not $ID -or -not $MemberID) { Write-Error "Project ID and MemberID are required."; exit 1 }
    
    $body = @{
        assigned_to = $MemberID
        status      = "production"
    } | ConvertTo-Json

    try {
        $endpoint = "$url/rest/v1/projects?id=eq.$ID"
        $response = Invoke-RestMethod -Uri $endpoint -Method Patch -Headers $headers -Body $body -ErrorAction Stop
        Write-Host "SUCCESS: Project assigned and moved to production."
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to assign project: $_"
        exit 1
    }
}
elseif ($Action -eq "set_status") {
    if (-not $ID -or -not $Status) { Write-Error "Project ID and Status are required."; exit 1 }
    
    $body = @{ status = $Status } | ConvertTo-Json
    if ($Status -eq "completed") {
        $body = @{ 
            status       = $Status 
            delivered_at = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
        } | ConvertTo-Json
    }

    try {
        $endpoint = "$url/rest/v1/projects?id=eq.$ID"
        $response = Invoke-RestMethod -Uri $endpoint -Method Patch -Headers $headers -Body $body -ErrorAction Stop
        Write-Host "SUCCESS: Status updated to $Status."
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to update status: $_"
        exit 1
    }
}
elseif ($Action -eq "list") {
    try {
        $endpoint = "$url/rest/v1/projects?select=id,service_type,status,deadline,clients(name),team_members(first_name)"
        $response = Invoke-RestMethod -Uri $endpoint -Method Get -Headers $headers -ErrorAction Stop
        $response | ConvertTo-Json
    }
    catch {
        Write-Error "Failed to list projects: $_"
        exit 1
    }
}
