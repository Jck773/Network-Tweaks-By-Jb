@echo off
setlocal enableextensions
title MADE BY Jb
cd /d "%~dp0"

echo.
echo                        NOT FOR SELL OR COPYRIGHT
echo.
echo.
echo        This script improves ur network latency, hitreg and speed
echo.
pause

sc config Winmgmt start= demand >nul 2>&1
sc start Winmgmt >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TcpAckFrequency" /t REG_DWORD /d "1" /f >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TcpDelAckTicks" /t REG_DWORD /d "0" /f >nul 2>&1
for /f %%i in ('wmic path win32_networkadapter get GUID ^| findstr "{"') do reg add "HKLM\System\CurrentControlSet\services\Tcpip\Parameters\Interfaces\%%i" /v "TCPNoDelay" /t REG_DWORD /d "1" /f >nul 2>&1

:: netsh winsock set autotuning on >nul 2>&1

@REM netsh int ip set global neighborcachelimit=4096 >nul 2>&1
@REM netsh int ip set global routecachelimit=4096 >nul 2>&1
@REM netsh int ip set global sourceroutingbehavior=drop >nul 2>&1
:: Security concerns
netsh int ip set global taskoffload=enabled >nul 2>&1
netsh int ip set global dhcpmediasense=disabled >nul 2>&1
netsh int ip set global mediasenseeventlog=disabled >nul 2>&1
netsh int ip set global mldlevel=none >nul 2>&1
netsh int ip set global icmpredirects= disabled >nul 2>&1
:: Disable ICMP Redirects for security
:: netsh int ip set global randomizeidentifiers= disabled >nul 2>&1 less secure
netsh int tcp set global chimney=enabled >nul 2>&1
netsh int tcp set global dca=enabled >nul 2>&1
netsh int tcp set global netdma=disabled >nul 2>&1
netsh int tcp set global rsc=disabled >nul 2>&1
netsh int tcp set global maxsynretransmissions=2 >nul 2>&1
netsh int tcp set global timestamps=disabled >nul 2>&1
netsh int tcp set global ecncapability=disabled >nul 2>&1
:: netsh int tcp set global congestionprovider=ctcp >nul 2>&1

netsh interface teredo set state disabled >nul 2>&1
netsh int isatap set state disable >nul 2>&1

for /f "tokens=1" %%i in ('netsh int ip show interfaces ^| findstr [0-9]') do set INTERFACE=%%i >nul 2>&1
netsh int ip set interface %INTERFACE% dadtransmits=1 routerdiscovery=disabled ecncapability=ecndisabled store=persistent >nul 2>&1

:: netsh int tcp set global initialRto=2000 >nul 2>&1

netsh int tcp set heuristics disabled >nul 2>&1
netsh int tcp set heuristics wsh=disabled >nul 2>&1

netsh int tcp set security mpp=disabled >nul 2>&1
netsh int tcp set security profiles=disabled >nul 2>&1

@REM netsh int ipv4 set dynamicport tcp start=1025 num=64511 >nul 2>&1
@REM netsh int ipv4 set dynamicport udp start=1025 num=64511 >nul 2>&1

powershell Set-NetTCPSetting -SettingName "*" -ForceWS Disabled >nul 2>&1