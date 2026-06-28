# raspi-connect

Conector PowerShell para entrar a RaspiPilot desde Windows.

## Uso

Cuando este repo este en GitHub, puedes ejecutar:

```powershell
irm https://raw.githubusercontent.com/Reznouw/raspi-connect/main/connect.ps1 | iex
```

## Que hace

1. Verifica que exista `ssh`.
2. Verifica si Tailscale esta instalado.
3. Si falta, intenta instalar Tailscale con `winget`.
4. Ejecuta `tailscale up` si necesitas login.
5. Entra a RaspiPilot:

```powershell
ssh -tt pi@100.119.164.32 raspi
```

## Seguridad

Usar solo en computadoras confiables. Si una PC es temporal, cierra sesion de Tailscale al terminar.
