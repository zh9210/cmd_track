####################
#
# CMD profile
#
#####################
#####################
# Features:
#  - syntax highlight for less
#  - command tracking
#####################

# Add syntax highlight for LESS
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=" -R "
export HISTCONTROL=ignorespace

# Add cmd tracking
declare -r REAL_LOGNAME=`/usr/bin/who -m | cut -d" " -f1`
declare -r REAL_IP=`/usr/bin/who -u am i | awk '{print $NF}'|sed -e 's/[()]//g'`
if [ $USER == root ]; then
    declare -r PROMT="#"
else
    declare -r PROMT="$"
fi


PPPID=$(pstree -p | grep -w $$ | sed -r 's/.*sshd()?\(([0-9]+)\).*/\2/g')

declare -r h2l='
    THIS_HISTORY="$(history 1)"
    __THIS_COMMAND="${THIS_HISTORY/*:[0-9][0-9] /}"
    if [ x"$LAST_HISTORY" != x"$THIS_HISTORY" ]; then
        if [ x"$__LAST_COMMAND" != x ]; then
            __LAST_COMMAND="$__THIS_COMMAND"
            LAST_HISTORY="$THIS_HISTORY"
            logger -p local4.notice -i -t $REAL_LOGNAME $REAL_IP "PPPID=$PPPID [$USER@$HOSTNAME $PWD]$PROMT $__LAST_COMMAND"
        else
            __LAST_COMMAND="$__THIS_COMMAND"
            LAST_HISTORY="$THIS_HISTORY"
        fi
    fi'
trap "$h2l" DEBUG
