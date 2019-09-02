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
choco install sharpkeys

rem battle.net installer isn't in chocolatey

powershell (new-object System.Net.WebClient).DownloadFile('https://www.battle.net/download/getInstallerForGame?os=win^&locale=enUS^&version=LIVE^&gameProgram=BATTLENET_APP','C:\home\yph\tmp\Battle.net-Setup.exe')

rem Install WSL & Ubuntu -- do this last in case it fails

choco install wsl
choco install ubuntu-1804
choco install wsltty
