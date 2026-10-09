@echo off
REM =============================================================================
REM Recallium Reset Script (Windows)
REM Stops container and deletes all volumes (DATA LOSS WARNING)
REM
REM Usage:
REM   reset-recallium.bat
REM =============================================================================

setlocal enabledelayedexpansion

set ENV_FILE=recallium.env
set CONTAINER_NAME=recallium
set IMAGE=recalliumai/recallium:latest

REM Load variables from env file if it exists
if exist "%ENV_FILE%" (
    for /f "usebackq tokens=1,* delims==" %%a in ("%ENV_FILE%") do (
        set "line=%%a"
        if not "!line:~0,1!"=="#" (
            if not "%%b"=="" set "%%a=%%b"
        )
    )
)

if "%VOLUME_NAME%"=="" set VOLUME_NAME=recallium-v1

echo ==============================================
echo   Recallium Reset - DATA LOSS WARNING
echo ==============================================
echo.
echo This will permanently delete:
echo   - Container: %CONTAINER_NAME%
echo   - Volume: %VOLUME_NAME% (database)
echo   - Volume: %VOLUME_NAME%-wal (write-ahead logs)
echo   - Volume: %VOLUME_NAME%-docs (documents)
echo   - Volume: %VOLUME_NAME%-secrets (secrets)
echo   - Image: %IMAGE%
echo.
echo ALL YOUR MEMORIES AND DATA WILL BE LOST!
echo.
set /p confirm="Are you sure you want to continue? (yes/no): "

if /i not "%confirm%"=="yes" (
    echo Aborted.
    exit /b 0
)

echo.
echo [Recallium] Stopping container...
docker stop %CONTAINER_NAME% >nul 2>&1
docker rm %CONTAINER_NAME% >nul 2>&1

echo [Recallium] Removing volumes...
docker volume rm %VOLUME_NAME% >nul 2>&1
docker volume rm %VOLUME_NAME%-wal >nul 2>&1
docker volume rm %VOLUME_NAME%-docs >nul 2>&1
docker volume rm %VOLUME_NAME%-secrets >nul 2>&1

echo [Recallium] Removing image...
docker rmi %IMAGE% >nul 2>&1

echo.
echo ==============================================
echo   Recallium has been completely reset.
echo ==============================================
echo.
echo Run start-recallium.bat to start fresh.
echo.

endlocal
