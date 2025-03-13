@echo off
title killer - Runs with Launch.bat
cls

taskkill /f /im steam.exe
taskkill /f /im Battle.net.exe
taskkill /f /im Origin.exe
taskkill /f /im EADesktop.exe
taskkill /f /im EpicGamesLauncher.exe
taskkill /f /im RiotClientServices.exe


taskkill /f /im EasyAntiCheat.exe
taskkill /f /im BEService.exe
taskkill /f /im BEService_x64.exe
taskkill /f /im vgk.exe
taskkill /f /im FaceitClient.exe

exit
