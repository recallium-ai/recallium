@echo off
REM =============================================================================
REM Recallium Update Script (Windows)
REM Updates to the latest version from git while preserving your configuration
REM
REM Usage:
REM   update-recallium.bat
REM =============================================================================

cd /d "%~dp0"

set ENV_FILE=recallium.env
set ENV_BACKUP=recallium.env.backup

echo ==============================================
echo   Recallium Update
echo ==============================================
echo.

REM Backup env file if it exists
if exist "%ENV_FILE%" (
    echo [Recallium] Backing up %ENV_FILE%...
    copy /Y "%ENV_FILE%" "%ENV_BACKUP%" >nul
)

REM Force pull latest from git
echo [Recallium] Pulling latest updates from git...
git fetch --all
if errorlevel 1 (
    echo [Error] Git fetch failed. Make sure git is installed and you have network access.
    pause
    exit /b 1
)

git reset --hard origin/main
if errorlevel 1 (
    echo [Error] Git reset failed.
    pause
    exit /b 1
)

REM Restore env file from backup
if exist "%ENV_BACKUP%" (
    echo [Recallium] Restoring your configuration...
    copy /Y "%ENV_BACKUP%" "%ENV_FILE%" >nul
    echo [Recallium] Backup preserved at %ENV_BACKUP%
)

echo.
echo ==============================================
echo   Update complete!
echo ==============================================
echo.
echo   Your configuration has been preserved.
echo   Run start-recallium.bat to start with the new version.
echo.
pause
