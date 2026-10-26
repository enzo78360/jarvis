#!/bin/bash
# Double-cliquez pour vérifier ce que le micro capte.
cd "$(dirname "$0")" || exit 1
.venv/bin/python test_micro.py
