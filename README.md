# Dogstudio Shell Scripts

Il s'agit d'une série de scripts permettant d'ajouter des fonctionnalités et des raccourcis à votre terminal. 

> Pour les utilisateurs de Mac, je conseille l'utilisation de "iTerm 2" à la place de "Terminal", l'application native d'Apple.

## Les scripts

### Aliases

Ajoute des "alias" de commandes tels que :

* `l` : efface l'écran et liste le répertoire courant
* `duh` : calcule la taille du répertoire courant en mode "human readable"
* `..` : remonte d'un répertoire (`cd ..`)
* `...` : remonte de deux répertoires (`cd ../..`)

### Prompt

Modifier l'invite de votre Shell : 

* Ajoute de la couleur : **blue** pour l'utilisateur courant, **rouge** pour `ROOT` ou `SUDO`
* Affiche l'emplacement : `Local` pour votre machine ou `user@host` pour une connexion distante (SSH)
* Si vous êtes dans **un projet GIT**, affiche la branche en cours
    * En **vert** : pas de modification
    * En **rouge** : modifications pas encore committées
    * En **jaune** : des fichiers sont ajoutés et prêts à être committés.

### Vagrant

Ajout des "alias" pour les commandes _Vagrant_

* `vup` : pour démarrer la VM
* `vhalt` : pour arrêter la VM
* `vdestroy` : pour supprimer la VM
* `vlist` : lister mes VM en cours d'exécution

Si ce script est utilisé **dans une machine Vagrant**, il ajoute seulement la commande `vhalt` qui permet de stopper la machine (et affiche un message d'erreur pour les autres commandes).

### SSH Autocomplete

Si vous utilisez souvent SSH avec des serveurs distants, vous utilisez certainement `.ssh/config` pour enregister vos paramètres de connexions.
Ce script permet d'effectuer une autocomplétion sur les noms des connexions.

**Utilisation** : Quand vous tapez le début du nom d'une de vos connexions SSH, utilisez la touhce `TAB` pour compléter ce nom.

* `ssh dog[TAB]` => `ssh dogstudio01`  

### SublimeText

**Pour les utilisateurs de SublimeText**, ce script permet de lancer l'application en détectant automatiquement _l'environnement_. 

Exécuter la commande `subl` avec comme 1er paramètre : 

* Un **fichier** : ouvre celui-ci
* Un **répertoire** : si aucun fichier "Projet" n'est détecté, ouvre Sublime et ajoute le répertoire au "workspace"
* Un **projet** (.sublime-project) : ouvre ce projet dans une nouvelle fenêtre Sublime.

Si vous exécutez la commande sans paramètres , détecte la présence d'un fichier projet dans le répertoire :

* Ouvre le projet si un fichier est détecté
* Sinon, ajoute le répertoire au "Workspace"

---

## Installation des scripts

Pour utiliser ces scripts, vous avez plusieurs possibilités.

### Avec CURL

**Méthode recommandée si vous ne comptez pas effectuer de modification sur les scripts.**

Créez un répertoire pour accueillir les scripts et lancez y la commande d'installation suivante : 

    curl -Ss https://repositories.dogstudio.be/devtools/terminaldog/raw/master/install.sh | bash

Celle-ci téléchargera les scripts et les installera.

_Pour mettre à jour, il suffit de relancer la commande._

### Avec GIT 

    git clone git@gitlab.dogstudio.be:devtools/terminaldog.git ~/.scripts
    bash ~/.scripts/install.sh

_Pour mettre à jour, il suffit de récuperer les derniers commit et de relancer le script d'installation:_

    git pull origin master && ./install.sh

### Manuellement (non recommandé)

Il faut télécharger les scripts et les placer dans un répertoire de votre choix (ex: `~/.scripts`)

Ensuite, editer votre fichier `~/.bashrc` et ajoutez une `source` pour chaque script à importer :

    source .scripts/bash_prompt.sh