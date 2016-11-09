#!/usr/bin/env bash
#
#   Aliases for Vagrant Commands and Paths
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

[ -d "/Applications/VirtualBox.app/Contents/MacOS/" ] && 
export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/

if [ -n $(which vagrant) ]; then
    alias vdestroy='vagrant destroy --force'
    alias vup='vagrant up && vagrant ssh'
    alias vrestart='vhalt && vup'
    alias vssh='vagrant ssh'
    alias vstate='vagrant global-status --prune'
    alias vhalt='vagrant halt'
fi  

[ -z $(which VBoxManage) ] || alias vblist='VBoxManage list runningvms'
