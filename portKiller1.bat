@echo off
setlocal enabledelayedexpansion

set /p PortToCheck="Enter the port number to check: "

:: Check if the port is in use
for /f "tokens=5" %%a in ('netstat -aon ^| findstr /r /c:"^.*:%PortToCheck% *.*$"') do (
    set "PID=%%a"
    taskkill /F /PID !PID!
    echo Process with PID !PID! using port %PortToCheck% has been terminated.
)

:: If no process was found using the specified port
if not defined PID (
    echo No process found using port %PortToCheck%.
)

endlocal