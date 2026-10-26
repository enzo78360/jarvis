@echo off
rem Double-cliquez pour verifier ce que le micro capte.
chcp 65001 >nul
set PYTHONUTF8=1
cd /d "%~dp0"
if not exist .venv (
  echo Lancez d'abord lancer.bat une fois pour installer Jarvis.
  pause & exit /b 1
)
.venv\Scripts\python test_micro.py
