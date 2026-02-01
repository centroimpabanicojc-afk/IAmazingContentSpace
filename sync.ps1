# Script de Sincronización Automática - IAmazing Dashboard
# Este script prepara, guarda y sube los cambios a GitHub automáticamente

$Message = $args[0]
if (-not $Message) {
    $Message = "Update: Synchronization at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
}

Write-Host "🔄 Sincronizando con GitHub..." -ForegroundColor Cyan

git add .
git commit -m "$Message"
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ ¡Sincronización completada con éxito!" -ForegroundColor Green
}
else {
    Write-Host "❌ Error durante la sincronización." -ForegroundColor Red
}
