# Jarvis local

Dites « Jarvis » ou tapez deux fois dans vos mains : Jarvis répond « Oui ? », écoute votre demande, consulte Gmail ou Google Agenda si besoin et répond à voix haute.

Tout est gratuit : l'intelligence artificielle (Qwen 3) tourne directement sur votre Mac grâce à Ollama. Vos mails ne sont envoyés à aucune IA en ligne.

## Ce qu'il sait faire

- **Agenda** : « Qu'est-ce que j'ai cette semaine ? », « Mets un rendez-vous chez le coiffeur samedi à 11 h », « Décale le dentiste à jeudi 16 h », « Annule le foot de jeudi ».
- **Mails** : « J'ai des mails non lus ? », « Lis-moi le dernier mail de Pronote », « Envoie à paul@gmail.com que je serai en retard », « Réponds à Pronote que c'est noté », « Supprime les mails de Spotify », « Archive les promotions », « Marque mes mails comme lus », « Prépare un brouillon pour… ».

**Pour le destinataire d'un mail**, trois façons :
- dites un **nom** : « Envoie un mail à Lucas ». Jarvis retrouve son adresse dans vos échanges Gmail ;
- dites « **moi** » : « Envoie-moi un mail pour me rappeler d'acheter du pain » ;
- **dictez l'adresse** : « paul point martin arobase gmail point com », « tiret » pour -, « tiret du bas » pour _.

**Avant chaque action, il vous la lit à voix haute** (destinataire et texte du mail, rendez-vous concerné, mails visés) et demande « Je confirme ? ». Il n'agit que si vous répondez « oui ». Dites « non » ou « attends » pour annuler.

Les mails supprimés vont dans la **Corbeille de Gmail**, où ils restent récupérables 30 jours. Jarvis ne supprime jamais rien définitivement.

## Étape 1 : Ollama (déjà fait sur ce Mac)

Ollama est installé dans Applications, avec le modèle `qwen3:4b-instruct`. Sur un autre Mac : téléchargez Ollama sur https://ollama.com/download ; le lanceur télécharge le modèle tout seul au premier démarrage.

## Étape 2 : l'accès Google (environ 10 min, une seule fois, gratuit)

1. Allez sur https://console.cloud.google.com et créez un projet, par exemple « Jarvis ».
2. Dans **API et services › Bibliothèque**, activez **Gmail API** et **Google Calendar API**.
3. Dans **API et services › Écran de consentement OAuth** : choisissez « Externe », mettez le nom « Jarvis » et votre adresse e-mail. Dans **Audience** (ou « Utilisateurs test »), ajoutez votre adresse Gmail comme utilisateur test.
4. Dans **API et services › Identifiants** : **Créer des identifiants › ID client OAuth**, type **Application de bureau**.
5. Téléchargez le fichier JSON, renommez-le `credentials.json` et placez-le dans ce dossier.

Google Cloud peut demander une carte bancaire pour vérifier votre identité. Ces deux API sont gratuites pour un usage personnel, vous ne serez pas débité.

Au premier lancement, une page Google s'ouvre pour autoriser Jarvis. Elle s'ouvre aussi une fois de plus après une mise à jour qui donne à Jarvis de nouveaux pouvoirs, par exemple envoyer et supprimer des mails. Google affiche « Application non validée » : c'est normal, puisque c'est votre propre application. Cliquez sur **Continuer**. L'accès est ensuite gardé dans `token.json`.

## Étape 3 : lancer

Double-cliquez sur `lancer.command`. La première fois :

- macOS peut bloquer le fichier : faites un clic droit › **Ouvrir**, puis **Ouvrir**.
- Le Terminal demande l'accès au micro : acceptez.
- L'installation prend environ une minute.

Quand vous entendez « Jarvis en ligne », dites « Jarvis », tapez deux fois dans vos mains, ou appuyez sur Entrée dans la fenêtre du Terminal.

Vous pouvez aussi tout dire d'une traite : « Jarvis, qu'est-ce que j'ai demain ? ». Le mot « Jarvis » est reconnu directement sur le Mac (modèle Vosk, 40 Mo) : rien n'est envoyé sur internet tant que vous ne l'avez pas appelé. Pour quitter : Ctrl + C.

## Si ça ne marche pas

- **Les claps ne déclenchent rien** : tapez plus fort et plus près du Mac, ou créez un fichier `.env` avec `JARVIS_CLAP_SENSIBILITE=1.5` (voir `.env.example`).
- **Jarvis se déclenche tout seul** : mettez `JARVIS_CLAP_SENSIBILITE=0.7`.
- **« Je n'ai rien entendu »** : parlez juste après le « Oui ? ». Vous avez environ 6 secondes pour commencer.
- **Il se trompe ou comprend mal** : c'est un petit modèle. Faites des phrases simples, une demande à la fois.
- **La première réponse est lente** : le modèle se charge en mémoire. Les suivantes sont plus rapides.
- **Il ne réagit pas à « Jarvis »** : prononcez-le bien détaché, « jar-visse », puis marquez une courte pause. Les claps et la touche Entrée marchent toujours.
- **Il se réveille tout seul en entendant la télé** : mettez `JARVIS_MOT_CLE=0` dans `.env` pour couper le mot-clé et garder les claps.
- **Il parle trop vite** : créez un fichier `.env` avec `JARVIS_VITESSE=150` (par défaut 165).
- **Une voix plus naturelle** : ouvrez Réglages Système › Accessibilité › Contenu énoncé › Voix du système › Gérer les voix… › Français (France), et téléchargez une voix marquée « Premium » ou « Améliorée ». Jarvis la choisit tout seul au prochain lancement. Pour imposer une voix précise, mettez son nom dans `JARVIS_VOICE` (liste : `say -v '?' | grep fr_FR`).

La reconnaissance vocale passe par le service gratuit de Google : il faut une connexion internet.
