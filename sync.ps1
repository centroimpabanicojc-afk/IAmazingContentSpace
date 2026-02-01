# Script de Sincronización Automática - IAmazing Dashboard
# Este script prepara, guarda y sube los cambios a GitHub automáticamente

$Message = $args[0]
if (-not $Message) {
    $Message = "Update: Synchronization at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
}

Write-Host "🔄 Iniciando proceso de sincronización..." -ForegroundColor Cyan

# 1. Añadir cambios
git add .

# 2. Verificar Seguridad Local
Write-Host "🛡️  Ejecutando escaneo de seguridad local..." -ForegroundColor Yellow
& ".\tools\test_github_security.ps1"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Sincronización abortada por razones de seguridad." -ForegroundColor Red
    exit 1
}

# 3. Commit y Push
Write-Host "🚀 Enviando cambios a GitHub..." -ForegroundColor Cyan
git commit -m "$Message"
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ ¡Sincronización completada con éxito!" -ForegroundColor Green
}
else {
    Write-Host "❌ Error durante la sincronización." -ForegroundColor Red
}

