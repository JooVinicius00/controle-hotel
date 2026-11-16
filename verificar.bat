@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0compilar.ps1" -Verificar
if errorlevel 1 (
    pause
    exit /b 1
)
pause
