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

La **fonction** `hosted` permet de récupérer le nom du serveur qui héberge un site : 

    $ hosted www.dogstudio.be
    dogstudio05.cblue.be.

### Prompt

Modifier l'invite de votre Shell : 

* Ajoute de la couleur : **blue** pour l'utilisateur courant, **rouge** pour `ROOT` ou `SUDO`
* Affiche l'emplacement : `Local` pour votre machine ou `user@host` pour une connexion distante (SSH)
* Si vous êtes dans **un projet GIT**, affiche la branche en cours
    * En **vert** : pas de modification
    * En **rouge** : modifications pas encore committées
    * En **jaune** : des fichiers sont ajoutés et prêts à être committés.

### SSH Autocomplete

Si vous utilisez souvent SSH avec des serveurs distants, vous utilisez certainement `.ssh/config` pour enregister vos paramètres de connexions.
Ce script permet d'effectuer une autocomplétion sur les noms des connexions.

**Utilisation** : Quand vous tapez le début du nom d'une de vos connexions SSH, utilisez la touhce `TAB` pour compléter ce nom.

* `ssh dog[TAB]` => `ssh dogstudio01`  

### Vagrant

Ajout des "alias" pour les commandes _Vagrant_

* `vup` : pour démarrer la VM
* `vhalt` : pour arrêter la VM
* `vdestroy` : pour supprimer la VM
* `vlist` : lister mes VM en cours d'exécution

Si ce script est utilisé **dans une machine Vagrant**, il ajoute seulement la commande `vhalt` qui permet de stopper la machine (et affiche un message d'erreur pour les autres commandes).

### Docker

Une série de fonctions qui permettent d'interagir avec les conteneurs Docker et les envirionnements `docker-compose`.

    dohelp # pour plus d'infos.

### Applications

Il s'agit de commandes liées aux applications installées (PhpStorm, Sublime Text, ...)

#### SublimeText

**Pour les utilisateurs de SublimeText**, ce script permet de lancer l'application en détectant automatiquement _l'environnement_. 

Exécuter la commande `subl` avec comme 1er paramètre : 

* Un **fichier** : ouvre celui-ci
* Un **répertoire** : si aucun fichier "Projet" n'est détecté, ouvre Sublime et ajoute le répertoire au "workspace"
* Un **projet** (.sublime-project) : ouvre ce projet dans une nouvelle fenêtre Sublime.

Si vous exécutez la commande sans paramètre, détecte la présence d'un fichier projet dans le répertoire :

* Ouvre le projet si un fichier est détecté
* Sinon, ajoute le répertoire au "Workspace" courant

---

## Installation des scripts

Il faut télécharger les scripts et les placer dans un répertoire de votre choix (ex: `~/.scripts`)
ou de cloner le dépot : 

    git clone git@gitlab.dogstudio.be:devtools/terminaldog.git ~/.scripts

Ensuite vous devez les ajouter à votre fichier `.bashrc`. 

    source ~/.scripts/all.sh

_Le script `all.sh` permet d'inclure tous les scripts d'un coup._

Pour utiliser ces scripts, vous avez plusieurs possibilités.

## Mise à jour

Si vous avez cloné le projet avec GIT, il suffit de :

    git pull origin master

