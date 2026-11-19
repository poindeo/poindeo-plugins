@echo off
setlocal enableextensions enabledelayedexpansion

set "BUNDLED=%~dp0..\tools\mcp-server\index.mjs"
if not "%~1"=="" set "BUNDLED=%~1"

set "NODE_BIN="

if defined CODEX_MCP_NODE_PATH if exist "%CODEX_MCP_NODE_PATH%" set "NODE_BIN=%CODEX_MCP_NODE_PATH%"

if not defined NODE_BIN (
  for /f "delims=" %%i in ('where node 2^>nul') do if not defined NODE_BIN set "NODE_BIN=%%i"
)

if not defined NODE_BIN (
  echo poindeo-mcp could not find Node 18+. Install Node 18+ ^(guide: https://poindeo.com/mcp^) or set CODEX_MCP_NODE_PATH. 1>&2
  exit /b 127
)

"%NODE_BIN%" -e "process.exit(Number(process.versions.node.split('.')[0]) >= 18 ? 0 : 1)" >nul 2>nul
if errorlevel 1 (
  echo poindeo-mcp requires Node 18+ but found an older runtime. See https://poindeo.com/mcp 1>&2
  exit /b 127
)

set "UPDATE_MJS=%~dp0..\tools\mcp-server\update.mjs"
set "ENTRY=%BUNDLED%"
if not exist "%UPDATE_MJS%" goto run_entry
set "PICK_TMP=%~dp0poindeo-mcp-pick.tmp"
"%NODE_BIN%" "%UPDATE_MJS%" --pick-entry "%BUNDLED%" >"%PICK_TMP%" 2>nul
set "PICK_FOUND="
set /p PICK_FOUND=<"%PICK_TMP%" 2>nul
if exist "%PICK_TMP%" del /q "%PICK_TMP%" >nul 2>nul
if defined PICK_FOUND set "ENTRY=%PICK_FOUND%"
:run_entry

"%NODE_BIN%" "%ENTRY%"
exit /b %errorlevel%
