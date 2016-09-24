#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Menu completion
bind "TAB:menu-complete"; bind "set show-all-if-ambiguous on"
#bind "TAB:complete"; bind "set show-all-if-ambiguous off"
bind "set menu-complete-display-prefix on"


if [ -f %{/usr/lib/bash-git-prompt/gitprompt.sh ]; then
   # To only show the git prompt in or under a repository directory
   # GIT_PROMPT_ONLY_IN_REPO=1
   # To use upstream's default theme
   # GIT_PROMPT_THEME=Default
   # To use upstream's default theme, modified by arch maintainer
   GIT_PROMPT_THEME=Default_Arch
   source /usr/lib/bash-git-prompt/gitprompt.sh
fi
source /usr/share/doc/find-the-command/ftc.bash
## Trap function
homepushdcheck() {
	echo -n '[Move to home folder? (Y/n)] '; read -r
	case ${REPLY} in
	 [Yy]*| [Yy]*|'' ) eval "pushd . ; pushd ${HOME}" >/dev/null; return 0;;
	 [Nn]*| [Nn]* ) return 1;;
	 * ) eval "pushd . ; pushd ${HOME}" >/dev/null; return 130;;
	esac
	return 131
}
#trap ' { [[ $EUID != 0 ]] && exec bash || pushd /root >/dev/null; }' SIGQUIT
#kill -SIGQUIT ${$};

# Automatically move to normal home folder if currently in other home folder
if [[ "${EUID}" -ne 0 ]]; then
	[[ "${PWD}" != ${HOME}* ]] && homepushdcheck
else
	! [[ "${PWD}" =~ ("${HOME}".*|\/home\/.*) ]] && homepushdcheck
fi

# Start the gpg-agent if not already running
 if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
   gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
   export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
fi

# History completion bound to arrow keys
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
#bindkey "^[[A" up-line-or-beginning-search
#bindkey "^[[B" down-line-or-beginning-search

# Set GPG TTY
GPG_TTY=$(tty)
export GPG_TTY

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

export SSH_KEY_PATH="/home/alyptik/.ssh/identity"
#eval $(keychain --eval id_4rsa2)
#exec 2>&4; eval $(keychain --eval --agents ssh,gpg id_4rsa2 2>&4); exec 2>${ZSH_ERROR}
#{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } 2>&1 | tee /dev/tty &>>${ZSH_ERROR}
#{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } 2>&1 | tee /dev/tty &>>${ZSH_ERROR}
{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } &>/dev/tty

#envoy -t ssh-agent -a id_4rsa2
#source <(envoy -p)


set_prompt () {
    Last_Command=$? # Must come first!

    White='\[\e[1;37m\]'
    Red='\[\e[0;31m\]'
    Green='\[\e[0;32m\]'
    Blue='\[\e[1;34m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'

    #PS1='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

    #White='\[\e[01;37m\]'
    #Red='\[\e[01;31m\]'
    #Green='\[\e[01;32m\]'
    #Blue='\[\e[01;34m\]'
    #Reset='\[\e[00m\]'
    #FancyX='\342\234\227'alias sedvnc='sudo sed -i "2,$ d; s/^.*$/$(pgrep x11vnc | paste -s -d ' ' | 'awk { print $NF }')/" /var/run/x11vnc.pid '

    #Checkmark='\342\234\223'

    # Add a bright white exit status for the last command
    PS1="$White\$? "
    # If it was successful, print a green check mark. Otherwise, print
    # a red X.
    if [[ $Last_Command == 0 ]]; then
        PS1+="$Green$Checkmark "
    else
        PS1+="$Red$FancyX "
    fi
    # If root, print the host in red. Otherwise, print the current user
    # and host in green.
    if [[ $EUID == 0 ]]; then
        #PS1+='\[\e[0;31m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
        PS1+="$Red\\u@\\h "
    else
        #PS1+='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
	PS1+="$Green\\u@\\h "
    fi
    # Print the working directory and prompt marker in blue, and reset
    # the text color to the default.
    PS1+="$Blue\\w \\\$$Reset "
}

#DO NOT USE RAW ESCAPES, USE TPUT
creset=$(tput sgr0)
cred=$(tput setaf 1)
cblue=$(tput setaf 4)
cgreen=$(tput setaf 2)

#export TERM="xterm-256color"
[[ ${TERM:=xterm} =~ "^screen.*$" ]] && export TERM="screen-256color" || \
export TERM=`sed -r 's_(rxvt-unicode|[:alphanum:]+)-?.*_\1-256color_'<<<${TERM}`
# Add vim as default editor
export EDITOR="vim"
#export TERMINAL="terminator"
export TERMINAL="konsole"
#export BROWSER="firefox"
export BROWSER="google-chrome-stable"
# Gtk themes
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export TERM=xterm-256color
export PYTHONSTARTUP="/home/alyptik/.pyrc"
export PATH=${HOME}/bin:/store/local/Wolfram/CDFPlayer/10.3/Executables:/store/local/bin:${HOME}/GNUstep/Tools:/store/local/Wolfram/CDFPlayer/10.3/Executables:/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
#export PATH=/home/alyptik/GNUstep/Tools:/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
export PATH=${PATH}:/opt/openresty/bin/:/opt/openresty/nginx/sbin/ #Automatically added by openresty package
#export MANPATH="/usr/local/man:${MANPATH}"
export PATH=${HOME}/.linuxbrew/bin:${PATH}
export MANPATH=${HOME}/.linuxbrew/share/man:${MANPATH}
export INFOPATH=${HOME}/.linuxbrew/share/info:${INFOPATH}
#export SYSTEMD_LESS=FRXMK journalctl
# Color man pages
#export GROFF_NO_SGR=1 LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\033[38;5;35m' LESS_TERMCAP_md=$'\E[01;31m' LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_us=$'\033[38;5;35m' LESS_TERMCAP_ue=$'\E[0m' LESS_TERMCAP_so=$'\E[30;43m' LESS_TERMCAP_md=$'\E[01;31m'
## Color man pages
export SYSTEMD_LESS=FRXMK journalctl
## support colors in less
export LESS=FRMsw GROFF_NO_SGR=1 man man
# to have the indication of cursor's location and line numbers
export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[38;5;35m' LESS_TERMCAP_md=$'\E[1;31m' LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_us=$'\E[4;32;4;132m' LESS_TERMCAP_ue=$'\E[0m' LESS_TERMCAP_so=$'\E[30;43m' LESS_TERMCAP_md=$'\E[1;31m'

## History
# if this is interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh \C-j"'; fi
# Last bash command as tab title
export HISTCONTROL=ignoreboth
export HISTIGNORE='history*'
export HH_CONFIG=hicolor         # get more colors

# Append new history items to .bash_history
shopt -s expand_aliases autocd hostcomplete histappend

export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
#PS1='[\u@\h \W]\$ '  # To leave the default one
#PS1='\[$red\]\u\[$reset\] \[$blue\]\w\[$reset\] \[$red\]\$ \[$reset\]\[$green\] '
#PS1='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
#PROMPT_COMMAND='set_prompt'
#PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
#PROMPT_COMMAND='echo -ne "\033]0;$PWD\007"'
#POMPT_COMMAND='set_prompt; echo -ne "\033]0;$PWD\007"'
#PROMPT_COMMAND='set_prompt; history -a; echo -en "\e]2; ";history 1|sed "s/^[ \t]*[0-9]\{1,\}  //g";echo -en "\e\\";'

PROMPT_COMMAND='command history -a; echo -en "\033[m\033[38;5;2m"$(( `sed -n "s/MemFree:[\t ]\+\([0-9]\+\) kB/\1/p" /proc/meminfo`/1024))"\033[38;5;22m/"$((`sed -n "s/MemTotal:[\t ]\+\([0-9]\+\) kB/\1/Ip" /proc/meminfo`/1024 ))MB"\t\033[m\033[38;5;55m$(< /proc/loadavg)\033[m"'
# If root, print the host in red. Otherwise, print the current user
# and host in green.
if [[ $EUID == 0 ]]; then
    #PS1+='\[\e[0;31m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
   # PS1+="$Red\\u@\\h "
    PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;31m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '
else
    #PS1+='\[\e[0;32m\]\u@\h:\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
    #PS1+="$Green\\u@\\h "
    PS1='\[\e[m\n\e[1;30m\][$$:$PPID \j:\!\[\e[1;30m\]]\[\e[0;36m\] \T \d \[\e[1;30m\][\[\e[1;34m\]\u@\H\[\e[1;30m\]:\[\e[0;37m\]${SSH_TTY} \[\e[0;32m\]+${SHLVL}\[\e[1;30m\]] \[\e[1;37m\]\w\[\e[0;37m\] \n($SHLVL:\!)\$ '
fi

export PS1 PROMPT_COMMAND

## start custom commands
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

## Source aliases
[ -r ${HOME}/aliases.sh ] && source ${HOME}/aliases.sh
#[ -r ${HOME}/baliases.sh ] && source ${HOME}/baliases.sh || source ${HOME}/aliases.sh
#true || { [ -r ${HOME}/aliases.sh ] && . ${HOME}/baliases.sh; }

## complettions
#[[ -f /usr/share/bash-completion/completions/dkms ]] && . /usr/share/bash-completion/completions/dkms
#[[ -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

## autostart tmux
#[[ -f /usr/share/tmux-applet/autostart.sh ]] && . /usr/share/tmux-applet/autostart.sh


