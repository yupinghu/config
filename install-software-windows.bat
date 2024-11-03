@echo off

rem Install chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem Confirm chocolatey install
pause

rem Install stuff
choco install -y mac-precision-touchpad
choco install -y openhardwaremonitor
choco install -y vscode

winget install -e --id ALCPU.CoreTemp
winget install -e --id EpicGames.EpicGamesLauncher
winget install -e --id Google.Chrome
winget install -e --id Microsoft.PowerToys
winget install -e --id SourceFoundry.HackFonts
winget install -e --id Valve.Steam

rem Install WSL
pause
wsl --install
