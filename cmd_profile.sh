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
export LOGNAME=`/usr/bin/who -m|cut -d" " -f1`
export LOG_IP=`/usr/bin/who -u am i | awk '{print $NF}'|sed -e 's/[()]//g'`

# Add cmd tracking
if [ -z $LOGNAME  ];then
	if [ $(whoami) == ecs-assist-user ];then
		declare -r REAL_LOGNAME='ecs-assist-user'  2&>1 /dev/null
	elif [ $(whoami) == root ];then
		declare -r REAL_LOGNAME='ecs-assist-user'  2&>1 /dev/null
	fi
else
	declare -r REAL_LOGNAME=`/usr/bin/who -m | cut -d" " -f1`  2&>1 /dev/null
	
fi

if [ -z $LOG_IP ];then
	declare -r REAL_IP='ecs-assist'  2&>1 /dev/null
else
	declare -r REAL_IP=`/usr/bin/who -u am i | awk '{print $NF}'|sed -e 's/[()]//g'`  2&>1 /dev/null
fi

#if [ $USER == root ]; then
if [ $(whoami) == root ]; then
    declare -r PROMT="#"  2&>1 /dev/null
else
    declare -r PROMT="$"  2&>1 /dev/null
fi

if [ -z $LOGNAME ];then
	declare PPPID=$(pstree -p | grep -w $$ |awk -F'bash' '{print $2}'|awk -F"[()]" '{print $2}')  2&>1 /dev/null
else 
	declare PPPID=$(pstree -p | grep -w $$ | sed -r 's/.*sshd()?\(([0-9]+)\).*/\2/g')  2&>1 /dev/null
fi

declare -r h2l='
    THIS_HISTORY="$(history 1)"
    __THIS_COMMAND="${THIS_HISTORY/*:[0-9][0-9] /}"
    if [ x"$LAST_HISTORY" != x"$THIS_HISTORY" ]; then
        if [ x"$__LAST_COMMAND" != x ]; then
            __LAST_COMMAND="$__THIS_COMMAND"
            LAST_HISTORY="$THIS_HISTORY"
            logger -p local4.notice -i -t $REAL_LOGNAME $REAL_IP "PPPID=$PPPID [$(whoami)@$HOSTNAME $PWD]$PROMT $__LAST_COMMAND"
        else
            __LAST_COMMAND="$__THIS_COMMAND"
            LAST_HISTORY="$THIS_HISTORY"
        fi
    fi' 2&>1 /dev/null
trap "$h2l" DEBUG
