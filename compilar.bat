@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0compilar.ps1"
if errorlevel 1 (
    pause
    exit /b 1
)
echo Compilacao concluida. Use executar.bat.
pause
