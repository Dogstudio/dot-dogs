# Dogstudion Shell Scripts

Il s'agit d'une série de scripts permettant d'ajouter des fonctionnalités et des raccourcis à votre terminal. 

> Pour les utilisateurs de Mac, je conseille l'utilisation de "iTerm 2" à la place de "Terminal", l'application native d'Apple.

## Les scritps

### `bash_aliases.sh`

Ajoute des "alias" de commandes tels que :

* `l` : effacer l'écran et liste le répertoire courrant
* `duh` : calcul la taille du répertoire courrant en mode "human readable"
* `..` : remote d'un répertoire (`cd ..`)
* `...` : remote de deux répertoires (`cd ../..`)

### `bash_promopt.sh`

Modifier l'invite de votre Shell : 

* Ajoute de la couleur : **blue** pour l'utilisateur courrant, **rouge** pour `ROOT` ou `SUDO`
* Affiche l'emplacement : `Local` pour votre machine ou `user@host` pour une connexion distante (SSH)
* Si vous êtes dans **un projet GIT**, affiche la branche en cours
    * En **vert** : pas de modification
    * En **rouge** : modifications pas encore commitées
    * En **jaune** : des fichiers sont ajoutés et près à être commité.

### `vagrant_aliases.sh`

Ajout des "alias" pour les commandes _Vagrant_

* `vup` : pour démarrer la VM
* `vhalt` : pour arrêter la VM
* `vdestroy` : pour supprimer la VM
* `vlist` : lister mes VM en cours d'exécution

Si ce script est utiliser dans une machine Vagrant, il ajoute seulement la commande `vhalt` qui permet de stopper la machine (et affiche un message d'erreur pour les autres commandes).

### `ssh_complete.sh`

Si vous utilisez souvent SSH pour vous connecter à des serveurs distants, vous utilisez certainement `.ssh/config` pour enregister vos paramètres de connexions.
Ce script permet d'effectuer une "auto-completion" sur les noms des connexions.

**Utilisation**

Quand vous tapper le début du nom d'une de vos connexions SSH, utiliser la touhce `TAB` pour completer ce nom.

* `ssh dog[TAB]` > `ssh dogstudio01`  

### `sublimetext_opener.sh`

**Pour les utilisateurs de SublimeText**, ce script permet de lancer l'applicaiton en détectant automatiquement _l'environnement_. 

Exécuter la commande `subl` avec comme 1er paramêtres : 

* Un **fichier** : ouvre celui-ci
* Un **répertoire** : si aucun fichier "Projet" n'est détecté, ouvre Sublime et ajoute le répertoire au "workspace"
* Un **projet** (.sublime-project) : ouvre ce projet dans une nouvelle fenêtre Sublime.

Si vous exécuter la commande sans paramètres , détecte la présence d'un fichier projet dans le répertoire :

* Ouvre le projet si un fichier est détecté
* Sinon, ajoute le répertoire au "Workspace"


---

## Installation des scripts

Pour utiliser ces scripts vous avez plusieurs possibilités.

### Manuellement

IL faut télécharger l'archive des scripts et le placer dans un répertoire de votre choix (ex: `~/.scripts`)

Ensuite, editer votre fichier `~/.bashrc` et indiquer quels sont ceux qui doivent être exécuter lors lancement d'un terminal en ajoutant chaque script précédé du mot clé `source` à la fin du fichier :

    source .scripts/bash_prompt.sh

### Avec GIT 

Si vous souhaitez bénéficier des mises à jour, vous pouvez utiliser GIT.
 
On commence par dupliquer le projet GIT reprenant les scripts : 

    mkdir ~/.scripts
    git clone git@gitlab.dogstudio.be:devtools/vagrantdog.git ~/.scripts
    bash ~/.scripts/install.sh

### Avec CURL

Créer un répertoire pour accueillir les scripts et lancer la commande d'installation : 

    curl -Ss https://repositories.dogstudio.be/devtools/vagrantshell/raw/master/install.sh | bash

_La commande téléchargera une archive des scripts et les installera._




