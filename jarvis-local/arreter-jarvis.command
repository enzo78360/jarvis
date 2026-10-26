#!/bin/bash
# Double-cliquez pour tout éteindre : Jarvis, le modèle d'IA et Ollama.
# Rien n'est supprimé : lancer.command rallume tout.

echo "Arrêt de Jarvis…"
pkill -f "jarvis-local/jarvis.py" 2>/dev/null
pkill -f "\.venv/bin/python jarvis.py" 2>/dev/null

if pgrep -x ollama >/dev/null || pgrep -f Ollama.app >/dev/null; then
  echo "Libération de la mémoire (modèle d'IA)…"
  /Applications/Ollama.app/Contents/Resources/ollama stop qwen3:4b-instruct 2>/dev/null
  echo "Fermeture d'Ollama…"
  osascript -e 'quit app "Ollama"' 2>/dev/null
  sleep 2
  pkill -f "Ollama.app" 2>/dev/null
fi

for _ in 1 2 3 4 5; do
  pgrep -f "Ollama.app/Contents|bin/python jarvis.py" >/dev/null || break
  sleep 1
done

if pgrep -f "Ollama.app/Contents|bin/python jarvis.py" >/dev/null; then
  echo "Un processus résiste encore. Redémarrer le Mac l'arrêtera."
else
  echo "Tout est éteint."
fi
sleep 2
