# 🤖 INSTALADOR AUTOMÁTICO DE GIT PARA WINDOWS
# Este script intenta múltiples métodos hasta instalar Git exitosamente

$ErrorActionPreference = "Continue"

Write-Host "🚀 INSTALADOR AUTOMÁTICO DE GIT" -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Gray
Write-Host ""

# Verificar si Git ya está instalado
function Test-GitInstalled {
    try {
        $version = git --version 2>$null
        if ($version) {
            Write-Host "✅ Git ya está instalado: $version" -ForegroundColor Green
            return $true
        }
    }
    catch {
        return $false
    }
    return $false
}

if (Test-GitInstalled) {
    Write-Host ""
    Write-Host "No es necesario instalar Git. Saliendo..." -ForegroundColor Yellow
    exit 0
}

Write-Host "📥 Git no detectado. Procediendo con instalación automática..." -ForegroundColor Yellow
Write-Host ""

# MÉTODO 1: WinGet
Write-Host "🔧 MÉTODO 1: Intentando con WinGet..." -ForegroundColor Cyan
try {
    $null = Get-Command winget -ErrorAction Stop
    Write-Host "   ✅ WinGet encontrado" -ForegroundColor Green
    Write-Host "   📦 Instalando Git..." -ForegroundColor White
    
    $output = winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Git instalado exitosamente con WinGet" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  IMPORTANTE: Cierra y vuelve a abrir PowerShell para usar Git" -ForegroundColor Yellow
        exit 0
    }
}
catch {
    Write-Host "   ❌ WinGet no disponible" -ForegroundColor Red
}

Write-Host ""

# MÉTODO 2: Chocolatey
Write-Host "🔧 MÉTODO 2: Intentando con Chocolatey..." -ForegroundColor Cyan
try {
    $null = Get-Command choco -ErrorAction Stop
    Write-Host "   ✅ Chocolatey encontrado" -ForegroundColor Green
    Write-Host "   📦 Instalando Git..." -ForegroundColor White
    
    choco install git -y
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Git instalado exitosamente con Chocolatey" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  IMPORTANTE: Cierra y vuelve a abrir PowerShell para usar Git" -ForegroundColor Yellow
        exit 0
    }
}
catch {
    Write-Host "   ❌ Chocolatey no disponible" -ForegroundColor Red
}

Write-Host ""

# MÉTODO 3: Scoop
Write-Host "🔧 MÉTODO 3: Intentando con Scoop..." -ForegroundColor Cyan
try {
    $null = Get-Command scoop -ErrorAction Stop
    Write-Host "   ✅ Scoop encontrado" -ForegroundColor Green
    Write-Host "   📦 Instalando Git..." -ForegroundColor White
    
    scoop install git
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "   ✅ Git instalado exitosamente con Scoop" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  IMPORTANTE: Cierra y vuelve a abrir PowerShell para usar Git" -ForegroundColor Yellow
        exit 0
    }
}
catch {
    Write-Host "   ❌ Scoop no disponible" -ForegroundColor Red
}

Write-Host ""

# MÉTODO 4: Descarga Directa + Instalación Silenciosa
Write-Host "🔧 MÉTODO 4: Descarga directa desde GitHub..." -ForegroundColor Cyan
Write-Host "   📡 Obteniendo última versión..." -ForegroundColor White

try {
    # Obtener la última release de Git para Windows
    $latestRelease = Invoke-RestMethod -Uri "https://api.github.com/repos/git-for-windows/git/releases/latest"
    $asset = $latestRelease.assets | Where-Object { $_.name -like "*64-bit.exe" -and $_.name -notlike "*MinGit*" } | Select-Object -First 1
    
    if (-not $asset) {
        throw "No se encontró el instalador"
    }
    
    $downloadUrl = $asset.browser_download_url
    $installerName = $asset.name
    $installerPath = Join-Path $env:TEMP $installerName
    
    Write-Host "   📥 Descargando: $installerName" -ForegroundColor White
    Write-Host "   ⏳ Esto puede tomar unos minutos..." -ForegroundColor Yellow
    
    # Descargar con barra de progreso
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath -UseBasicParsing
    $ProgressPreference = 'Continue'
    
    Write-Host "   ✅ Descarga completada" -ForegroundColor Green
    
    # Verificar que se descargó correctamente
    if (-not (Test-Path $installerPath)) {
        throw "El instalador no se descargó correctamente"
    }
    
    $fileSize = (Get-Item $installerPath).Length / 1MB
    Write-Host "   📦 Tamaño: $([math]::Round($fileSize, 2)) MB" -ForegroundColor White
    
    # Instalar silenciosamente
    Write-Host "   🔧 Instalando Git (instalación silenciosa)..." -ForegroundColor White
    Write-Host "   ⏳ Por favor espera (puede tomar 1-2 minutos)..." -ForegroundColor Yellow
    
    $process = Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT", "/NORESTART", "/NOCANCEL", "/SP-" -Wait -PassThru -NoNewWindow
    
    # Esperar un momento para que se complete
    Start-Sleep -Seconds 3
    
    # Limpiar
    Remove-Item $installerPath -Force -ErrorAction SilentlyContinue
    
    # Verificar instalación
    # Necesitamos actualizar PATH temporalmente
    $machinePath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $userPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = $machinePath + ";" + $userPath
    
    # Intentar encontrar Git
    $gitPaths = @(
        "C:\Program Files\Git\bin\git.exe",
        "C:\Program Files (x86)\Git\bin\git.exe"
    )
    
    $gitFound = $false
    foreach ($gitPath in $gitPaths) {
        if (Test-Path $gitPath) {
            $version = & $gitPath --version
            Write-Host ""
            Write-Host "   ✅ Git instalado exitosamente: $version" -ForegroundColor Green
            Write-Host "   📁 Ubicación: $gitPath" -ForegroundColor White
            $gitFound = $true
            break
        }
    }
    
    if ($gitFound) {
        Write-Host ""
        Write-Host "🎉 ¡INSTALACIÓN COMPLETADA!" -ForegroundColor Green
        Write-Host ""
        Write-Host "⚠️  IMPORTANTE: Cierra y vuelve a abrir PowerShell para usar Git" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Para verificar, ejecuta: git --version" -ForegroundColor Cyan
        exit 0
    }
    else {
        Write-Host "   ⚠️  Git se instaló pero no se puede verificar en esta sesión" -ForegroundColor Yellow
        Write-Host "   Cierra y vuelve a abrir PowerShell, luego ejecuta: git --version" -ForegroundColor White
        exit 0
    }
    
}
catch {
    Write-Host "   ❌ Error en descarga directa: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Gray
Write-Host "❌ NO SE PUDO INSTALAR GIT AUTOMÁTICAMENTE" -ForegroundColor Red
Write-Host ""
Write-Host "Por favor, instala Git manualmente:" -ForegroundColor Yellow
Write-Host "1. Ve a: https://git-scm.com/download/win" -ForegroundColor White
Write-Host "2. Descarga el instalador de 64-bit" -ForegroundColor White
Write-Host "3. Ejecuta el instalador" -ForegroundColor White
Write-Host "4. Reinicia PowerShell" -ForegroundColor White
Write-Host ""
Write-Host "O lee el archivo: INSTALL_GIT.md" -ForegroundColor Cyan
Write-Host ""

exit 1
