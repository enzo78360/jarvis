#!/bin/bash
# Double-cliquez pour vérifier ce que le micro capte.
cd "$(dirname "$0")" || exit 1
if [ ! -d .venv.nosync ]; then
  echo "Lancez d'abord lancer.command une fois pour installer Jarvis."
  read -r -p "Appuyez sur Entrée pour fermer."
  exit 1
fi
.venv.nosync/bin/python test_micro.py
