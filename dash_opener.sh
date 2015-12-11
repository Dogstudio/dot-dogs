#!/usr/bin/env bash
#
#   Open "Dash" and query
#
#   Author: Thierry 'Epagneul' Lagasse <epagneul@dogstudio.be>
#   Since: Jul 2015
#
# -----------------------------------------------------------------------------

function openDash() {
    open dash://$1
}
alias dash='openDash'