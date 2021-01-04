@echo off

rem Install chocolatey
powershell -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

rem Confirm chocolatey install
pause

rem Install stuff
choco install googlechrome
choco install atom
choco install hackfont
choco install steam
choco install discord.install
choco install powertoys

rem These aren't available on chocolatey.
rem https://www.blizzard.com/en-us/apps/battle.net/desktop
pause

rem Install WSL & Ubuntu -- do this last in case it fails
choco install wsl
choco install wsltty
rem probably need to reboot before the next line will work
rem choco install ubuntu-1804
