# Jarvis pour Windows 10 et 11

Même Jarvis que sur Mac : dites « Jarvis » ou tapez deux fois dans vos mains, il écoute, consulte Gmail et Google Agenda, et répond à voix haute. Tout est gratuit, et l'IA tourne sur votre PC.

Ce qu'il sait faire et comment lui parler : voir [LISEZMOI.md](LISEZMOI.md), section « Ce qu'il sait faire ». Seule l'installation change.

**Configuration conseillée** : 8 Go de mémoire vive au minimum (16 Go c'est mieux), environ 4 Go d'espace disque libre, un micro.

## Étape 1 : Python (5 min)

1. Allez sur https://www.python.org/downloads/ et téléchargez la dernière version de Python 3.
2. Lancez l'installateur et **cochez la case « Add python.exe to PATH »** en bas de la première fenêtre, avant de cliquer sur **Install Now**.

Vous pouvez aussi ouvrir le Terminal Windows et taper : `winget install Python.Python.3.12`

## Étape 2 : Ollama, le moteur d'IA (5 min)

1. Téléchargez Ollama pour Windows sur https://ollama.com/download et installez-le.
2. Rien d'autre à faire : `lancer.bat` téléchargera le modèle (2,5 Go) au premier démarrage.

Ollama se lance tout seul à chaque démarrage de Windows. Pour l'éviter : Paramètres › Applications › Démarrage › désactivez **Ollama**.

## Étape 3 : une voix française (2 min)

Windows doit avoir une voix française installée, sinon Jarvis lira le français avec un accent anglais.

1. Ouvrez **Paramètres › Heure et langue › Voix** (ou « Speech »).
2. Dans **Gérer les voix**, cliquez sur **Ajouter des voix** et choisissez **Français (France)**.
3. Redémarrez le PC.

Jarvis prend automatiquement la première voix française. Pour en imposer une, mettez par exemple `JARVIS_VOICE=Paul` dans un fichier `.env` (voir `.env.example`).

## Étape 4 : l'accès Google (10 min, une seule fois)

C'est la même procédure que sur Mac : suivez l'**étape 2 de [LISEZMOI.md](LISEZMOI.md)** pour créer `credentials.json`, puis placez-le dans ce dossier `jarvis-local`.

Si vous avez déjà un `credentials.json` créé sur Mac, vous pouvez le copier tel quel.

## Étape 5 : le micro

Ouvrez **Paramètres › Confidentialité et sécurité › Microphone** et vérifiez que **Accès au microphone** et **Autoriser les applications de bureau à accéder au microphone** sont activés.

## Étape 6 : lancer

Double-cliquez sur **`lancer.bat`**.

- Windows peut afficher « Windows a protégé votre ordinateur » : cliquez sur **Informations complémentaires**, puis **Exécuter quand même**.
- Le pare-feu peut demander l'autorisation pour Python : acceptez (réseau privé).
- La première fois, l'installation prend quelques minutes, puis une page Google s'ouvre pour autoriser Jarvis.

Quand vous entendez « Jarvis en ligne », dites « Jarvis », tapez deux fois dans vos mains ou appuyez sur Entrée.

**Pour quitter** : Ctrl + C dans la fenêtre noire. Windows demande « Terminer le programme de commandes (O/N) ? » : répondez **N**, et le lanceur éteint aussi Ollama pour libérer la mémoire. Sinon, double-cliquez sur **`arreter-jarvis.bat`**.

## Si ça ne marche pas

- **Il ne vous entend pas** : double-cliquez sur `tester-micro.bat`, puis faites deux claps et dites une phrase. Le résultat indique si le micro capte quelque chose.
- **« Python n'est pas installé »** alors qu'il l'est : réinstallez Python en cochant « Add python.exe to PATH ».
- **La voix est anglaise** : refaites l'étape 3, puis redémarrez le PC.
- **Il parle trop vite** : mettez `JARVIS_VITESSE=150` dans `.env`.
- Les autres réglages (claps, mot-clé, modèle) sont les mêmes que sur Mac : voir `.env.example`.
