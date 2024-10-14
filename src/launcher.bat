@echo off
:: This script is licensed under the GNU Lesser General Public License v2.1
:: See https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html for more details.

goto variables

:variables
setlocal
set "programDir=%temp%\stakanchik"
set "dataDir=%programDir%"
set "pwshCodePath=%dataDir%\exec.ps1"
set "runPath=%programDir%\run.vbs"

:: Create necessary directories and copy files
md "%dataDir%" 2>nul
copy "%cd%\data" "%dataDir%" /Y >nul
goto create

:create
cls
(
    echo Set WshShell = CreateObject^("WScript.Shell"^)
    echo Dim command
    echo For Each arg In WScript.Arguments
    echo     command = command ^& " " ^& arg
    echo Next
    echo WshShell.Run "cmd.exe /c " ^& command, 0, True
) > "%runPath%"
goto launch

:launch
cls
cd "%programDir%"
start /B /I run.vbs "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File %pwshCodePath%"
exit /b 0

:launchvisible
cls
echo PowerShell Launcher
echo @pechenis
start /B /I powershell.exe -ExecutionPolicy Bypass -File "%pwshCodePath%"
pause
exit /b 0
