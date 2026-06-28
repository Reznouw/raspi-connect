# raspi-connect

Conector PowerShell para entrar a RaspiPilot desde Windows.

## Uso

Cuando este repo este en GitHub, puedes ejecutar:

```powershell
irm https://raw.githubusercontent.com/Reznouw/raspi-connect/main/connect.ps1 | iex
```

El script te pedira la IP/hostname Tailscale de tu Raspberry. Si quieres evitar escribirlo cada vez en una PC confiable:

```powershell
$env:MIRASPI_HOST="tu-ip-o-hostname-tailscale"; irm https://raw.githubusercontent.com/Reznouw/raspi-connect/main/connect.ps1 | iex
```

## Que hace

1. Verifica que exista `ssh`.
2. Verifica si Tailscale esta instalado.
3. Si falta, intenta instalar Tailscale con `winget`.
4. Ejecuta `tailscale up` si necesitas login.
5. Entra a RaspiPilot:

```powershell
ssh -tt pi@<tu-ip-o-hostname-tailscale> raspi
```

## Seguridad

Usar solo en computadoras confiables. Si una PC es temporal, cierra sesion de Tailscale al terminar.

Este repo no publica tokens, llaves SSH ni la IP Tailscale real de tu Raspberry.
