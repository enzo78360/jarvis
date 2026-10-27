#!/bin/bash
# Double-cliquez sur ce fichier pour lancer Jarvis.
cd "$(dirname "$0")" || exit 1

OLLAMA=/Applications/Ollama.app/Contents/Resources/ollama
MODEL=$(grep -E '^JARVIS_MODEL=' .env 2>/dev/null | cut -d= -f2)
MODEL=${MODEL:-qwen3:4b-instruct}

if [ ! -x "$OLLAMA" ]; then
  echo "Ollama n'est pas installé : téléchargez-le sur https://ollama.com/download (voir LISEZMOI.md)."
  read -r -p "Appuyez sur Entrée pour fermer."
  exit 1
fi

if ! curl -s localhost:11434/api/version >/dev/null; then
  echo "Démarrage d'Ollama…"
  open -a Ollama
  for _ in $(seq 1 30); do curl -s localhost:11434/api/version >/dev/null && break; sleep 1; done
fi

if ! "$OLLAMA" show "$MODEL" >/dev/null 2>&1; then
  echo "Téléchargement du modèle $MODEL (environ 2,5 Go, une seule fois)…"
  "$OLLAMA" pull "$MODEL" || { read -r -p "Le téléchargement a échoué. Appuyez sur Entrée pour fermer."; exit 1; }
fi

# Dossiers en « .nosync » : iCloud ne les synchronise pas et ne peut donc pas les vider
# (avec « Optimiser le stockage », les fichiers devenaient des raccourcis et Jarvis restait bloqué)
VENV=.venv.nosync
MODELES=modeles.nosync

if [ ! -d "$VENV" ]; then
  echo "Première installation, ça prend une minute…"
  python3 -m venv "$VENV" && "$VENV/bin/pip" install -q --upgrade pip && "$VENV/bin/pip" install -q -r requirements.txt || {
    read -r -p "L'installation a échoué. Appuyez sur Entrée pour fermer."
    exit 1
  }
fi

# Mises à jour : nouvelles dépendances et modèle du mot « Jarvis » (40 Mo, hors ligne)
"$VENV/bin/python" -W ignore -c "import vosk, ollama" 2>/dev/null || "$VENV/bin/pip" install -q -r requirements.txt
WAKE=$MODELES/vosk-model-small-fr-0.22
if [ ! -d "$WAKE" ]; then
  echo "Téléchargement du modèle pour le mot « Jarvis » (40 Mo, une seule fois)…"
  mkdir -p "$MODELES" && curl -fsSL -o "$MODELES/fr.zip" https://alphacephei.com/vosk/models/vosk-model-small-fr-0.22.zip \
    && unzip -q -o "$MODELES/fr.zip" -d "$MODELES" && rm "$MODELES/fr.zip" \
    || echo "Échec : Jarvis démarrera sans le mot-clé (claps et Entrée restent actifs)."
fi

"$VENV/bin/python" jarvis.py

# Jarvis fermé (Ctrl+C) : on éteint aussi Ollama pour libérer la mémoire
"$(dirname "$0")/arreter-jarvis.command"
