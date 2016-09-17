#!/usr/bin/zsh

## Traps; execute sanity checks on status:  INT,TERM
cleanup() {
 ## simple pushd/popd-based dir history
 pushd . >/dev/null
 #[[ "${1}" =~ (\((^|\/).*?\)+|`pwd`) ]] && { pushd "${1}" >/dev/null; popd >/dev/null; }
 [[ "${1}" ]] && popd >/dev/null || true
 ## Insert other shutdown tasks
 #[[ "${TERM}" != screen* ]] && TERM='xterm-256color' || TERM='screen-256color'
 #export TERM
 #[[ ! "${TERM}" =~ ^(xterm|rxvt|screen) && export TERM=xterm-256color
 #eval "exec 8<>/store/zsh-log${UID}"
 #eval "exec 6<&- exec 7>&- exec 8>&- exec 9<&-"
 ## Reset fd redirections and close fds
 #[[ `ls -lAhqiQFs1 --color=auto /proc/$$/fd | grep -q "\"9\""`$? ]] && eval 'exec 2>&9; exec 9>&-'
 #(( `ls -lAhqiQFs1 --color=auto /proc/$$/fd | grep "\"9\""`$? )) || eval 'exec 2>&9; exec 9>&-'
 [[ `ls -lAhqiQFs1 --color=auto /proc/$$/fd | grep -q "\"9\""`$? ]] && {
	exec 2>&9; exec 9>&-; }
 ## Error check if running interactively
 #[[ -z `cat "$ZSH_ERROR" 2>&-` [[ $- != *i* ]] && {
 #echo "derp" >>$ZSH_ERROR
 [[ ${-} != *i* ]] || {
  [[ ! -r "$ZSH_ERROR" || -z `cat "$ZSH_ERROR"` ]] && {
    printf "\n \033[32m %s \033[0m\n" 'zshrc: no errors detected'; } || {
    printf "\n \033[31m %s \n" 'zshrc: the following errors were detected:'
    #cat "${ZSH_ERROR}" 2>&1 | tee "/dev/tty" >>/store/zsh-log-${UID}.log; }
    cat "${ZSH_ERROR}" |& \
	sed -s 's/^.*$/\t&/w /dev/tty' \
	>>/store/zsh-log-${UID}.log
    printf "\033[0m"; }
 }
 ## cleanup env and temp files
 [[ -r "${ZSH_ERROR}" ]] && rm -f "${ZSH_ERROR}" || return 0
}

# EXIT trap
trap " { cleanup ${PWD}; trap -; }" EXIT
trap "cleanup" TRAP
#trap ' { [[ ${EUID} -ne 0 ]] && cleanup ${HOME} || cleanup ${PWD}; }' 0 5
## INT,HUP,ILL,SEV,PIPE,TERM traps redundant
#trap " { [[ ${EUID} -ne 0 ]] && cleanup ${HOME} || cleanup ${PWD}; trap - HUP; source ${HOME}/.zshrc; }" 1
#trap " { [[ ${EUID} -ne 0 ]] && cleanup ${HOME} || cleanup ${PWD}; trap - INT; kill -INT $$; }" 2

## Redirect errors in zshrc to "${HOME}/zsh_errors.log"
ZSH_ERROR="/tmp/zsh-error-log-${UID}.tmp"
## Backup stdin/stdout/stderr
## don't use fd 5; sometimes used by shell
## point stderr ${HOME}/zsh_errors.log
#eval "(exec 6<&- exec 7>&- exec 8>&- exec 9>&-)"
#eval "(exec 0<&6 exec 1>&7 exec 2>&8)"
## Open and point fd 7 for seeking within $ZSH_ERROR
#exec 9<>"${ZSH_ERROR}"
#exec 8>$ZSH_ERROR
/bin/rm -f "${ZSH_ERROR}"
exec 9>&2
exec 2>${ZSH_ERROR}

## Example:
#exec 3<> myfile.txt
#while read line <&3
#do { echo "$line"; (( Lines++ )); }; done
#exec 3>&-
## Incremented values of this variable
## + accessible outside loop.
##  No subshell, no problem.

## Begin .zshrc config
# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh
#export ZSH=/home/alyptik/.oh-my-zsh

## Function to capture exit code of laster command.
## Use in either "${PROMPT}" or "${RPROMPT}"
check_last_exit_code() {
  local LAST_EXIT_CODE=$?
  local EXIT_CODE_PROMPT=' '
  if [[ ${LAST_EXIT_CODE} -ne 0 ]]; then
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[red]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[red]%}-%{$reset_color%}"
else
    EXIT_CODE_PROMPT+="%{$fg[green]%}-%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg_bold[green]%}$LAST_EXIT_CODE%{$reset_color%}"
    EXIT_CODE_PROMPT+="%{$fg[green]%}-%{$reset_color%}"
  fi
  printf '%s' "$EXIT_CODE_PROMPT"
}
#[[ "$RPROMPT" != *'$(check_last_exit_code)'* ]] && export RPROMPT='$(check_last_exit_code)'${RPROMPT}
#[[ "$prompt" != *'$(check_last_exit_code)'* ]] && export prompt=${prompt}'$(check_last_exit_code)'
#export PROMPT=${PROMPT}'$(check_last_exit_code)'
#export PS1=${PS1}'$(check_last_exit_code)'
#export RPROMPT='$(check_last_exit_code)$(git_prompt_string)${RPROMPT}'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="pygmalion"
#ZSH_THEME="powerline"
#ZSH_THEME="agnoster"
ZSH_THEME="bullet-train"
#ZSH_THEME="jtyr"
export BULLETTRAIN_DIR_EXTENDED=2
#export BULLETTRAIN_CUSTOM_MSG=`host 192.168.1.98 | sed -r 's/^.*pointer .*?\.(.*\..*\.)$/\1 -/'`
export BULLETTRAIN_CONTEXT_SHOW=true
export BULLETTRAIN_GO_SHOW=true
export BULLETTRAIN_NVM_SHOW=true
export BULLETTRAIN_TIME_12HR=true
#export BULLETTRAIN_PROMPT_CHAR="+"
#export BULLETTRAIN_PROMPT_CHAR=`check_last_exit_code | sed -r 's/.*([[:digit:]]).*/\1/'`
#export BULLETTRAIN_PROMPT_CHAR=`[[ "$EUID" != 0 ]] && printf '%s' '$' || printf '%s' '#'`
export BULLETTRAIN_STATUS_EXIT_SHOW=true
export BULLETTRAIN_PROMPT_SEPARATE_LINE=false
export BULLETTRAIN_PROMPT_ADD_NEWLINE=true
export BULLETTRAIN_GIT_COLORIZE_DIRTY=true
export BULLETTRAIN_EXEC_TIME_SHOW=true
export BULLETTRAIN_IS_SSH_CLIENT=true
export BULLETTRAIN_DIR_CONTEXT_SHOW=false

## Tmux plugin env
export ZSH_TMUX_FIXTERM=false
export ZSH_TMUX_AUTOSTART=false
export ZSH_TMUX_AUTOCONNECT=false

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="false"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"
#DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
#UPDATE_ZSH_DAYS=1

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"
#CORRECT_IGNORE='${HOME}/.*'
#CORRECT_IGNORE="*pacat*"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
#ZSH_CUSTOM=${HOME}/.oh-my-zsh
#ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmux tmuxinator gpg-agent ssh-agent archlinux fancy-ctrl-z adb command-not-found systemd zsh_reload screen man stack nmap colorize extract battery catimage copydir copyfile compleat dircycle cp fasd mosh tmux-cssh wd url-tools zsh-navigation-tools z safe-paste singlechar themes rsync dirpersist celery dirhistory kate repo pass pip brew web-search thefuck common-aliases git github brew iwhois zsh-autosuggestions)
#plugins=(tmux tmuxinator gpg-agent ssh-agent git archlinux fancy-ctrl-z adb github command-not-found systemd zsh_reload screen man stack nmap  colorize sudo extract battery catimage copydir copyfile compleat dircycle cp fasd mosh tmux-cssh wd url-tools zsh-navigation-tools z safe-paste singlechar thefuck themes rsync dirpersist celery dirhistory kate repo pass pip history-substring-search iwhois vi-mode brew)
#plugins=(tmux tmuxinator archlinux fancy-ctrl-z adb command-not-found systemd zsh_reload screen man stack nmap colorize extract battery catimage copydir copyfile compleat dircycle cp fasd mosh tmux-cssh wd url-tools zsh-navigation-tools z safe-paste singlechar themes rsync dirpersist celery dirhistory kate repo pass pip brew web-search thefuck common-aliases git)
#plugins=(tmux tmuxinator gpg-agent ssh-agent git archlinux colored-man-pages fancy-ctrl-z adb github command-not-found systemd zsh_reload screen man stack nmap common-aliases sudo cp extract common-aliases)

## caching
#ZSH_CACHE_DIR=${HOME}/.oh-m-zsh-cache
ZSH_CACHE_DIR=${ZSH}/cache
if [[ ! -d ${ZSH_CACHE_DIR} ]]; then
  mkdir ${ZSH_CACHE_DIR}
fi
[[ -d $ZSH/cache ]] && {
	zstyle ':completion:*' use-cache yes
	zstyle ':completion::complete:*' cache-path $ZSH/cache; }
source ${ZSH}/oh-my-zsh.sh

## User configuration

## Convert ${TERM} to "${TERM}-256color" and if null use "xterm-256color"
#! [[ "${TERM}" =~ "^screen.*" ]] && export TERM="xterm-256color" || export TERM="screen-256color"
#[[ ${TERM:-xterm} =~ "^screen.*" ]] && export TERM="screen-256color" || export TERM="xterm-256color"
#export TERM=$(sed -r 's_([:alphanum:]+|rxvt-unicode)-?.*_\1-256color_'<<<${TERM})
# ! [[ "$TERM" =~ ^(xterm|[u]?rxvt|[u]?rxvt\-unicode|screen)(|\-256color)$ ]] && \
#	export TERM='xterm-256color'
#	$(<<<${testvar/-256-256colorcolor*/} sed -r 's/^([^\-]*\-|[\-]?[^\-]*?|[^\-]*)(\-256color)+$/\2/ '
#	TERM=$(<<<${TERM/-256color*/-256color} sed -r 's/^([[:alnum:]]*)(|\-256color)*$/\1-256color/' )
#	TERM=$(sed -r 's/^([[:alnum:]]+)(|\-256color)*$/\1-256color/' <<<${TERM/1/xterm} )
#	echo ${testvar/-256color*/}$(<<<"xterm-urxvt-unicode-256color-256color-256color-256color"  sed -r 's/([u]?rxvt)(\-unicode|)/\1/; s/^([^\-]*\-[^\-]*?|[^\-]*)(\-256color)+$/\2/ ' )
#	sed -r 's/^([^\-]*)(\-256color)+$/\1\2/ '

## Keychain: ssh-agent autostart (and redirect 2>&4 for eval)
## note that without it eval's output redirected to to error logfile
#eval $(keychain --eval id_4rsa2)
## Reset stderr redirection; Keychain: ssh-agent autostart; Redo stderr redirection
#exec 2>&4; eval $(keychain --eval --agents ssh,gpg id_4rsa2 2>&4); exec 2>${ZSH_ERROR}
#&>/dev/null

#{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } 2>&1 | tee /dev/tty &>>${ZSH_ERROR}
#{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } 2>&1 | tee /dev/tty &>>${ZSH_ERROR}
#2>&1 { eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } >/dev/stdout

{ eval $(keychain --eval --agents ssh,gpg identity id_rsa id_ecdsa); } 2>&1 9>&1 >/dev/stdout

# precmd() { disambiguate-keeplast }

## Envoy commands as alternate ssh/gpg-agent manager
#[[ ${EUID} -eq 1000 ]] && { envoy -t ssh-agent -a identity id_rsa id_ecdsa; source <(envoy -p); }
#[[ ${EUID} -eq 1000 ]] && { envoy -t gpg-agent; source <(envoy -p); }

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities identity id_rsa id_ecdsa

zle -N znt-history-widget
bindkey "^R" znt-history-widget
zle -N znt-cd-widget
bindkey "^T" znt-cd-widget
zle -N znt-kill-widget
bindkey "^Y" znt-kill-widget
source /usr/share/zsh/scripts/antigen/antigen.zsh
zstyle ':completion:*' rehash true
# History stuff
zmodload zsh/datetime
#HISTSIZE=10000
#SAVEHIST=10000
HISTSIZE=50000
SAVEHIST=100000
# report about cpu-/system-/user-time of command if running longer than 5 seconds
REPORTTIME=5

## Bash style
#autoload select-word-style
#select-word-style shell

## don't alert me if something failed
unsetopt correctall correct_all nomatch beep printexitvalue caseglob nohistverify
setopt histignorealldups hist_expire_dups_first hist_ignore_dups hist_ignore_space correct completeinword
setopt extended_history append_history share_history inc_append_history autocd notify clobber
setopt extendedglob noverbose casematch
## Allow comments even in interactive shells
setopt INTERACTIVE_COMMENTS interactivecomments
## don't kill programs& if exiting the shell
setopt nohup
## dont warn me about bg processes when exiting
setopt nocheckjobs
HISTFILE=${HOME}/.zsh_history # ensure history file visibility
export HH_CONFIG=hicolor # get more colors
# History search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

## Key bindings
## if this is  an interactive shell, then bind hh to Ctrl-r (for Vi mode check doc)
#[[ $- =~ ".*i.*" ]] && bindkey -s "\C-r" "\eqhh\n"
bindkey -s "\C-r" "\eqhh\n"
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
#bindkey  "\e[A"    history-search-backward
#bindkey  "\e[B"    history-search-forward
bindkey -e '^[[A' up-line-or-beginning-search
bindkey -e '^[[B' down-line-or-beginning-search
bindkey -v '^[[A' up-line-or-beginning-search
bindkey -v '^[[B' down-line-or-beginning-search
#bindkey -e '^[[A' history-substring-search-up
#bindkey -e '^[[B' history-substring-search-down
#bindkey -v '^[[A' history-substring-search-up
#bindkey -v '^[[B' history-substring-search-down
## bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
## bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey "\eOd" emacs-backward-word
bindkey "\eOD" emacs-backward-word
bindkey "\e\e[D" emacs-backward-word
bindkey "\eOc" emacs-forward-word
bindkey "\eOC" emacs-forward-word
bindkey "\e\e[C" emacs-forward-word
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[3~" delete-char
## for inside tmux
bindkey "\e[1~" beginning-of-line
bindkey "\e\e[A" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e\e[B" end-of-line
bindkey "^i" expand-or-complete-prefix
bindkey "\e\e\e\e" expand-or-complete-prefix
bindkey "\ep" expand-or-complete-prefix
bindkey "^u" kill-whole-line

## Figure out the character’s code (take a look at unicode.org/charts/
## for example) and press ‘ctrl-x i’, followed by the character’s code
## and press ‘ctrl-x i’ once more.
## Usage example: ‘ctrl-x i 00A7 ctrl-x i’ will give you an ‘§’.
autoload insert-unicode-char
zle -N insert-unicode-char
bindkey "^Xi" insert-unicode-char
bindkey "\eu" insert-unicode-char

# Change cursor color orange in vi mode
zle-keymap-select () {
  if [ $KEYMAP = vicmd ]; then
    if [[ $TMUX = '' ]]; then
#      echo -ne "\033]12;#586e75\007"
      echo -ne "\033]12;Red\007"
    else
#      printf '\033Ptmux;\033\033]12;#586e75\007\033\\'
      printf '\033Ptmux;\033\033]12;Red\007\033\\'
    fi
  else
    if [[ $TMUX = '' ]]; then
      echo -ne "\033]12;#b58900\007"
    else
      printf '\033Ptmux;\033\033]12;#b58900\007\033\\'
    fi
  fi
}
zle-line-init () {
#  zle -K viins
#  zle -K emacs
  echo -ne "\033]12;#b58900\007"
#  echo -ne "\033]12;#586e75\007"
}
# zle-keymap-select () {
#  if [ $KEYMAP = vicmd ]; then
#    echo -ne "\033]12;Red\007"
#  else
##    echo -ne "\033]12;Grey\007"
#  fi
#}
#zle -N zle-keymap-select
# zle-line-init () {
#  zle -K viins
#  echo -ne "\033]12;Grey\007"
# }
zle -N zle-keymap-select
zle -N zle-line-init
# toggle-keymap() { (( $(unsetopt | egrep -q "^emacs.*$")$? )) && { setopt noemacs; bindkey -v; } || { setopt emacs; bindkey -e; }; }
toggle-keymap() { setopt | grep -q "vi" && { setopt emacs; bindkey -e; } || { setopt vi; bindkey -v; }; }
# toggle-keymap() { (( `unsetopt | egrep -q "^emacs.*$"`$? )) && set -o vi || set -o emacs; }
toggle-keymap-context() {
  #[[ "$KEYMAP" =~ ^vi(ins|cmd|$)$ ]] && {
  [[ "$KEYMAP" == *vi* ]] && {
	local kmap='emacs'; local nokopt='-v'; local kopt='-e'; } || {
	local kmap='vi'; local nokopt='-e'; local kopt='-v'; }
  #(( `unsetopt | egrep -q "^${kmap}.*" --`$? )) && { setopt "no${kmap}"; bindkey "${nokopt}"; } || { setopt "${kmap}"; bindkey "${kopt}"; }
  setopt "no${kmap}"; bindkey "${nokopt}"; set -o "$kmap"
  # This anonymous nested function allows WIDGET
  # to be used as a local variable.  The -h
  # removes the special status of the variable.
  () { local -h WIDGET; }
  #if [[ "${1}" =~ ^vi(ins|cmd)$ ]]; then
    #kmap="emacs"
    #(( `unsetopt | egrep -q ^emacs`$? )) && { setopt noemacs; bindkey -v; } || { setopt emacs; bindkey -e; }
  #else
    #kmap="vi"
    #(( `unsetopt | egrep -q ^vi`$? )) && { setopt novi; bindkey -e; } || { setopt vi; bindkey -v; }
  #fi

  #[[ "$KEYMAP" =~ ^vi(ins|cmd|$)$ ]] && {
   	#(( `unsetopt | egrep -q ^vi`$? )) && { setopt novi; bindkey -e; } || { setopt vi; bindkey -v; }
}
emacs-keymap() { setopt emacs; bindkey -e; }
vi-keymap() { setopt vi; bindkey -v; }
zle -N toggle-keymap
zle -N toggle-keymap-context
zle -N emacs-keymap
zle -N vi-keymap
## Set emacs as default
bindkey -e
## Set vi as default
#bindkey -v

## Keymaps
bindkey -v "\ek" toggle-keymap
bindkey -e "\ek" toggle-keymap
bindkey -v "\ee" emacs-keymap
bindkey -e "\ev" vi-keymap
#bindkey -v "\ee"
#indkey -s "\ee" 'set -o emacs'
#bindkey -s "\ev" 'set -o vi'

## Pressing meta-y or ESC-y will input "yout $(xclip -o)" into the current commandline
yout-helper() {
  BUFFER="yout $(xclip -o | tr '\n' ' ')"
  CURSOR="${#BUFFER}"
}
#zle -N yout-helper
#bindkey "^[y" yout-helper
youtube-helper() {
  local -a links
  links=($(xclip -o))
  # this seems hacky, is there a better way to wrap elements of an array in quotes?
  local i; for i in {1..$#links}; do links[$i]=\'$links[$i]\'; done; unset i
  BUFFER="yout -f 22 $links"
  CURSOR="$#BUFFER"
  unset links
}
zle -N youtube-helper
#bindkey "^[Y" youtube-helper
bindkey "\ey" youtube-helper

#bindkey -v
#bindkey '^r' history-incremental-search-backward
## A ZSH Do What I Mean key. Attempts to predict what you will want to do next.
## Usage:
## Type a command and hit control-u and zsh-dwim will attempt to transform your command.
## Typing control-u at an empty command prompt will recall the previous command from
## your history and then attempt to transform it.
[ ! -r /usr/share/zsh-dwim/init.zsh ] || \
	. /usr/share/zsh-dwim/init.zsh
[ ! -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ] || \
	. /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
[ ! -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] || \
	. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ ! -r /usr/share/doc/find-the-command/ftc.zsh ] || \
	. /usr/share/doc/find-the-command/ftc.zsh
[ ! -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] || \
	. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Color to use when highlighting suggestion
## Uses format of `region_highlight`
## More info: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
## Prefix to use when saving original versions of bound widgets
ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX=autosuggest-orig-
## for other color codes do:
#for ((i=7;i<50;i++));do printf "$(tput setaf $i) %s " "derp" ; done
## Autopair
[ ! -r /usr/share/zsh/plugins/zsh-autopair/autopair.zsh ] || \
	. /usr/share/zsh/plugins/zsh-autopair/autopair.zsh
## If delimiters on the right side of the cursor are interfering with completion,
## bind Tab to expand-or-complete-prefix. Which will offer completion and ignore
## what's to the right of cursor.
bindkey '^I' expand-or-complete-prefix

## Defaults
#AUTOPAIR_INHIBIT_INIT=${AUTOPAIR_INHIBIT_INIT:-}
#AUTOPAIR_BETWEEN_WHITESPACE=${AUTOPAIR_BETWEEN_WHITESPACE:-}
typeset -gA AUTOPAIR_PAIRS
#AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')' '<' '>')
AUTOPAIR_PAIRS=('`' '`' "'" "'" '"' '"' '{' '}' '[' ']' '(' ')')
## For example, if $AUTOPAIR_LBOUNDS[braces]="[a-zA-Z]", then braces ({([) won't be autopaired if the cursor follows an alphabetical character.
## Individual delimiters can be used too. Setting $AUTOPAIR_RBOUNDS['{']="[0-9]" will cause { specifically to not be autopaired when the cursor precedes a number.
typeset -gA AUTOPAIR_LBOUNDS
AUTOPAIR_LBOUNDS=('`' '`')
AUTOPAIR_LBOUNDS[all]='[.:/\!]'
AUTOPAIR_LBOUNDS[quotes]='[]})a-zA-Z0-9]'
AUTOPAIR_LBOUNDS[braces]=''
AUTOPAIR_LBOUNDS["'"]="'"
typeset -gA AUTOPAIR_RBOUNDS
AUTOPAIR_RBOUNDS[all]='[[{(<,.:?/%$!a-zA-Z0-9]'
AUTOPAIR_RBOUNDS[quotes]='[a-zA-Z0-9]'
AUTOPAIR_RBOUNDS[braces]=''
## zsh-syntax-highlighting
[ ! -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] || \
	. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
## Array declaring active highlighters names.
typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
## colors for zsh-syntax-highlighting
#ZSH_HIGHLIGHT_STYLES[default]='fg=cyan,bold' #base1
#ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
#ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow'
#ZSH_HIGHLIGHT_STYLES[function]='fg=white'
#ZSH_HIGHLIGHT_STYLES[command]='fg=white'
#ZSH_HIGHLIGHT_STYLES[precommand]='fg=white'
#ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=green,bold' #base01
#ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
#ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold' #base0
#ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold' #base0
#ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=red,bold' #orange
# History search (alternate #1)
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#autoload -U history-search-end
#[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-beginning-search
#[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-beginning-search
#[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-search-backward
#[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-search-forward
#[[ -n "${key[Up]}"      ]] && bindkey  "${key[Up]}"      history-beginning-search-backward
#[[ -n "${key[Down]}"    ]] && bindkey  "${key[Down]}"    history-beginning-search-forward
#bindkey "^[[A" up-line-or-beginning-search
#bindkey "^[[B" down-line-or-beginning-search
# History search (alternate #2)
#zle -N history-beginning-s[[ ${TERM} =~ "^screen.*" ]] && export TERM="screen-256color" || export TERM="xterm-256color"earch-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "\e[A" history-beginning-search-backward-end
#bindkey "\e[B" history-beginning-search-forward-end
#[ ! -r /usr/share/zsh/plugins/zsh-autosuggestions/autosuggestions.zsh ] || \
#	. /usr/share/zsh/plugins/zsh-autosuggestions/autosuggestions.zsh
## Color to use when highlighting suggestion
## Uses format of `region_highlight`
## More info: http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
## Prefix to use when saving original versions of bound widgets
#ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX=autosuggest-orig-
#zle-line-init() {
#	zle autosuggest-start
#}
#zle -N zle-line-init

## Source command-not-found files.
[ -r /etc/profile.d/cnf.sh ] && . /etc/profile.d/cnf.sh

## Arch latest news
## The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
#
#echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | sed -e '
#	:a;N;$!ba;s/\n/ /g') | \
#	sed -e 's/&amp;/\&/g
news_cmd_short() {
	  echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | sed -e '
          :a;N;$!ba;s/\n/ /g') | sed -e '
                s/&amp;/\&/g
                s/&lt;\|&#60;/</g
                s/&gt;\|&#62;/>/g
                s/<\/a>/£/g
                s/href\=\"g/§/
                s/<title>/£@§\\e[01;29m \\n   ::\\e[01;31m /g; s/<\/title>/ \\e[00m:: \\e[00m\\n/g
                s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]\\e[00/g
                s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
                s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
                s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
                s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
                s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
                s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
                s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
                s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
                s/<!\[CDATA\[\|\]\]>//g
                s/\|>\s*<//g
                s/ *<[^>]\+> */ /g
                s/[<>£§]//g
          ')\n\n" | IFS="£@§" read -r -d "£§" -A apost
          acount="${#apost[@]}"
          spost=$(until [ "$acount" -eq 0 ]; do printf "$apost[$((--acount))]"; done | \
          ## Remove the grep to show full news posts
                grep -E "^(   :| \[)")
          scount=$(echo $spost | wc -l)
          printf "${spost}\e[00m\n"
	true || {
	echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | sed -e '
	:a;N;$!ba;s/\n/ /g') | sed -e '
		s/&amp;/\&/g
		s/&lt;\|&#60;/</g
		s/&gt;\|&#62;/>/g
		s/<\/a>/£/g
		s/href\=\"/§/g
		s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m::\\n/g
		s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
		s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
		s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
		s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
		s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
		s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
		s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
		s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
		s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
		s/<!\[CDATA\[\|\]\]>//g
		s/\|>\s*<//g
		s/ *<[^>]\+> */ /g
		s/[<>£§]//g
	')\n\n" | grep -E "^(   :| \[)" ## Remove the grep to show full news posts
	#if [[ `whoami` =~ (root|alyptik) ]]; then
	#  : ## do nothing
	#  #return 0 ## To skip section
	#else
	}
}
news_cmd_long() {
	if [ "$EUID" -eq 1000 ]; then ## Full news prompt
	  echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | sed -e '
	  :a;N;$!ba;s/\n/ /g') | sed -e '
		s/&amp;/\&/g
		s/&lt;\|&#60;/</g
		s/&gt;\|&#62;/>/g
		s/<\/a>/£/g
		s/href\=\"g/§/
		s/<title>/£@§ \\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m::\\n/g
		s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
		s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
		s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
		s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
		s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
		s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
		s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
		s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
		s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
		s/<!\[CDATA\[\|\]\]>//g
		s/\|>\s*<//g
		s/ *<[^>]\+> */ /g
		s/[<>£§]//g
	  ')\n\n" | IFS="£@§" read -r -d "£§" -A apost
	  acount="${#apost[@]}"
	  until [ "$acount" -eq 0 ]; do printf "$apost[((--acount))]"; done
	  printf "\n\e[00m"
	elif [[ "$EUID" -eq 0 ]]; then ## Short (grepped) news prompt
	  echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | sed -e '
          :a;N;$!ba;s/\n/ /g') | sed -e '
                s/&amp;/\&/g
                s/&lt;\|&#60;/</g
                s/&gt;\|&#62;/>/g
                s/<\/a>/£/g
                s/href\=\"g/§/
                s/<title>/£@§\\e[01;29m \\n   ::\\e[01;31m /g; s/<\/title>/ \\e[00m:: \\e[00m\\n/g
                s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]\\e[00/g
                s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
                s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
                s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
                s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
                s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
                s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
                s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
                s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
                s/<!\[CDATA\[\|\]\]>//g
                s/\|>\s*<//g
                s/ *<[^>]\+> */ /g
                s/[<>£§]//g
          ')\n\n" | IFS="£@§" read -r -d "£§" -A apost
          acount="${#apost[@]}"
          spost=$(until [ "$acount" -eq 0 ]; do printf "$apost[$((--acount))]"; done | \
          ## Remove the grep to show full news posts
                grep -E "^(   :| \[)")
          scount=$(echo $spost | wc -l)
          printf "${spost}\e[00m\n"
	fi
	return 0
}
## Arch news shell function
#news_cmd_short
news_cmd_long
## "Is the internet on fire?" status reports
host -t txt istheinternetonfire.com | cut -f 2 -d '"' | cowsay -f moose

################################################################################
# Mödified by Ogion
################################################################################

autoload -U colors && colors
#if [[ $UID -eq 0 ]] ; then
#    PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "
#else PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "; fi

# ls colors
eval $(dircolors -b)
export CLICOLOR=1

function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( found = 0 ))
    for fdir in ${fpath} ; do
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 ))
    done

    (( ffound == 0 )) && return 1
    if [[ $ZSH_VERSION == 3.1.<6-> || $ZSH_VERSION == <4->* ]] ; then
        autoload -U ${ffile} || return 1
    else
        autoload ${ffile} || return 1
    fi
    return 0
}

## Set window title
function set_title () {
    info_print  $'\e]0;' $'\a' "$@"
}

function info_print () {
    local esc_begin esc_end
    esc_begin="$1"
    esc_end="$2"
    shift 2
    printf '%s' ${esc_begin}
    for item in "$@" ; do
        printf '%s ' "$item"
    done
    printf '%s' "${esc_end}"
}

precmd() {
    case $TERM in
        (xterm*|rxvt*)
            set_title ${(%):-"%n@%m: %~"}
            ;;
    esac
}

##########

function homeshick() {
  if [ "$1" = "cd" ] && [ -n "$2" ]; then
    cd "$HOME/.homesick/repos/$2"
  else
    $HOME/.homesick/repos/homeshick/bin/homeshick "$@"
  fi
}

# This has to come before compinit for zsh to pick up homeshick completion
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)
fpath=($ZSH/custom/completions $fpath)
fpath=(/usr/share/zsh/site-functions $fpath)

# Unset previous iterations
unset -f fc >/dev/null 2>&1
unset -f h >/dev/null 2>&1
unset -f wd >/dev/null 2>&1
unset -f bfg >/dev/null 2>&1
unset -f which >/dev/null 2>&1
unset -f defrag >/dev/null 2>&1
unset -f define >/dev/null 2>&1
unalias h >/dev/null 2>&1

## from sh and its derivates (bash, zsh etc.)
[ ! -r ${HOME}/.homesick/repos/homeshick/homeshick.sh ] || . ${HOME}/.homesick/repos/homeshick/homeshick.sh
## Source aliases
[ ! -r $HOME/aliases.sh ] || . $HOME/aliases.sh
safetytoggle -n

[ ! -r ${HOME}/.profile ] || . ${HOME}/.profile

## Load zsh-completions plugin
plugins+=(zsh-completions)
autoload -U promptinit && promptinit
## -U: Ignore any aliases when loading a function like compinit or bashcompinit
## +X: Just load the named function fow now and don't execute it
#autoload -U +X compinit && compinit
autoload -U +X compinit && compinit -u
autoload -U +X bashcompinit && bashcompinit
#autoload -U compinit && compinit -u
#autoload -U bashcompinit && bashcompinit

#compdef '_systemctl ' scrs
#compdef '_systemctl ' uscrs
#compdef '_systemctl_status ' scrs
#compdef '_systemctl_status ' uscrs
#compdef '_systemctl ' scrs2
#compdef '_systemctl ' uscrs2
#compdef '_systemctl_status ' scrs2
#compdef '_systemctl_status ' uscrs2

## Source aliases
#source "$HOME/aliases.sh" || echo 'aliases.sh  not found...'

# {{{ 'hash' some often used directories
# #d# start
#example:
#hash -d store=/store
#hash -d calibre=/store/calibre
#hash -d efi=/boot/efi/EFI/arch
#hash -d bin=${HOME}/bin
#hash -d school=${HOME}/school
#hash -d aur=${HOME}/aur
#hash -d projects=${HOME}/projects
#hash -d torrents=${HOME}/torrents
#hash -d tv=$HOME/video/tv
#hash -d screens=$HOME/bilder/Screenshots/2015
#hash -d fanfic=$HOME/documents/fanfic
#d# end
# }}}

### ZLE tweaks ###

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
## the default
WORDCHARS=''
#WORDCHARS='.'
#WORDCHARS='*?_[]~=&;!#$%^(){}'
#WORDCHARS='*?_[]~=&;!#$%^(){}<>'
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>'
#WORDCHARS='${WORDCHARS:s@/@}'
#WORDCHARS='_-*~'

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

## Don't hash ssh hosts
#local knownhosts
#knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
#zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts

## {{{ completion system

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # complete 'cd -<tab>' with menu
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list true

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    zstyle ':completion:*'		   matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    # if there are more than 5 options allow selecting from a menu
    zstyle ':completion:*'                 menu select=2

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'
    #zstyle ':completion:reptyr:*'	   command 'ps c -u ${USER} -o command | uniq'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters


    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose true

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
    zstyle ':completion:*:killall:*' command 'ps -u ${USER} -o cmd'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..

    # run rehash on completion so new installed program are found automatically:
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }

    ## correction
    # try to be smart about when to use what completer...
    #setopt correct
    zstyle -e ':completion:*' completer '
        if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
            _last_try="$HISTNO$BUFFER$CURSOR"
            reply=(_complete _expand _correct _approximate _match _ignored _prefix _files)
        else
            if [[ $words[1] == (rm|mv) ]] ; then
                reply=(_complete _files)
            else
                reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
            fi
        fi'

    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/srv/http' 'public_html'

## }}} end completion system

## set colors for use in prompts
if zrcautoload colors && colors 2>/dev/null ; then
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg_bold[red]}%}"
    GREEN="%{${fg[green]}%}"
    CYAN="%{${fg[cyan]}%}"
    MAGENTA="%{${fg[magenta]}%}"
    YELLOW="%{${fg[yellow]}%}"
    WHITE="%{${fg[white]}%}"
    NO_COLOUR="%{${reset_color}%}"
else
    BLUE=$'%{\e[1;34m%}'
    RED=$'%{\e[1;31m%}'
    GREEN=$'%{\e[1;32m%}'
    CYAN=$'%{\e[1;36m%}'
    WHITE=$'%{\e[1;37m%}'
    MAGENTA=$'%{\e[1;35m%}'
    YELLOW=$'%{\e[1;33m%}'
    NO_COLOUR=$'%{\e[0m%}'
fi

kill -TRAP $$

## Archived commands

true || {
## Unset traps and execute cleanup function after configuration fully loaded to fix errors
[[ "${EUID}" -ne 0 ]] && cleanup ${HOME} || cleanup ${PWD}
[[ ! "${TERM}" =~ ^(xterm|rxvt|screen).*$ ]] && export TERM=xterm-256color
## Reset fd redirections and close fds
exec 1>&3; exec 2>&4; exec 0<&6
exec 3>&-; exec 4>&-; exec 6<&-; exec 7<&- #or 7>&-
## Error check
[[ -z `cat "${ZSH_ERROR}"` || ! -r "${ZSH_ERROR}" ]] && \
echo "\n${fg_bold[green]}zshrc: no errors detected${reset_color}" || \
echo "\n${fg_bold[red]}zshrc: the following errors were detected:${reset_color}\n"`cat ${ZSH_ERROR}`"\n"
## cleanup env and temp files
[[ -r "${ZSH_ERROR}" ]] && rm -rf "${ZSH_ERROR}"
[[ "${ZSH_ERROR}" ]] && unset "${ZSH_ERROR}"
trap -
}

