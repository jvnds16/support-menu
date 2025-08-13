@echo off
REM Technical Support Menu - Batch Script
REM Disable command echoing for cleaner output
title Technical Support Menu

:menu
REM Clear screen and display main menu
cls
echo ========= Technical Support Menu =========
echo 0 - Exit
echo 1 - Network 
echo 2 - Printers 
echo 3 - System 
echo ==========================================
set /p option=Choose an option: 

REM Process user selection
if "%option%"=="0" goto exit
if "%option%"=="1" goto network 
if "%option%"=="2" goto printers
if "%option%"=="3" goto system

REM Handle invalid input
echo Invalid option.
pause
goto menu

:network
REM Network troubleshooting menu
cls
echo ================== Network ==================
echo 0 - Return to main menu
echo 1 - Check complete network information
echo 2 - Flush DNS
echo 3 - Ping Server
echo 4 - Reset network settings (Winsock)
echo 5 - Network routes
echo =============================================
set /p option=Choose an option: 

REM Process network menu selection
if "%option%"=="0" goto menu
if "%option%"=="1" goto ipall
if "%option%"=="2" goto flushdns
if "%option%"=="3" goto pingserv 
if "%option%"=="4" goto winsock 
if "%option%"=="5" goto routes

REM Handle invalid input
echo Invalid option.
pause
goto menu

:ipall
REM Display complete network configuration
ipconfig /all
pause
goto menu

:flushdns
REM Clear DNS cache
ipconfig /flushdns
pause
goto menu

:pingserv
REM Ping a server or IP address
set /p ipName=Enter server name or IP:
ping %ipName%
pause
goto menu

:winsock
REM Reset network stack and TCP/IP settings
netsh winsock reset
netsh int ip reset
echo Computer restart is required.
pause
goto menu

:routes
REM Display network routing table
route print
pause
goto menu

:printers
REM Printer troubleshooting menu
cls
echo =============== Printers ==================
echo 0 - Return to main menu
echo 1 - Fix error 0x0000011b
echo 2 - Fix error 0x00000bcb
echo 3 - Fix error 0x00000709
echo 4 - Restart print spooler
echo ===========================================
set /p option=Choose an option: 

REM Process printer menu selection
if "%option%"=="0" goto menu
if "%option%"=="1" goto error11b
if "%option%"=="2" goto error0bcb
if "%option%"=="3" goto error709 
if "%option%"=="4" goto spooler

REM Handle invalid input
echo Invalid option.
pause
goto menu

:error11b
REM Fix printer error 0x0000011b (RPC authentication issue)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f
echo Error 0x0000011b fixed.
pause
goto menu

:error0bcb
REM Fix printer error 0x00000bcb (Point and Print restriction)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint" /v RestrictDriverInstallationToAdministrators /t REG_DWORD /d 0 /f
echo Error 0x00000bcb fixed.
pause
goto menu

:error709
REM Fix printer error 0x00000709 (RPC protocol issue)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Printers\RPC" /v RpcUseNamedPipeProtocol /t REG_DWORD /d 1 /f
echo Error 0x00000709 fixed.
pause
goto menu

:spooler
REM Restart print spooler service
net stop spooler
timeout /t 3 >nul
net start spooler
echo Spooler restarted successfully.
pause
goto menu


:system
REM System troubleshooting menu
cls
echo ================= System ==================
echo 0 - Return to main menu
echo 1 - Restart Computer
echo 2 - Performance Issues
echo 3 - Update Group Policy
echo 4 - Processes with highest CPU usage
echo 5 - Enable access to network shares
echo ===========================================
set /p option=Choose an option: 

REM Process system menu selection
if "%option%"=="0" goto menu
if "%option%"=="1" goto restart
if "%option%"=="2" goto performance
if "%option%"=="3" goto updateGp 
if "%option%"=="4" goto cpu 
if "%option%"=="5" goto shares

REM Handle invalid input
echo Invalid option.
pause
goto menu

:restart
REM Restart computer immediately
shutdown /r /t 0
goto end

:performance
REM Performance optimization routine
cls
echo Step 1: Opening temporary folders...
start "" "%temp%"
start "" "%SystemRoot%\SoftwareDistribution\Download"
start "" "%LocalAppData%\Microsoft\Windows\Explorer"
start "" "C:\Windows\Prefetch"

echo.
echo Step 2: Running SFC scan...
sfc /scannow

echo.
echo Step 3: Cleaning temporary files...
del /f /s /q "%temp%\*.*"
del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*.*"
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\*.*"
del /f /s /q "C:\Windows\Prefetch\*.*"
pause
goto menu

:updateGp 
REM Force Group Policy update
gpupdate /force
pause
goto menu

:cpu
REM Display CPU usage by process
wmic path Win32_PerfFormattedData_PerfProc_Process get Name,PercentProcessorTime | sort
pause
goto menu

:shares
REM Enable insecure network share access (for compatibility)
powershell -Command "Set-SmbClientConfiguration -RequireSecuritySignature $false -Confirm:$false"
powershell -Command "Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Confirm:$false"
echo Network share access enabled.
pause
goto menu

:end
REM Script termination point
