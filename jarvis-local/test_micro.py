#!/usr/bin/env python3
"""Mesure ce que le micro capte pendant 10 s (claps puis voix) pour régler Jarvis."""
import time
import warnings

warnings.filterwarnings("ignore")
import numpy as np
import sounddevice as sd

RATE, BLOCK, SECONDS = 16000, 512, 10

print("\nMicros disponibles :")
for i, d in enumerate(sd.query_devices()):
    if d["max_input_channels"] > 0:
        mark = "  <- utilisé" if i == sd.default.device[0] else ""
        print(f"  [{i}] {d['name']}{mark}")

print(f"\nPendant {SECONDS} secondes : tapez 2 fois dans vos mains, attendez, puis dites une phrase.\n")
time.sleep(1)
peaks, rmss = [], []
with sd.InputStream(samplerate=RATE, channels=1, dtype="float32", blocksize=BLOCK) as s:
    end = time.time() + SECONDS
    while time.time() < end:
        b = s.read(BLOCK)[0][:, 0]
        p, r = float(np.max(np.abs(b))), float(np.sqrt(np.mean(b ** 2)))
        peaks.append(p)
        rmss.append(r)
        bar = "#" * min(60, int(p * 120))
        print(f"\r  niveau {p:5.3f} |{bar:<60}|", end="", flush=True)

peaks, rmss = np.array(peaks), np.array(rmss)
bruit = float(np.median(rmss))
print("\n\nRésultat (à envoyer à Claude) :")
print(f"  pic maximum      : {peaks.max():.3f}")
print(f"  bruit de fond    : {bruit:.4f}")
print(f"  voix (rms haute) : {np.percentile(rmss, 95):.4f}")
if peaks.max() < 0.002:
    print("\n  -> Silence total : macOS bloque le micro pour le Terminal.")
    print("     Réglages Système > Confidentialité et sécurité > Micro : activez « Terminal », puis relancez.")
elif peaks.max() < 0.25:
    print(f"\n  -> Le micro capte, mais les claps sont faibles. Essayez JARVIS_CLAP_SENSIBILITE={min(4.0, 0.3 / peaks.max()):.1f} dans .env")
else:
    print("\n  -> Les claps sont assez forts.")
input("\nAppuyez sur Entrée pour fermer.")
