@echo off

rem Install chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem Confirm chocolatey install
pause

rem Install stuff
choco install -y coretemp
choco install -y epicgameslauncher
choco install -y googlechrome
choco install -y hackfont
choco install -y mac-precision-touchpad
choco install -y openhardwaremonitor
choco install -y powertoys
choco install -y steam
choco install -y vscode

rem Install WSL
pause
wsl --install
