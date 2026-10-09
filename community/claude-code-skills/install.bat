@echo off
REM Recallium Skill Installer for Claude Code (Windows)
REM This script installs the Recallium usage skill globally

setlocal enabledelayedexpansion

set "SKILL_DIR=%USERPROFILE%\.claude\skills\recallium-guidance"
set "CLAUDE_MD=%USERPROFILE%\.claude\CLAUDE.md"
set "SKILL_LINE=@~/.claude/skills/recallium-guidance/SKILL.md"
set "SCRIPT_DIR=%~dp0"

echo Installing Recallium skill for Claude Code...

REM Create skills directory
if not exist "%SKILL_DIR%" mkdir "%SKILL_DIR%"

REM Copy skill file
copy /Y "%SCRIPT_DIR%SKILL.md" "%SKILL_DIR%\SKILL.md" >nul
echo [OK] Skill copied to %SKILL_DIR%

REM Create CLAUDE.md if it doesn't exist
if not exist "%CLAUDE_MD%" type nul > "%CLAUDE_MD%"

REM Check if skill reference already exists
findstr /x /c:"%SKILL_LINE%" "%CLAUDE_MD%" >nul 2>&1
if %errorlevel%==0 (
    echo [OK] Skill already registered in %CLAUDE_MD%
) else (
    echo %SKILL_LINE%>> "%CLAUDE_MD%"
    echo [OK] Skill registered in %CLAUDE_MD%
)

echo.
echo Installation complete!
echo The Recallium skill will now load automatically in all Claude Code sessions.
echo.
echo To verify, start a new Claude Code session - it should:
echo   1. Know all Recallium tools and best practices
echo   2. Call recallium() at session start
echo   3. Follow global rules automatically

endlocal
