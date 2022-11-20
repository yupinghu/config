@echo off

rem Install chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem Confirm chocolatey install
pause

rem Install stuff
choco install googlechrome
choco install hackfont
choco install steam
choco install discord.install
choco install powertoys
choco install vscode
