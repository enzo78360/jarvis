# Jarvis

Assistant vocal personnel façon Iron Man, en français, 100 % gratuit et local, sur Mac et Windows 10/11.

Dites « Jarvis » ou tapez deux fois dans vos mains : il écoute, consulte Gmail et Google Agenda, et répond à voix haute. Il sait lire, envoyer, répondre, supprimer et archiver des mails, et ajouter, déplacer ou annuler des rendez-vous. Chaque action est lue à voix haute et n'est faite qu'après un « oui ».

- **IA locale** : [Ollama](https://ollama.com) avec Qwen 3 (4B), rien n'est envoyé à une IA en ligne.
- **Mot-clé « Jarvis »** : reconnu hors ligne avec [Vosk](https://alphacephei.com/vosk/).
- **Voix** : voix intégrées de macOS ou de Windows.

Installation et utilisation :
- **Mac** : [`jarvis-local/LISEZMOI.md`](jarvis-local/LISEZMOI.md), puis double-clic sur `lancer.command`
- **Windows** : [`jarvis-local/LISEZMOI-WINDOWS.md`](jarvis-local/LISEZMOI-WINDOWS.md), puis double-clic sur `lancer.bat`

`jarvis.html` est une variante en page web, à ouvrir dans Claude (claude.ai), qui utilise les connecteurs Gmail et Google Agenda de Claude.

## Fichiers à ne jamais publier

`credentials.json`, `token.json` et `.env` contiennent vos accès Google et vos réglages. Ils sont exclus par `.gitignore`.
