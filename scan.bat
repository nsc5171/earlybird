@echo off
setlocal

:go_check
go version
if errorlevel 1 ( 
    echo Please install 'go' from https://go.dev/dl/
    goto end;
)


SET ebPath=%USERPROFILE%\AppData\go-earlybird\

:build_binary
IF NOT EXIST %ebPath% MKDIR %ebPath%
if EXIST "binaries/go-earlybird.exe" goto copy_config

ECHO ==========================
ECHO Building Windows binary
SET GOOS=windows
SET GOARCH=amd64
go build -o binaries/go-earlybird.exe
ECHO Binary compiled: binaries\go-earlybird.exe

:copy_config
ECHO ===========================
ECHO Copying configurations
xcopy /S /E /Y config\* %ebPath% >NUL
COPY /Y .ge_ignore %ebPath% >NUL

:run_scan
ECHO ============================
ECHO Running scan
binaries\go-earlybird %*

:end
endlocal