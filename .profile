#!/bin/sh


## Enviornment configuration
#export PATH="/home/alyptik/GNUstep/Tools:/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
#export PATH="/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
## Automatically added by openresty package
#export PATH="/opt/openresty/bin:/opt/openresty/nginx/sbin:${PATH}"
#export PATH="/opt/android-sdk/platform-tools:${HOME}/.gem/ruby/2.3.0/bin:${HOME}/bin:/store/scripts:/store/local/Wolfram/CDFPlayer/10.3/Executables:/store/local/bin:${HOME}/.linuxbrew/bin:${PATH}"
#export PATH="/usr/lib/colorgcc/bin:${PATH}"    # As per usual colorgcc installation, leave unchanged (don't add ccache)
export PATH=/usr/lib/distcc/bin:/store/config/scripts:/usr/lib/colorgcc/bin:/opt/android-sdk/platform-tools:${HOME}/.gem/ruby/2.3.0/bin:${HOME}/bin:/store/scripts:/store/local/Wolfram/CDFPlayer/10.3/Executables:/store/local/bin:${HOME}/.linuxbrew/bin:/opt/openresty/bin:/opt/openresty/nginx/sbin:${HOME}/GNUstep/Tools:/bin:/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
#export PATH=/usr/lib/ccache/bin:${PATH}
#export MANPATH="/usr/local/man:${MANPATH}"
export MANPATH=/usr/local/man:${MANPATH}:${HOME}/.linuxbrew/share/man
export INFOPATH=${HOME}/.linuxbrew/share/info:/usr/share/info:${HOME}/GNUstep/Library/Documentation/info
export TERMINAL="urxvt"
export TERM="xterm-256color"
#export TERMINAL="konsole"
#export BROWSER="firefox"
export BROWSER="chromium"
## Gtk themes
export GTK2_RC_FILES="${HOME}/.gtkrc-2.0"
export QT_PLUGIN_PATH="${HOME}/.kde4/lib/kde4/plugins/:/usr/lib/kde4/plugins/"
export QT_QPA_PLATFORMTHEME="qt5ct"
## Python2 compatibility
#export PYTHON="/usr/bin/python2.7"
export PYTHONSTARTUP="${HOME}/.pyrc"
##Compilation flags
export ARCHFLAGS="-arch x86_64"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
## SSH
export SSH_KEY_PATH=".ssh/identity"
## Add vim as default editor
export EDITOR="vim"
export FCEDIT="${EDITOR}" VISUAL="${EDITOR}" SUDO_EDITOR="${EDITOR}" SYSTEMD_EDITOR="${EDITOR}"
## Audio plugins
export VST_PATH="/usr/lib/vst:/usr/local/lib/vst:${HOME}/vst:/store/audio/vst"
export LXVST_PATH="/usr/lib/lxvst:/usr/local/lib/lxvst:${HOME}/lxvst:/store/audio/lxvst"
export LADSPA_PATH="/usr/lib/ladspa:/usr/local/lib/ladspa:${HOME}/ladspa:/store/audio/ladspa"
export LV2_PATH="/usr/lib/lv2:/usr/local/lib/lv2:${HOME}/lv2:/store/audio/lv2"
export DSSI_PATH="/usr/lib/dssi:/usr/local/lib/dssi:${HOME}/dssi:/store/audio/dssi"
## You may need to manually set your language environment
unset LC_ALL
#export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC="en_US.UTF-8"
## Tell ccache to only use compilers here
export CCACHE_PATH="/usr/bin"
#export CCACHE_PATH=/usr/lib/distcc/bin:/usr/bin:/usr/bin
#export CCACHE_PREFIX="distcc"
## Less env
export PAGER="less"
#export SYSTEMD_LESS='-FRXMK' journalctl
export SYSTEMD_LESS='-RXMK' journalctl
## Intel VA-API and VDPAU configu
export LIBVA_DRIVER_NAME="i965"
export VDPAU_DRIVER="va_gl"
## Set X cursor theme
export XCURSOR_THEME=ArchCursorTheme
## Configure KWin to use OpenGL ES
#export KWIN_COMPOSE="O2ES"
## Color man pages
export LESS='-RMsw' GROFF_NO_SGR=1 man man
export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[38;5;35m' LESS_TERMCAP_md=$'\E[1;31m' LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_us=$'\E[4;32;4;132m' LESS_TERMCAP_ue=$'\E[0m' LESS_TERMCAP_so=$'\E[30;43m' LESS_TERMCAP_md=$'\E[1;31m'
## Old less colors
#export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\033[38;5;35m' GROFF_NO_SGR="1 man"
#export LESS_TERMCAP_md=$'\E[01;31m' LESS_TERMCAP_me=$'\E[0m' LESS_TERMCAP_us=$'\033[38;5;35m'
#export LESS_TERMCAP_ue=$'\E[0m' LESS_TERMCAP_so=$'\E[30;43m' LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_se=$'\E[0m' LESS_TERMCAP_so=$'\E[38;5;35m' LESS_TERMCAP_md=$'\E[01;31m' LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[4;38;4;35m' LESS_TERMCAP_ue=$'\E[0m' LESS_TERMCAP_so=$'\E[30;43m' LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m'         	# end mode
#export LESS_TERMCAP_mb=$'\E[05;31m'        	# begin blinking
##export LESS_TERMCAP_mb=$'\E[01;30;5;74m'   	# bold in blue
#export LESS_TERMCAP_md=$'\E[01;31m'   		# bold in red
##export LESS_TERMCAP_md=$'\E[01;31;5;74m'   	# bold in red
#export LESS_TERMCAP_se=$'\E[0m'         	# end standout-mode
##export LESS_TERMCAP_so=$'\E[01;44;33m' 	# begin standout-mode - info box
#export LESS_TERMCAP_so=$'\E[30;246;43m'		# begin standout-mode - info box
##export LESS_TERMCAP_so=$'\E[38;246;5m'  	# begin standout-mode - info box
#export LESS_TERMCAP_ue=$'\E[0m'         	# end underline
#export LESS_TERMCAP_us=$'\E[01;32;04;32m'     	# begin underline is now green
#export LESS_TERMCAP_us=$'\E[04;32;146m' 	# begin underline is now yellow
#                             |  |  |
#                             |  |----------------- yellow
#                             |-------------------- underline
## to have the indication of cursor's location and line numbers
#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m' GROFF_NO_SGR="1 man man"
#export LESS_TERMCAP_se=$'\E[0m' export LESS_TERMCAP_so=$'\033[38;5;35m'
#export LESS_TERMCAP_us=$'\033[38;5;35m' export LESS_TERMCAP_ue=$'\E[0m' export LESS_TERMCAP_so=$'\E[30;43m'
#export PATH="${HOME}/bin:/usr/local/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
## Fix broken man alias
#unset -f man >/dev/null 2>&1
#unalias man >/dev/null 2>&1

# You may need to manually set your language environment
# export LANG="en_US.UTF-8"
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR="'vim'"
# else
#   export EDITOR="'mvim'"
# fi
#export SYSTEMD_EDITOR="emacs -nw"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="${HOME}/.ssh/dsa_id"

## Convert ${TERM} to "${TERM}-256color" and if null use "xterm-256color"
#! [[ "${TERM}" =${HOME} "^screen.*" ]] && export TERM="xterm-256color" || export TERM="screen-256color"
#[[ ${TERM:-xterm} =${HOME} "^screen.*" ]] && export TERM="screen-256color" || export TERM="xterm-256color"
#export TERM="$(sed -r 's_([:alphanum:]+|rxvt-unicode)-?.*_\1-256color_'<<<${TERM})"
# ! [[ "$TERM" =${HOME} ^(xterm|[u]?rxvt|[u]?rxvt\-unicode|screen)(|\-256color)$ ]] && \
#	export TERM="'xterm-256color'"
#	$(<<<${testvar/-256-256colorcolor*/} sed -r 's/^([^\-]*\-|[\-]?[^\-]*?|[^\-]*)(\-256color)+$/\2/ '
#	TERM="$(<<<${TERM/-256color*/-256color} sed -r 's/^([[:alnum:]]*)(|\-256color)*$/\1-256color/' )"
#	TERM="$(sed -r 's/^([[:alnum:]]+)(|\-256color)*$/\1-256color/' <<<${TERM/1/xterm} )"
#	echo ${testvar/-256color*/}$(<<<"xterm-urxvt-unicode-256color-256color-256color-256color"  sed -r 's/([u]?rxvt)(\-unicode|)/\1/; s/^([^\-]*\-[^\-]*?|[^\-]*)(\-256color)+$/\2/ ' )
#	sed -r 's/^([^\-]*)(\-256color)+$/\1\2/ '

## Only execute if running interactively
## else just export TERM variable

#[[ $- != *i* ]] && export TERM="'xterm-256color' || {"
#	if [[ "${TERM:=xterm}" != screen* ]]; then
#		export TERM="$(printf '%s' "${TERM:-xterm}" | \"
#			sed -r 's/([[:alnum:]]+)(\-256color)*$/\1-256color/')
#	else
#		export TERM="'screen-256color'"
#	fi
#}

#	[[ "${TERM:=xterm}" =~ ^screen(|-256color)$ ]] && \
#		export TERM="'screen-256color' || \"
#		export TERM="$(printf '%s' "${TERM:-xterm}" | \"
#			sed -r 's/([[:alnum:]]+)(\-256color)*$/\1-256color/;s/linux-256color/linux/')
#	[[ "${TERM}" =~ ^(screen|xterm|rxvt(|-unicode))-256color$ ]] && export TERM || export TERM="xterm-256color"

## Convert ${TERM} to "${TERM}-256color" and if null use "xterm-256color"
#! [[ "${TERM}" =~ "^screen.*" ]] && export TERM="xterm-256color" || export TERM="screen-256color"
#[[ ${TERM:-xterm} =~ "^screen.*" ]] && export TERM="screen-256color" || export TERM="xterm-256color"
#export TERM="$(sed -r 's_([:alphanum:]+|rxvt-unicode)-?.*_\1-256color_'<<<${TERM})"
# ! [[ "$TERM" =~ ^(xterm|[u]?rxvt|[u]?rxvt\-unicode|screen)(|\-256color)$ ]] && \
#	export TERM="'xterm-256color'"
#	$(<<<${testvar/-256-256colorcolor*/} sed -r 's/^([^\-]*\-|[\-]?[^\-]*?|[^\-]*)(\-256color)+$/\2/ '
#	TERM="$(<<<${TERM/-256color*/-256color} sed -r 's/^([[:alnum:]]*)(|\-256color)*$/\1-256color/' )"
#	TERM="$(sed -r 's/^([[:alnum:]]+)(|\-256color)*$/\1-256color/' <<<${TERM/1/xterm} )"
#	echo ${testvar/-256color*/}$(<<<"xterm-urxvt-unicode-256color-256color-256color-256color"  sed -r 's/([u]?rxvt)(\-unicode|)/\1/; s/^([^\-]*\-[^\-]*?|[^\-]*)(\-256color)+$/\2/ ' )
#	sed -r 's/^([^\-]*)(\-256color)+$/\1\2/ '


