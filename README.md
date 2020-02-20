# Dogstudio Shell Scripts

There are some shell scripts that provide extra features and aliases.

## The scripts

### Aliases

Add some "alias" commands as:

* `l` : clear the screen and list the current folder
* `duh` : compute size of current folder (with human readable format)
* `..` : Go up from one folder level (`cd ..`)
* `...` : Go up from tow folder levels (`cd ../..`)

The **function** `hostedon` get the nameserver that host the site:

    $ hostedon www.laniche.com
    someserver.laniche.com.

### Prompt

Change your (bash) shell prompt:

* Add color : **blue** for the current user, **red** for `ROOT` ou `SUDO`
* Display the location : `Local` for your machnine or `user@host` for a remote connection (SSH)
* In **a GIT project**, display the current branch
    * In **green** : for up to date repository
    * In **red** : when non-staged local changes
    * In **yellow** : when staged changes but not already commited

### SSH Autocomplete

If you often use SSH with remote server, you're certainly use `.ssh/config` to store your connection parameters.
This script brings an autocompletion on connection names.

**Usage** : when you type the first letters of the connection, press `TAB` to complete the name.

* `ssh dog[TAB]` => `ssh dogstudio01`

### Docker

Some features to interact with containers and `docker-compose` environements.

    dohelp # for more info.

### Applications

There are commandes for installed applications (PhpStorm, VScode, ...)

---

## The settings

The files un `configs` folder must be put in your _home_ directory and brings global configuration:

* `.editorconfig` : for your IDE
* `.gitignore_global` : for GIT (to ignore files globally)

## Scripts installation

You must download the scripts and place them in the directory of your choice (ex: `~/.scripts`).
You can also fork and clone the repository.

    git clone git@github.com:laniche/dot-dogs.git ~/.scripts

Then you must add these to your `.bashrc` (or `.zshrc`).

    source ~/.scripts/all.sh

_The `all.sh` script include all others._

## Update

If you have cloned the GIT repository, you simply must :

    git pull origin master
