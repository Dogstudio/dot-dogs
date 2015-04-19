#!/usr/bin/env bash
#
#   Aliases for Vagrant Commands and Paths
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Apr 2015
#
# -----------------------------------------------------------------------------

export PATH=$PATH:/Applications/VirtualBox.app/Contents/MacOS/

if [[ -z $(which vagrant) ]]; then

    #
    #   Vagrant InBox Shortcuts
    #
    function vagrant() {
        case \$1 in
            'halt')
                sudo init 0
                ;;
            *)
                echo "Oupss. You're in the VM..."
                ;;
        esac      
    }
else
    
    #
    #   Vagrant Aliases
    #    
    alias vinstall='git archive --remote git@gitlab.dogstudio.be:devtools/vagrantdog.git master | tar -x -C ./'
    alias vdestroy='vagrant destroy --force'
    alias vup='vagrant up && vagrant ssh'
    alias vrestart='vhalt && vup'
    alias vssh='vagrant ssh'
    alias vstate='vagrant global-status'
    alias vlist='VBoxManage list runningvms'
fi  

#
#   Vagrant Aliases (for inBox use)
#
alias vhalt='vagrant halt'
