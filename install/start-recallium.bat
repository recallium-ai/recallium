@echo off
REM =============================================================================
REM Recallium Quick Start Script (Windows)
REM Downloads and runs Recallium from DockerHub
REM
REM Prerequisites:
REM   1. Docker Desktop installed and running
REM   2. recallium.env file in the same directory
REM
REM Usage:
REM   start-recallium.bat
REM =============================================================================

setlocal enabledelayedexpansion

set ENV_FILE=recallium.env
set IMAGE=recalliumai/recallium:latest
set CONTAINER_NAME=recallium

REM Check for Docker
docker --version >nul 2>&1
if errorlevel 1 (
    echo [Error] Docker is not installed. Please install Docker Desktop first.
    echo   https://docs.docker.com/desktop/install/windows-install/
    exit /b 1
)

docker info >nul 2>&1
if errorlevel 1 (
    echo [Error] Docker daemon is not running. Please start Docker Desktop.
    exit /b 1
)

REM Check for env file
if not exist "%ENV_FILE%" (
    echo [Error] Environment file '%ENV_FILE%' not found.
    echo.
    echo Please create %ENV_FILE% with your configuration.
    echo See README.md for configuration options.
    exit /b 1
)

REM Load variables from env file
for /f "usebackq tokens=1,* delims==" %%a in ("%ENV_FILE%") do (
    set "line=%%a"
    if not "!line:~0,1!"=="#" (
        if not "%%b"=="" set "%%a=%%b"
    )
)

REM Use values from env file (with defaults)
if "%VOLUME_NAME%"=="" set VOLUME_NAME=recallium-v1
if "%HOST_API_PORT%"=="" set HOST_API_PORT=8001
if "%HOST_UI_PORT%"=="" set HOST_UI_PORT=9001
if "%HOST_POSTGRES_PORT%"=="" set HOST_POSTGRES_PORT=5433

REM Detect host IP address for Ollama (Windows requires actual IP, not 127.0.0.1)
echo [Recallium] Detecting host IP address for Ollama...
for /f "tokens=*" %%i in ('powershell -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike '*Loopback*' -and $_.IPAddress -notlike '127.*' -and $_.IPAddress -notlike '169.*' } | Select-Object -First 1).IPAddress"') do set HOST_IP=%%i

if not "%HOST_IP%"=="" (
    echo [Recallium] Detected IP: %HOST_IP%
    echo [Recallium] Updating Ollama configuration in %ENV_FILE%...

    REM Create a temp file with updated OLLAMA settings
    powershell -Command "(Get-Content '%ENV_FILE%') -replace 'OLLAMA_HOST=.*', 'OLLAMA_HOST=http://%HOST_IP%:11434' -replace 'OLLAMA_BASE_URL=.*', 'OLLAMA_BASE_URL=http://%HOST_IP%:11434' | Set-Content '%ENV_FILE%'"

    echo [Recallium] Updated OLLAMA_HOST and OLLAMA_BASE_URL to http://%HOST_IP%:11434
) else (
    echo [Warning] Could not detect host IP. Using default Ollama settings.
    echo           If Ollama connection fails, manually set OLLAMA_HOST in %ENV_FILE%
)

REM Stop existing container and remove old image
docker stop %CONTAINER_NAME% >nul 2>&1
docker rm %CONTAINER_NAME% >nul 2>&1

echo [Recallium] Removing old image to ensure fresh download...
docker rmi %IMAGE% >nul 2>&1

echo [Recallium] Pulling latest image...
docker pull %IMAGE%

echo [Recallium] Starting container...
docker run -d ^
    --name %CONTAINER_NAME% ^
    --restart unless-stopped ^
    --env-file %ENV_FILE% ^
    -p %HOST_API_PORT%:8000 ^
    -p %HOST_UI_PORT%:9000 ^
    -p %HOST_POSTGRES_PORT%:5432 ^
    -v %VOLUME_NAME%:/data ^
    -v %VOLUME_NAME%-wal:/wal ^
    -v %VOLUME_NAME%-docs:/documents ^
    -v %VOLUME_NAME%-secrets:/secrets ^
    --add-host=host.docker.internal:host-gateway ^
    %IMAGE%

echo.
echo [Recallium] Started! Waiting for services to initialize (15 seconds)...
timeout /t 15 /nobreak >nul

echo.
echo ==============================================
echo   Recallium is running!
echo ==============================================
echo.
echo   Web UI:  http://127.0.0.1:%HOST_UI_PORT%
echo   MCP API: http://127.0.0.1:%HOST_API_PORT%/mcp
echo   Health:  http://127.0.0.1:%HOST_API_PORT%/health
echo.
echo   Logs:    docker logs -f %CONTAINER_NAME%
echo   Stop:    docker stop %CONTAINER_NAME%
echo   Restart: docker restart %CONTAINER_NAME%
echo.
echo   Opening Web UI in your browser...
echo.

start http://127.0.0.1:%HOST_UI_PORT%

endlocal
