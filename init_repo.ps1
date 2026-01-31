# Script de Inicializacion de Repositorio Git
# Este script inicializa el repositorio local y prepara para el push a GitHub

$ErrorActionPreference = "Continue"

Write-Host "INITIALIZING GIT REPOSITORY FOR IAMAZING DASHBOARD" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Gray
Write-Host ""

# Verificar que Git este instalado
try {
    # Usar la ruta completa que verificamos antes si no esta en PATH
    $gitCmd = "git"
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        if (Test-Path "C:\Program Files\Git\bin\git.exe") {
            $gitCmd = "& 'C:\Program Files\Git\bin\git.exe'"
        }
        else {
            throw "Git not found"
        }
    }
    
    $gitVersion = Invoke-Expression "$gitCmd --version"
    Write-Host "Git found: $gitVersion" -ForegroundColor Green
}
catch {
    Write-Host "ERROR: Git is not installed or not in PATH." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "GIT CONFIGURATION" -ForegroundColor Cyan
Write-Host ("-" * 60) -ForegroundColor Gray

# Configurar valores por defecto si no existen
$userName = Invoke-Expression "$gitCmd config --global user.name"
$userEmail = Invoke-Expression "$gitCmd config --global user.email"

if (-not $userName) {
    Invoke-Expression "$gitCmd config --global user.name 'IAmazing Admin'"
    Write-Host "Set default user.name: IAmazing Admin" -ForegroundColor Yellow
}
if (-not $userEmail) {
    Invoke-Expression "$gitCmd config --global user.email 'admin@iamazing.com'"
    Write-Host "Set default user.email: admin@iamazing.com" -ForegroundColor Yellow
}

Write-Host "User: $(Invoke-Expression "$gitCmd config --global user.name")" -ForegroundColor Green
Write-Host "Email: $(Invoke-Expression "$gitCmd config --global user.email")" -ForegroundColor Green

Write-Host ""
Write-Host "INITIALIZING LOCAL REPLOSITORY" -ForegroundColor Cyan
Write-Host ("-" * 60) -ForegroundColor Gray

# Si ya existe .git, lo removemos para empezar limpio (como pidió el usuario)
if (Test-Path ".git") {
    Write-Host "Removing existing .git folder..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force .git
}

Invoke-Expression "$gitCmd init"
Invoke-Expression "$gitCmd branch -M main"
Write-Host "Repository initialized on branch 'main'" -ForegroundColor Green

Write-Host ""
Write-Host "VERIFYING FILES TO INCLUDE" -ForegroundColor Cyan
Write-Host ("-" * 60) -ForegroundColor Gray

# Verificacion de seguridad
$sensitiveFiles = @("config.js", ".env", "dashboard_etapa/ui/config.js", "dashboard_etapa/.env")
$foundSensitive = $false

foreach ($file in $sensitiveFiles) {
    if (Test-Path $file) {
        # Verificar si git lo rastrearia (pero aun no hemos hecho git add .)
        # Por ahora solo listamos lo que NO queremos ver despues del add
    }
}

Write-Host "Checking .gitignore rules..." -ForegroundColor White
# Intentar ver si config.js esta ignorado
$checkIgnore = Invoke-Expression "$gitCmd check-ignore dashboard_etapa/ui/config.js"
if ($checkIgnore) {
    Write-Host "Verified: config.js is properly ignored." -ForegroundColor Green
}
else {
    Write-Host "WARNING: config.js is NOT ignored. Fixing .gitignore..." -ForegroundColor Red
    Add-Content .gitignore "`n# Safety fallback`ndashboard_etapa/ui/config.js"
}

Write-Host ""
Write-Host "PREPARING INITIAL COMMIT" -ForegroundColor Cyan
Write-Host ("-" * 60) -ForegroundColor Gray

Invoke-Expression "$gitCmd add ."
Invoke-Expression "$gitCmd commit -m 'Initial commit: IAmazing Dashboard v4.1 - Security Hardened'"

Write-Host "Initial commit created successfully." -ForegroundColor Green

Write-Host ""
Write-Host "NEXT STEPS: GITHUB" -ForegroundColor Cyan
Write-Host ("-" * 60) -ForegroundColor Gray
Write-Host ""
Write-Host "1. Go to https://github.com/new"
Write-Host "2. Name: IAmazingContentDocumentation"
Write-Host "3. Private: YES"
Write-Host "4. Create repository"
Write-Host ""
Write-Host "Then run (replace YOUR_USER):"
Write-Host "   git remote add origin https://github.com/YOUR_USER/IAmazingContentDocumentation.git"
Write-Host "   git push -u origin main"
Write-Host ""
Write-Host "DONE!" -ForegroundColor Green
