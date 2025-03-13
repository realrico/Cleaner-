@echo off
start killer.bat 
powershell -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0\GameCleaner.ps1"
exit
