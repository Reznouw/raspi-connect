$ErrorActionPreference = "Stop"

$RaspiHost = "100.119.164.32"
$RaspiUser = "pi"
$RaspiCommand = "raspi"

function Write-Step($Message) {
    Write-Host "[raspi-connect] $Message" -ForegroundColor Cyan
}

function Has-Command($Name) {
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

Write-Host ""
Write-Host "Raspi Connect" -ForegroundColor Green
Write-Host "Conecta esta consola a miraspi via Tailscale + SSH." -ForegroundColor DarkGray
Write-Host ""

if (-not (Has-Command ssh)) {
    Write-Host "No encontre ssh en esta computadora." -ForegroundColor Red
    Write-Host "Windows 10/11 normalmente lo incluye. Activa OpenSSH Client o usa otra terminal."
    exit 1
}

if (-not (Has-Command tailscale)) {
    Write-Step "Tailscale no encontrado. Intentare instalarlo con winget."
    if (-not (Has-Command winget)) {
        Write-Host "No encontre winget. No puedo instalar Tailscale automaticamente." -ForegroundColor Red
        Write-Host "Instala Tailscale manualmente o ejecuta este script en una PC con winget."
        exit 1
    }

    winget install --id Tailscale.Tailscale --accept-package-agreements --accept-source-agreements
}

Write-Step "Verificando estado de Tailscale."
$status = (& tailscale status 2>$null) -join "`n"
if ($LASTEXITCODE -ne 0 -or $status -match "Logged out|not running|NeedsLogin") {
    Write-Step "Tailscale necesita login. Se abrira el flujo de autenticacion."
    tailscale up
}

Write-Step "Conectando a miraspi."
Write-Host "Si es la primera vez, acepta la huella SSH escribiendo yes." -ForegroundColor Yellow
ssh -tt "$RaspiUser@$RaspiHost" $RaspiCommand
