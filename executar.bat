@echo off
setlocal
cd /d "%~dp0"
if not exist "dist\controle-hotel-java.jar" (
    echo Compile primeiro usando compilar.bat ou Maven.
    pause
    exit /b 1
)
set "JAVA_RUN=java"
if defined JAVA_HOME if exist "%JAVA_HOME%\bin\java.exe" set "JAVA_RUN=%JAVA_HOME%\bin\java.exe"
"%JAVA_RUN%" -cp "dist\controle-hotel-java.jar;lib\*" darwin.Hotel
if errorlevel 1 pause
