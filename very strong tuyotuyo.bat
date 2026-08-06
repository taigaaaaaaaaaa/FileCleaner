@echo off
setlocal enableextensions

:: 管理者権限チェック
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo 管理者権限で再実行しています...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:MENU
cls
echo =====================================
echo             Taiga Cleaner 
echo =====================================
echo.
echo  1. Temp フォルダ削除
echo  2. Windows Update キャッシュ削除
echo  3. Installer フォルダ削除（安全なものだけ）
echo  4. AppData キャッシュ削除
echo  5. Windows ログ削除
echo  6. WinSxS クリーンアップ
echo  7. 全部実行
echo  0. 終了
echo.
choice /c 12345670 /n /m "番号を選択してください: "

set "opt=%errorlevel%"

if %opt%==1 goto TEMP
if %opt%==2 goto UPDATE
if %opt%==3 goto INSTALLER
if %opt%==4 goto APPDATA
if %opt%==5 goto LOGS
if %opt%==6 goto WINSXS
if %opt%==7 goto ALL
if %opt%==8 goto END


:TEMP
echo =====================================
echo   Temp フォルダを削除しています...
echo =====================================
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
taskkill /f /im Discord.exe >nul 2>&1

del /q /f /s "%LOCALAPPDATA%\Temp\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Temp\*") do rd /s /q "%%i" 2>nul

del /q /f /s "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

echo Temp フォルダ削除完了。
pause
goto MENU


:UPDATE
echo =====================================
echo   Windows Update キャッシュ削除中...
echo =====================================
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

echo Windows Update キャッシュ削除完了。
pause
goto MENU


:INSTALLER
echo =====================================
echo   Installer フォルダ削除中...
echo =====================================
for %%i in (C:\Windows\Installer\*.tmp) do del /f /q "%%i" 2>nul
for %%i in (C:\Windows\Installer\*.bak) do del /f /q "%%i" 2>nul

echo Installer フォルダ削除完了。
pause
goto MENU


:APPDATA
echo =====================================
echo   AppData 深層キャッシュ削除中...
echo =====================================
taskkill /f /im chrome.exe >nul 2>&1
taskkill /f /im msedge.exe >nul 2>&1
taskkill /f /im msedgewebview2.exe >nul 2>&1
taskkill /f /im Discord.exe >nul 2>&1

:: INetCache
del /q /f /s "%LOCALAPPDATA%\Microsoft\Windows\INetCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Windows\INetCache\*") do rd /s /q "%%i" 2>nul

:: Chrome
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\Code Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\Default\GPUCache\*") do rd /s /q "%%i" 2>nul

:: Edge
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Code Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\GPUCache\*") do rd /s /q "%%i" 2>nul

:: Discord
del /q /f /s "%LOCALAPPDATA%\Discord\Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Discord\Code Cache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\Code Cache\*") do rd /s /q "%%i" 2>nul
del /q /f /s "%LOCALAPPDATA%\Discord\GPUCache\*" 2>nul
for /d %%i in ("%LOCALAPPDATA%\Discord\GPUCache\*") do rd /s /q "%%i" 2>nul

echo AppData キャッシュ削除完了。
pause
goto MENU


:LOGS
echo =====================================
echo   Windows ログ削除中...
echo =====================================
del /q /f /s "C:\Windows\Logs\*.log" 2>nul
del /q /f /s "C:\Windows\Logs\*.txt" 2>nul
for /d %%i in ("C:\Windows\Logs\*") do rd /s /q "%%i" 2>nul

del /q /f /s "C:\Windows\System32\LogFiles\*.log" 2>nul
del /q /f /s "C:\Windows\System32\LogFiles\*.txt" 2>nul
for /d %%i in ("C:\Windows\System32\LogFiles\*") do rd /s /q "%%i" 2>nul

echo Windows ログ削除完了。
pause
goto MENU


:WINSXS
echo =====================================
echo   WinSxS クリーンアップ中...（この処理には時間がかかります。）
echo =====================================
dism /online /cleanup-image /startcomponentcleanup /resetbase

echo WinSxS クリーンアップ完了。
pause
goto MENU


:ALL
call :TEMP
call :UPDATE
call :INSTALLER
call :APPDATA
call :LOGS
call :WINSXS
goto MENU


:END
echo 終了します...
exit /b
