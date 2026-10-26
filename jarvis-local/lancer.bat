@echo off
rem Double-cliquez sur ce fichier pour lancer Jarvis (Windows 10 / 11).
chcp 65001 >nul
set PYTHONUTF8=1
cd /d "%~dp0"

set MODEL=qwen3:4b-instruct
if exist .env for /f "tokens=1,* delims==" %%a in ('findstr /b "JARVIS_MODEL=" .env') do set MODEL=%%b

rem --- Python ---
set PY=
where py >nul 2>nul && set PY=py -3
if not defined PY where python >nul 2>nul && set PY=python
if not defined PY (
  echo Python n'est pas installe. Voir LISEZMOI-WINDOWS.md, etape 1.
  pause & exit /b 1
)

rem --- Ollama ---
set OLLAMA=
where ollama >nul 2>nul && set OLLAMA=ollama
if not defined OLLAMA if exist "%LOCALAPPDATA%\Programs\Ollama\ollama.exe" set OLLAMA="%LOCALAPPDATA%\Programs\Ollama\ollama.exe"
if not defined OLLAMA (
  echo Ollama n'est pas installe : https://ollama.com/download ^(voir LISEZMOI-WINDOWS.md^).
  pause & exit /b 1
)
curl -s http://localhost:11434/api/version >nul 2>nul
if errorlevel 1 (
  echo Demarrage d'Ollama...
  if exist "%LOCALAPPDATA%\Programs\Ollama\ollama app.exe" (
    start "" "%LOCALAPPDATA%\Programs\Ollama\ollama app.exe"
  ) else (
    start "" /min %OLLAMA% serve
  )
  for /l %%i in (1,1,30) do (
    curl -s http://localhost:11434/api/version >nul 2>nul && goto ollama_ok
    timeout /t 1 /nobreak >nul
  )
)
:ollama_ok
%OLLAMA% show %MODEL% >nul 2>nul
if errorlevel 1 (
  echo Telechargement du modele %MODEL% ^(environ 2,5 Go, une seule fois^)...
  %OLLAMA% pull %MODEL% || (echo Le telechargement a echoue. & pause & exit /b 1)
)

rem --- Environnement Python ---
if not exist .venv (
  echo Premiere installation, ca prend quelques minutes...
  %PY% -m venv .venv || (echo Impossible de creer l'environnement Python. & pause & exit /b 1)
  .venv\Scripts\python -m pip install -q --upgrade pip
  .venv\Scripts\pip install -q -r requirements.txt || (echo L'installation a echoue. & pause & exit /b 1)
)
.venv\Scripts\python -W ignore -c "import vosk, ollama" 2>nul || .venv\Scripts\pip install -q -r requirements.txt

rem --- Modele du mot "Jarvis" (40 Mo, hors ligne) ---
if not exist modeles\vosk-model-small-fr-0.22 (
  echo Telechargement du modele pour le mot "Jarvis" ^(40 Mo, une seule fois^)...
  if not exist modeles mkdir modeles
  curl -fsSL -o modeles\fr.zip https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip && tar -xf modeles\fr.zip -C modeles && del modeles\fr.zip
)

.venv\Scripts\python jarvis.py

rem Jarvis ferme (Ctrl+C) : on eteint aussi Ollama pour liberer la memoire
call "%~dp0arreter-jarvis.bat"
