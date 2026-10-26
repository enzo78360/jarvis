@echo off
rem Double-cliquez pour tout eteindre : Jarvis, le modele d'IA et Ollama.
rem Rien n'est supprime : lancer.bat rallume tout.
chcp 65001 >nul

echo Arret de Jarvis...
powershell -NoProfile -Command "Get-CimInstance Win32_Process -Filter \"Name='python.exe'\" | Where-Object { $_.CommandLine -like '*jarvis.py*' } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force }" >nul 2>nul

echo Liberation de la memoire et fermeture d'Ollama...
ollama stop qwen3:4b-instruct >nul 2>nul
"%LOCALAPPDATA%\Programs\Ollama\ollama.exe" stop qwen3:4b-instruct >nul 2>nul
taskkill /im "ollama app.exe" /f >nul 2>nul
taskkill /im ollama.exe /f >nul 2>nul
taskkill /im llama-server.exe /f >nul 2>nul

echo Tout est eteint.
timeout /t 2 >nul
