@echo off
setlocal enableextensions

:: 管理者権限チェック（権限がない場合は自動昇格）
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo 管理者権限で再実行しています...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ================================
echo   Closing targeted applications...
echo ================================
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
taskkill /f /im Discord.exe >nul 2>&1
echo Done.
echo.


echo ================================
echo   Cleaning Temp folders...
echo ================================
del /q /f /s "%LOCALAPPDATA%\Temp\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Temp\*") do rd /s /q "%%i" 2>nul

del /q /f /s "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

echo Temp folders cleaned.
echo.


echo ================================
echo   Cleaning Windows Update cache...
echo ================================
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop dosvc >nul 2>&1

del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" 2>nul
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i" 2>nul

del /q /f /s "C:\Windows\SoftwareDistribution\DeliveryOptimization\*" 2>nul
for /d %%i in ("C:\Windows\SoftwareDistribution\DeliveryOptimization\*") do rd /s /q "%%i" 2>nul

net start dosvc >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1

echo Windows Update cache cleaned.
echo.


echo ================================
echo   Cleaning Installer (safe mode)...
echo ================================
for %%i in (C:\Windows\Installer\*.tmp) do del /f /q "%%i" 2>nul
for %%i in (C:\Windows\Installer\*.bak) do del /f /q "%%i" 2>nul

echo Installer safe-clean completed.
echo.


echo ================================
echo   Deep cleaning AppData caches...
echo ================================
:: INetCache
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Windows\INetCache\*") do rd /s /q "%%i" 2>nul

:: Chrome Cache
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache\*") do rd /s /q "%%i" 2>nul

:: Edge Cache
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache\*") do rd /s /q "%%i" 2>nul

:: Discord Cache
del /q /f /s "%LOCALAPPDATA%\Discord\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Discord\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\Code Cache\*") do rd /s /q "%%i" 2>nul

del /q /f /s "%LOCALAPPDATA%\Discord\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\GPUCache\*") do rd /s /q "%%i" 2>nul

echo AppData deep-clean completed.
echo.


echo ================================
echo   Cleaning Windows log files...
echo ================================
del /q /f /s "C:\Windows\Logs\*.log" 2>nul
del /q /f /s "C:\Windows\Logs\*.txt" 2>nul
for /d %%i in ("C:\Windows\Logs\*") do rd /s /q "%%i" 2>nul

del /q /f /s "C:\Windows\System32\LogFiles\*.log" 2>nul
del /q /f /s "C:\Windows\System32\LogFiles\*.txt" 2>nul
for /d %%i in ("C:\Windows\System32\LogFiles\*") do rd /s /q "%%i" 2>nul

echo Windows logs cleaned.
echo.


echo ================================
echo   WinSxS Component Cleanup...（この処理には時間がかかります…）
echo ================================
dism /online /cleanup-image /startcomponentcleanup /resetbase

echo WinSxS cleanup completed.
echo.


echo ================================
echo   Showing disk free space...
echo ================================
powershell -Command "Get-CimInstance Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3} | Select-Object DeviceID, @{Name='FreeSpace(GB)';Expression={[math]::round($_.FreeSpace/1GB,2)}}, @{Name='Size(GB)';Expression={[math]::round($_.Size/1GB,2)}} | Format-Table -AutoSize"

echo.
echo All cleaning tasks completed. code by taiga.
pause
