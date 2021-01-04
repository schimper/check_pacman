#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# [Thomas Schimper] check_pacman
#                   This script uses checkupdates from ArchLinux and
#                   to check for available software updates. If arch-audit is
#                   in $PATH we can also check for security issues
# ------------------------------------------------------------------------------
set -f -o pipefail

_help(){
    echo "check_pacman - Check for Software Updates & Security via pacman and arch-audit"
    echo "Syntax: check_pacman [-h|-w|-c|-i]"
    echo "options:"
    echo "     -h     Print this Help."
    echo "     -w     Value for Warn if #Updates >= w (DEFAULT=5)"
    echo "     -c     Value for Crit if #Updates >= c (DEFAULT=10)"
    echo "     -i     Flag to disable the usage of arch-audit"
    exit
}
#Check if arch-audit is available for auditing installed packages
if command -v arch-audit &> /dev/null
then
    ARCH_AUDIT=$(which arch-audit)
fi
IGNORE_AUDIT=0
WARN=5
CRIT=10
while getopts "w:c:ih" opt
do
    case $opt in
        w) WARN=${OPTARG} ;;
        c) CRIT=${OPTARG} ;;
        i) IGNORE_AUDIT=1 ;;
        *) _help; exit 3
    esac
done


_checksecurity(){
    if  [ ! ${IGNORE_AUDIT} -eq 1 ]
    then
        if [ ! -z "${ARCH_AUDIT}" ]
        then
            arch-audit
        fi
    else
        if [ -z "${ARCH_AUDIT}" ]
        then
            echo "[WARNING] - arch-audit not installed - security check disabled"
        fi
    fi
}
_checkupdates(){
    PKG_NAMES=$(checkupdates)
    NUM=$(checkupdates | wc -l)
    if [ ! -z "${PKG_NAMES}" ]
    then

        if [ "${NUM}" -gt "${CRIT}" ]
        then
            echo "CRIT - ${NUM} updates available"
            exit 2
        fi

        if [ "${NUM}" -gt "${WARN}" ]
        then
            echo "WARN - ${NUM} updates available"
            exit 1
        fi
    fi
}


main(){
    _checksecurity
    _checkupdates
    echo "OK - ${NUM} updates available"
    exit 0
}
main
