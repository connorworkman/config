#!/bin/zsh

# aliases.sh
#
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
## Example aliases
alias zshconfig='nano ${HOME}/.zshrc '
alias ohmyzsh='pushd ${HOME}/.oh-my-zsh '

## Custom aliases
alias fuck='sudo $(fc -ln -1) '
#alias fuck='sudo $(history -p \!\!) '
alias omz='pushd ${ZSH:-${HOME}/.oh-my-zsh} '
alias calias='gvim ${HOME}/aliases.sh '
alias cbalias='gvim ${HOME}/baliases.sh '
alias czsh='gvim ${HOME}/.zshrc '
alias cbash='gvim ${HOME}/.bashrc '
alias ctmux='gvim ${HOME}/.tmux.conf '
alias cxr='gvim ${HOME}/.Xresources '
alias cxi='gvim ${HOME}/.xinitrc '
alias sxinit='sudo xinit /usr/bin/xterm  -e "su alyptik -c openbox-session"  $* -- :1 '
alias sdwim='antigen-bundle oknowton/zsh-dwim '
#alias ctput='for ((i=7;i<50;i++));do printf "$(tput setaf $i) %s " "derp" ; done'
#alias sdwim='. /usr/share/zsh-dwim/init.zsh '
alias ptpb='curl https://ptpb.pw -F c=@- '
alias fptpb='pbpst -S#f '
alias qemu='qemu-system-x86_64 -enable-kvm -net tap -net nic,model=virtio -usb -device \
usb-host,hostbus=3,hostaddr=2 -vga vmware -spice \
port=5930,disable-ticketing,addr=::1 -m 1024 deb8subvols.qcow2  '
alias kindle='kindlegen -c0 -verbose '
alias icast='sudo icecast -b -c /etc/icecast.xml '
alias v='vim -p '
alias gv='gvim -p '
alias sv='sudo vim -p '
alias sgv='sudo gvim -p '
alias vr='vim -p --remote-tab '
alias gvr='gvim -p --remote-tab '
alias svr='sudo vim -p --remote-tab '
alias sgvr='sudo gvim -p --remote-tab '
alias s3r='rsync -avzP --info=progress2 --delete /@media/microsd-32g/Music/ /@media/microSDXC/Music/ '
#alias lgr='rsync -avzP --info=progress2 --delete /@media/microSDXC/Music/djzomg/ /@media/sd_fat32/Music/djzomg/ '
#alias lgr='rsync -avzP --info=progress2 --delete /@media/sd_fat32/Music/djzomg/ /@media/microSDXC/Music/djzomg/ '
alias lgr='rsync -avzP --info=progress2 --delete /@media/shared/Music/ /@media/microSDXC/Music/ '
alias adbr='rclone sync /@media/microSDXC/audio/ dropbox:/EDM/audio/ '
#alias pdbr='rclone sync /@media/microSDXC/Practice\ Mixes/ dropbox:/EDM/practice/ '
#alias dbr='rclone sync /@media/microSDXC/Music/djzomg/ dropbox:/EDM/djzomg/ '
alias s-config='pushd /store/config 2>1 1>&- '
alias entropy='watch -n .1 cat /proc/sys/kernel/random/entropy_avail '

#alias stdoutlog='ls "$@" | sort | tee >(rev > /tmp/output) '
#alias sbs='bsign --key /etc/refind.d/keys/refind_local.key --cert /etc/refind.d/keys/refind.crt --output /boot/efi/EFI/tooks/gdisk_x64.efi ./gdisk_x64.efi '
#alias printfd="echo 'out twice' | { { tee /dev/fd/2yes | grep . >&3 ; } 2>&1 | grep . ; } 3>&1 | nl "
#alias printfd="echo 'out twice' | { { tee /dev/fd/2yes | grep . >&3 ; } 2>&1 | grep . ; } 3>&1 | nl "
#alias findfd="ls -lAhqiQFs1 --color=auto /proc/$$/fd | awk '{ print $10 }' "
alias _='sudo '
alias sudo='sudo '
alias urxvtq='urxvt -kuake-hotkey F12 '
alias urxvtcq='urxvtc -kuake-hotkey F12 '
alias scodes='sudo showkey --scancodes '
alias c-du='cdu -idh '
alias dh='dirs -v '
alias kd='kdesu '
alias ks='kdesudo '
alias k='kate '
alias sk='kdesudo kate '
alias nw='nano -w '
alias snw='sudo nano -w '
alias ltool='libtool --finish /usr/lib '
alias ipc='pacaur -Si '
alias qpc='pacaur -Ql '
alias upc='pacaur -Syyu '
alias dpc='pacaur -Syyu --devel '
alias npc='pacaur --noconfirm -Syyu '
alias rpc='pacaur -R '
alias rcpc='pacaur -Rc '
alias spc='pacaur -S '
alias sspc='pacaur -Ss '
#alias npac='pacaur --noconfirm --noedit -S '
alias iapac='apacman --skipinteg -S '
alias para='parallel '
alias r-s='rsync -avzP --info=progress2 --partial '
alias ping6='ping -6c 5 '

alias cmount='mount | column -t '
alias j='jobs -l '
alias path='echo -e ${PATH//:/\\n} '
alias now='date +"%T" '
alias nowtime='now '
alias nowdate='date +"%d-%m-%Y" '
alias svi='vi "+set si" '
alias svim='vim "+syntax on" "+set si" '
alias fi-btrfs='sudo btrfs filesystem show '
alias us-btrfs='sudo btrfs filesystem usage -T / '
alias df-btrfs='sudo btrfs filesystem df -h / '
alias sb-btrfs='sudo btrfs scrub start -B -R / '
alias ss-btrfs='sudo btrfs scrub status -R / '
alias bl-btrfs='sudo btrfs balance start -v / '
alias bs-btrfs='sudo btrfs balance status -v / '
alias sn-btrfs='sudo btrfs subvolume snapshot '
alias ls-btrfs='sudo btrfs subvolume list . '
alias dl-btrfs='sudo btrfs subvolume delete / '
#alias ds-btrfs='sudo btrfs subvolume delete /run/btrfs/__snapshot/__state_at_last_successful_boot/* '
alias ds-btrfs='sudo btrfs subvolume delete /btrfs/__snapshot/__active/* '
#alias dg-btrfs='sudo btrfs filesystem defragment -v -r -clzo / '
alias dg-btrfs='sudo btrfs filesystem defragment -r -v / '

alias lfd='ls -lAhqiQFs1 --color=auto /proc/$$/fd '
alias lbc='bc -l /store/scripts/funcs.bc '
alias tzswap="sudo su -c 'sed y/NY/YN/ /sys/module/zswap/parameters/enabled >|/sys/module/zswap/parameters/enabled && cat /sys/module/zswap/parameters/enabled' "
alias sgcc='gcc -O2 -S -c '
alias show-sgcc='gcc -c -g -Wa,-a,-ad '
alias nostdgcc='gcc -m32 -nostdlib -Wl,-melf_x86_64 -o '
alias asgcc='gcc -m32 -nostdlib -o helloworld helloworld.o -Wl,-melf_x86_64 '
alias na='nasm -f elf '
alias na64='nasm -f elf64 '
alias nld='ld -m elf_i386 '
alias nld64='ld -m elf_x86_64 '
alias sld='ld -s -I/lib64/ld-linux-x86-64.so.2 /usr/lib/crt1.o /usr/lib/crti.o -lc /usr/lib/crtn.o '
alias ald='ld -I/lib64/ld-linux-x86-64.so.2 /usr/lib/crt1.o /usr/lib/crti.o -lc /usr/lib/crtn.o '

## New shell functions
ajack() {
	#alsa_in -j UFO_1 -d "hw:2,0" &>/dev/null &
 	#alsa_in -j UFO_2 -d "hw:3,0" &>/dev/null &
	#alsa_in -j UCA -d "hw:4,0" &>/dev/null &
	#alsa_out -j UFO_1 -d "hw:2,0" &>/dev/null &
	#alsa_out -j UFO_2 -d "hw:3,0" &>/dev/null &
	#alsa_out -j UCA -d "hw:4,0" &>/dev/null &
	alsa_out -j DeckA_Out -d "hw:2,0" &> /dev/null &
	alsa_in -j DeckA_In -d "hw:2,0" &> /dev/null &
	alsa_out -j DeckB_Out -d "hw:3,0" &> /dev/null &
	alsa_in -j DeckB_In -d "hw:3,0" &> /dev/null &
	alsa_out -j Cue_Out -d "hw:4,0" &> /dev/null &
	alsa_in -j Cue_In -d "hw:4,0" &> /dev/null &
}
tgv() {
    [[ -z "$(pgrep -fx "gvim --servername GVIM")" ]] || gvim --servername GVIM
    [[ -z "$1" ]] || gvim --servername GVIM --remote-tab-silent "${@}"
}
setup-scg() {
	[[ "$PWD" != /store/config ]] && pushd /store/config &>/dev/null || local DIRVAR=1
	#git init .
	#git remote add origin git+ssh://git@github.com/alyptik/config.git
	git remote set-url origin git+ssh://git@github.com/alyptik/config.git
	(($DIRVAR)) || popd &>/dev/null
}
scg() {
	[[ "$PWD" != /store/config ]] && pushd /store/config &>/dev/null || local DIRVAR=1
	git add .
	#git commit -F <(printf "Configuration backup on $(date).\n") && {
	git commit -m "Configuration backup on $(date)." && {
		git push && \
			printf "\n \033[32m %s \n\033[0m" "Commit successful!" || \
			printf "\n \033[31m %s \n\033[0m" "Error during push..."; } || {
		printf "\n \033[31m %s \n\033[0m" "Nothing to commit..."; }
	(($DIRVAR)) || popd &>/dev/null
}
par() {
	pulseaudio --check && { 
		pulseaudio --kill; sleep 1; pulseaudio --start --realtime; } || {
		pulseaudio --start --realtime; }
}
kattach() {
	( printf "%s\n" \
	    "Subject: " \
	    "To: alyptik@kindle.com" \
	    "Content-Type: application/${1##*.}" \
	    "Content-Disposition: attachment; filename=${1?No file specified.}" \
	    "Content-Transfer-Encoding: base64" \
	    ""; base64 ${1} ) | sendmail "alyptik@kindle.com"
}
dbr() {
	find /@media/microSDXC/audio -maxdepth 1 -name "*TSL*" -type d -print | \
		sed 's/^.*\/\(TSL.*\)$/\1/' | \
		while read -r; do
			rclone move /@media/microSDXC/audio/${REPLY} dropbox:/EDM/TSL/${REPLY}
		done
	find /@media/microSDXC/audio -maxdepth 1 -name "*alyptik*" -type d -print | \
		sed 's/^.*\/alyptik - \(.*\)$/\1/' | while read -r; do
                rclone lsd "dropbox:/edm/audio/$(<<<${REPLY:l} sed 's/ (.*//')" 2>/dev/null && \
			printf '\n \033[31m %s \n\033[0m' \
				"Directory dropbox:/edm/audio/$(<<<${REPLY/*- /} \
				sed 's/./\l&/g;s/ (.*//') exists!" || \
			rclone move "/@media/microSDXC/audio/alyptik - ${REPLY}" \
				"dropbox:/edm/audio/$(<<<${REPLY/*- /} \
				sed 's/./\l&/g;s/ (.*//')"
		done
	find /@media/microSDXC/wanderlust -maxdepth 1 -name "*Wanderlust Ep.*" -type d -print | \
		while read -r; do
        		rclone move "$REPLY" \
				'dropbox:/edm/wanderlust/'"${REPLY/*wanderlust\//}"
		done
	#rclone sync /@media/microSDXC/audio/ dropbox:/EDM/audio/
	rclone sync "/@media/microSDXC/Music/djzomg/" "dropbox:/EDM/djzomg/"
	rclone move "/@media/microSDXC/Practice Mixes/" "dropbox:/EDM/practice/"
	#rclone move /@media/microSDXC/Practice\ Mixes/ dropbox:/EDM/practice/
}
gs-pdf() {
	printf '%b' "Input file: $1\nOutput file: $(<<<"$1" sed 's/^\(.*\)\.pdf$/\1-gs.pdf/')\n"
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(<<<"$1" sed 's/^\(.*\)\.pdf$/\1-gs.pdf/') "$1"
}
mgif() {
	[[ -z "$1" ]] && echo "No file specified." || \
	ffmpeg -i "$1" -s 480x360 -pix_fmt rgb24 -r 24 -f gif - |\
	gifsicle --unoptimize --dither --delay=4 > "$1.gif"
}
vk() {
	local search="$1"
	while [[ ! -z "$2" ]]; do shift && search="$search+$1"; done
	local vkurl='http://vk.com/audios361427414?act=popular&q='"$search"
	#xdg-open "$vkurl"
	open_command "$vkurl"
}
#fpastebin() {
#	curl F -c=@$(<<<${1} sed -r 's/^\/(.*)/\1/')  https://ptpb.pw
#}
colortput() {
	local colorcount=${1:-25}
	for ((i=0;i<${colorcount};i++)); do
	  #[[ "$colorcount" -lt 10 ]] && {
	    #printf "\e[38;4;29m[%d]$(tput sgr0)$(tput setaf $i)%s\t" "$i" "derp"
	    #printf '%s' "\e[38;4;29m[%d]$(tput sgr0)$(tput setaf $i)%s" "$i" "derp"; } || {
	    printf "\e[38;4;29m\n[%d]$(tput sgr0)$(tput setaf $i) %s" "$i" "derp"
	    printf '\t%s' "\e[38;4;29m\n[%d]$(tput sgr0)$(tput setaf $i)%s"
	done
}
#ctput() {
#	## List Termcap colors'
#	local colorcount=${1:-25}
#	for ((i=0;i<${colorcount};i++)); do
#		[[ "$colorcount" -ge 25 ]] && {
#		printf "\e[38;4;29m[%d]$(tput sgr0)$(tput setaf $i)%s" "$i" "derp"
#		echo -e ""; } || {
#		printf "\e[38;4;29m\n[%d]$(tput sgr0)$(tput setaf $i)%s" "$i" "derp"; }
#	done
#
#}
ldas() {
        [[ ${#} -ne 3 ]] && { printf " \033[31m %s \n\033[0m" "Need 3 arguments..."; return 1; } || {
                nasm -f elf64 "$1" -o "$2"
		ld -m elf_x86_64 "$2" -o "$3"
                printf " \033[32m %s \033[0m\n" "Assembling \"${1}\" into \"${2}\"..."
                printf " \033[32m %s \033[0m\n" "Linking \"${2}\" into \"${3}\"..."
                printf " \033[32m %s \033[0m\n" "Done, created \"${PWD}/${3}\""'!'
                return 0; }
}
ldas() {
        [[ ${#} -ne 3 ]] && { printf " \033[31m %s \n\033[0m" "Need 3 arguments..."; return 1; } || {
                as "$1" -o "$2"
                ld --dynamic-linker="/lib64/ld-linux-x86-64.so.2" \
                        /usr/lib/crt1.o /usr/lib/crti.o \
                        -lc "$2" /usr/lib/crtn.o -o "$3"
                printf " \033[32m %s \033[0m\n" "Assembling \"${1}\" into \"${2}\"..."
                printf " \033[32m %s \033[0m\n" "Linking \"${2}\" into \"${3}\"..."
                printf " \033[32m %s \033[0m\n" "Done, created \"${PWD}/${3}\""'!'
                return 0; }
}
tmpcurl() {
    [[ ${#} -lt 1 ]] && { printf " \033[31m %s \n\033[0m" "Error, no arguments..."; return 1; } || {
	local url="$1"
	printf " \033[32m %s \033[0m" "[Continue downloading script at: \"${url}\"? (Y/n)] "; read -r
	#read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
	case $REPLY in
		[Yy]*|'') : ;; ## Continue
		[Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."; return 1 ;;
		*) printf " \033[31m %s \n\033[0m" "Invalid input..."; return 1 ;;
	esac 
	curl -O "${url}"
	return 0; }
}
shcurl() {
    [[ ${#} -lt 1 ]] && { printf "\033[31m %s \n\033[0m" "Error, no arguments..."; return 1; } || {
	local url=${1}
	printf " \033[32m %s \033[0m" "[Continue executing script at: \"${url}\"? (Y/n)] "; read -r
	#read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
	case $REPLY in
		[Yy]*|'') : ;; ## Continue
		[Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."; return 1 ;;
		*) printf " \033[31m %s \n\033[0m" "Invalid input..."; return 1 ;;
	esac 
	sh -c "$(curl -fsSL ${url})"
	return 0; }
}
## Btrfs balance with -dusage filter
bd-btrfs() {
	[[ ${#} -ge 1 ]] && local dpercent="$1" || local dpercent=100
	[[ ${#} -ge 2 ]] && local mpercent="$2" || local mpercent=0
	[[ ${#} -ge 3 ]] && local target="$3" || local target='/'
	echo "Running balance on \"${target}\" with -dusage=${dpercent} and -musage=${mpercent}..."
	sudo btrfs balance start -v -dusage="${dpercent}" -musage="${mpercent}" "${target}"
	return 0
}
certfp() {
	pushd . &>/dev/null
	cd "${HOME}/certs/irc"
	local nick="${1:-alyptik}"
	openssl req -newkey rsa:2048 -days 730 -x509 -keyout ${nick}.key -out ${nick}.cert
	#touch "./${nick}"'.pem'
	cat "${nick}.cert" "${nick}.key" >"${nick}.pem"
	#openssl x509 -sha1 -noout -fingerprint -in "$1" | sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/'
	openssl x509 -sha1 -noout -fingerprint -in "${nick}.pem" | \
		sed -e 's/^.*=//;s/://g;y/ABCDEF/abcdef/'## sed is optional
	popd &>/dev/null
}
## Alternate man functions
man() { /bin/man "$@"; return 0; }
man2() {
    local width=$(tput cols)
    [[ "$width" -gt "$MANWIDTH" ]] || width="$MANWIDTH"
    env MANWIDTH="$width" \
    		man "$@"
    return 0
}
man3() {
    local width=$(tput cols)
    [[ "$width" -gt "$MANWIDTH" ]] || width="$MANWIDTH"
    env MANWIDTH="$width" \
	LESS='-FRMsw' \
	GROFF_NO_SGR=1 \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[38;5;35m' \
	LESS_TERMCAP_md=$'\E[1;31m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[4;32;4;132m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[30;43m' \
	LESS_TERMCAP_md=$'\E[1;31m' \
    	man "$@"
    return 0
    true || {
	LESS="-sMNR" \
	LESS_TERMCAP_mb=$'\E[01;31m' \
	LESS_TERMCAP_md=$'\E[01;31;5;74m' \
	LESS_TERMCAP_me=$'\E[0m' \
	LESS_TERMCAP_se=$'\E[0m' \
	LESS_TERMCAP_so=$'\E[38;5;246m' \
	LESS_TERMCAP_ue=$'\E[0m' \
	LESS_TERMCAP_us=$'\E[04;33;146m' \
	GROFF_NO_SGR=1
    }
}

## Complicated functions
sslpkeygen() {
  echo -n '[input directory to store certificates:] ' ; read keydir
   #([~.]|${HOME})/*[^/]+ ) echo 'using "'"${keydir}"'/private".'  | sed -r 's@\/\/+@\/@g' ;;
   #([~.]|"${HOME}"|[^/)* ) echo 'using "'"${keydir}"'/private".' | sed -r 's@\/\/+@\/@g' ;;
   #[^/]* ) echo 'using "'"${keydir}"'/private".' ;;
   #"" ) echo 'nothing entered. Using "'"${keydir:="$PWD"/private}"'".' ;;
   #* ) echo 'please run "pushd '"${keydir}"'" first.'  ;;
  case "${keydir}" in
   "/"* ) printf '%s\n' 'please run '"'pushd ${keydir}'"' first.'  ;;
   ""|[\~\.]|${HOME}* ) echo 'using "'${keydir:="$PWD"}'/private".' | sed -r 's@\/\/+@\/@g' ;;
  esac
  [[ ${keydir} =~ ^[^\/].*  ]] || \
   { echo 'please run "pushd '"${keydir}"'" first.'; echo "$keydir"; return 1; }
  echo 'using "'"${keydir}"'/private".'

  pushd ${keydir}
  [[ -d private ]] || mkdir -m0700 private
  touch private/key.pem
  chmod 0600 private/key.pem

  sslvar='
	 List of Available SSL Options:
	  [1] - 	Self-signed root certificate
		  $ openssl req -x509 -newkey rsa:2048 -keyout key.pem -out req.pem
	  [2] -  Create a private key and then generate a certificate request from it
		  $ openssl genrsa -out private/key.pem 2048
		  $ openssl req -new -key key.pem -out req.pem
		  $ openssl req -newkey rsa:2048 -keyout key.pem -out req.pem
		  $ openssl req -new -sha256 -key private/key.pem -out req.csr
		  $ openssl req -key private/key.pem -x509 -new -days 3650 -out cacert.pem
	  [3] - 	Remove password / encryption
		  $ openssl req -new -key server.key -out server.csr
		  cp server.key server.key.org
		  $ openssl rsa -in server.key.org -out server.key
		  $ openssl genpkey -aes-256-cbc -algorithm RSA \
			 -out private/key.pem -pkeyopt rsa_keygen_bits:4096
	  [5] -  Examine and verify certificate request:
		  $ openssl req -in req.pem -text -verify -noout
		  $ openssl x509 -req -days 365 -in req.csr -signkey server.key -out server.crt
	  [6] -  Convert from PEM to DER for browsers
		  $ openssl x509 -in ca.pem -outform DER -out ca.der
	  [7] - 	Generate an RSA private key using default parameters:
		   $ openssl genpkey -algorithm RSA -out key.pem
		  Encrypt output private key using 128 bit AES and the passphrase "hello":
		   $ openssl genpkey -algorithm RSA -out key.pem -aes-128-cbc -pass pass:hello
		  Generate a 2048 bit RSA key using 3 as the public exponent:
		   $ openssl genpkey -algorithm RSA -out key.pem -pkeyopt rsa_keygen_bits:2048 \
			 -pkeyopt rsa_keygen_pubexp:3
	  [8] - 	 Generate 1024 bit DH parameters:
		   $ openssl genpkey -genparam -algorithm DH -out dhp.pem \
			 -pkeyopt dh_paramgen_prime_len:1024
		  Output RFC5114 2048 bit DH parameters with 224 bit subgroup:
		   $ openssl genpkey -genparam -algorithm DH -out dhp.pem -pkeyopt dh_rfc5114:2

		  Generate DH key from parameters:
		   $ openssl genpkey -paramfile dhp.pem -out dhkey.pe
	  [9] - 	 Generate EC parameters:
		   $ openssl genpkey -genparam -algorithm EC -out ecp.pem \
			  -pkeyopt ec_paramgen_curve:secp384r1 \
			  -pkeyopt ec_param_enc:named_curve
		  Generate EC key from parameters:
		   $ openssl genpkey -paramfile ecp.pem -out eckey.pem
		  Generate EC key directly:
		   $ openssl ecparam -name secp256k1 -genkey -noout -out secp256k1-key.pem'"\n"
	 #tee /dev/tty "${sslvar}"
	 echo "${sslvar}"
	 echo -n '[enter option #:(1-9)] ' ; read choice
  case "${choice}" in
   1) echo 1 ;;
   2) echo 2 ;;
   3) echo 3 ;;
   4) echo 4 ;;
   5) echo 5 ;;
   6) echo 6 ;;
   7) echo 7 ;;
   8) echo 8 ;;
   9) echo 9 ;;
   "") echo 'no option number entered.' ;;
   *) echo 'Option "'${choice}'" not found.'  ;;
  esac
  ls -l "${keydir}"
  popd
}
chud() {
	#killall conky && sleep 2
	#conky -c /home/alyptik/.conky/.clockconky
	#conky -c /home/alyptik/.conky/.netconky 
	#conky -c /home/alyptik/.conky/.mainconky
	#conky -c /home/alyptik/.conky/.conkyrc2
	#[[ pidof -x $(basename $0) > /dev/null ]] && killall conky;
	[[ ! -z "$(pgrep conky)" ]] && killall conky;
	sleep 2;
	conky -c /home/alyptik/.conky/.clockconky;
	conky -c /home/alyptik/.conky/.netconky;
	conky -c /home/alyptik/.conky/.mainconky;
	conky -c /home/alyptik/.conky/.conkyrc2;

}
vbinit() {
	sudo modprobe vboxnetadp vboxnetflt vboxpci vboxdrv ;
	sudo vboxreload ;
	#VBoxManage hostonlyif create ;
	#VBoxManage natnetwork start --netname vbnat ;
}
szexpac() {
	echo -n "$@" '[perform size-sorted search for:] ' ; read ans
	expac -s "%-30n %m" | sort -hk 2 | awk '{printf "%s %.0f MiB\n", $1, $2/1024/1024}' | column -t | grep "$ans" ;
	#case "$ans" in
         #*) return 1 ;;
         #) return 0 ;;
	#esac
}
dtexpac() {
	echo -n "$@" '[# of recently installed entries to list:] ' ; read ans
	expac --timefmt='%y-%m-%d %T' '%l\t%n' | sort | tail "-$ans" ;
	#expac --timefmt=%s '%l\t%n' | sort -n | tail -20 | grep "$ans" ;
}
abexpac() {
	echo -n "$@" '[perform alphabetical search for:] ' ; read ans
	expac -s "%-25n %v" | grep "$ans" ;
}
dsgenkey () {
        if [[ ! "${1}" > /dev/null ]] ; then
         printf '%s\n' 'No zone specified!' ;
        else
         pushd /etc/bind ;
         sudo dnssec-keygen -a NSEC3RSASHA1 -b 2048 \
         -K /etc/bind/private -n ZONE "$1" ;
         sudo dnssec-keygen -f KSK -a NSEC3RSASHA1 \
         -b 4096  -K /etc/bind/private -n ZONE "$1" ;
         for key in `ls /etc/bind/private/K"$1"*.key`; do
          sudo echo "\$INCLUDE /etc/bind/private/${key}">>/etc/bind/db."$1" ;
         done
         sudo dnssec-signzone -A -3 \
         $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) \
         -N INCREMENT -K ./private -o "$1" -S -t db."$1" ;
         popd;
        fi
}
dssign () {
	[[ ${PWD} != /etc/bind ]] && pushd . >/dev/null 2>&1
	cd "/etc/bind"
	if [[ ! ${1} ]]; then
         printf '%b' 'no zone specified!\nsign "alyptik.xyz"? (Y/n)' ; read ans
         [[ ${ans} =~ ([ \t]*[Yy].*|) ]] && { popd >/dev/null 2>&1; dssign 'alyptik.xyz'; return 0; }
          echo -n "\r\nenter zone(s) to sign: " ; read ans2
	  [[ -z ${ans2} ]] && { echo "exiting..."; return 2; } || \
	  { zarray=(`<<<$ans2`);
	  popd >/dev/null 2>&1;
	  dssign $zarray[@];
	  return 0; }
	else
 	  IFSold=${IFS}
	  IFS=$'\n' 
 	  printf '%b\n\t' \
	  	'signing zone(s): ' "${@}" '\rstarting script...'
 	  IFS=${IFSold}
	  #echo -en "\r"
	  printf '%b' "\r"
	fi
	 for i in "${@}" ; do
	  SERIAL=$(named-checkzone ${i} db.${i} | \
	  	egrep --color="never" -ho '[0-9]{10}')
	  	#sed 's/.*K\([[:digit:]]{10}\).*/\1/')
	  sudo sed -i 's/'${SERIAL}'/'$((${SERIAL}+1))'/' db.${i}
	  sudo dnssec-signzone -A -3 \
	  	$(head -c 1000 /dev/random | sha1sum | cut -b 1-16) \
	  	-N INCREMENT -K ./private -o ${i} -S -t db.${i}
	 done
	popd >/dev/null 2>&1
	return 0
}
lpackages() {
	#echo -n "$@" '[search all locally-installed packages for:] ' ; read ans
	printf '%s' '[search all locally-installed packages for:] ' ; read ans
	[[ ! -z "${ans}" ]] && /usr/local/bin/all-packages | grep "${ans}" || \
	/usr/local/bin/all-packages | less ;
	#case "${ans}" in
	 #*) /usr/local/bin/all-packages | grep "$ans" ;;
	 #\0) /usr/local/bin/all-packages | less -R ;;
	#esac
}
snft () {
        if [[ ! -e "/tmp/nft" ]] ; then
         printf '%s\n' 'Writing nftables ruleset to /tmp/nft.' ;
         sudo printf '%s\n' "nft flush ruleset" >/tmp/nft ;
         sudo nft list ruleset -annn >>/tmp/nft ;
         sudo gvim /tmp/nft ;
        else
         printf '%s\n' '/tmp/nft exists!' ;
        fi
}
csu() {
	[[ ${#} -ge 1 ]] && {
		echo " [running:] su -c \""${*}"\" ";
		sudo su -c "$*" && return 0 || echo " error: multiple or incorrect commands entered."; }
	echo -ne " [please enter \";\" delimited root commands:] (i.e.: \`cmd1; cmd2...\`) "; read -r
	## IFS safety net
	IFSbackup=${IFS}
	cstring=$(sed -r '
		:loop
		s_[; \t]*(;)[; \t]* _\1_g
		s_[ \t]*(;)[ \t]* _\1_g
		/$/!b loop' <<< ${REPLY})
	## Set temporary IFS and convert ${cstring} to ${carray[@]}
	IFS=; read -r -A carray <<< ${cstring}
	echo -ne "\n"
	printf '%s\n' 'running the following commands as root:' \
		`tr ';' '\n' <<< ${carray[@]} | sed -r 's/^(..*)/ \1/'`
	printf '%b' 'starting "su -c" command execution...\n\n'
        { for i in $carray[@]; do sudo su -c ${i}; done; } && return 0 || return 1

	## Old commands
	if [ true ]; then
	 return 10
	else
	 [[ ! -z ${*} && ${#} -eq 1 ]] && {
		echo -e " running: 'su -c \"${*}\"'";
		sudo su -c "$*";
		return 10; }
	 [[ ${#} -ge 2 ]] && printf '%b' ' command input too ambiguous!\n continuing script....\n'
	 while IFS=';' read -r cmd; do sudo su -c '"'${cmd}'"'; done <<< "${ans}"
	 carray=( printf '%s' "$*" )
	 for i in "${carray[@]}" ; do
          command='"'${i}'"'
          sudo su -c "${command}"
         done
	 carray=(`printf '%s' "${rcom}" | sed -r '
		:loop
		s_(;)[; \t]* _\1_g
		s_[ \t]*(;)[ \t]* _\1_g
		/$/!b loop' | tr ';' '\n'`)
	 for i in "${carray[@]}" ; do
	  command='"'${i}'"'
	  sudo su -c "${command}"
	 done
	 for i in ${carray[@]}; do
          scommand="sudo su -c \""${i}"\""
	  #scommand=${scommand}${i}
	  #scommand=${scommand}'"'
	  #[[ -x $(which bash) ]] && bash -c ${scommand} || sh -c ${scommand}
	 done
	 return 20
	fi
}
## Common shell functions
# Unset previous iterations
unset -f fc >/dev/null 2>&1
unset -f h >/dev/null 2>&1
unset -f wd >/dev/null 2>&1
unset -f bfg >/dev/null 2>&1
unset -f which >/dev/null 2>&1
unset -f defrag >/dev/null 2>&1
unset -f define >/dev/null 2>&1
## Fix zsh annoying history behavior
h() { if [ -z "$*" ]; then tail ${HISTFILE}; else egrep "$*" "${HISTFILE}"; fi; }
#h() { if [ -z "${*}" ]; then history 10; else history | egrep $@; fi; }
#h() { if [ -z "${*}" ]; then history 10; return 1; fi; if [[ ${#1} -le 2 ]]; then history ${1}; return 2; else history | egrep ${@}; fi; }
scrs() {
    for i in "$@"; do
	sudo systemctl restart "$i"; systemctl status --full --no-pager "$i"; echo -n "\n"
    done
}
uscrs() {
    for i in "$@"; do 
	systemctl --user restart "$i"; systemctl --user status --full --no-pager "$i"; echo -n "\n"
    done
}
scrs2() {
	sudo parallel systemctl ::: restart status ::: "$*"
}
uscrs2() {
	parallel systemctl --user ::: restart status ::: "$*"
}
# wd() { . "${ZSH}"/plugins/wd.sh; }
wd() { . /home/alyptik/bin/wd/wd.sh; }
## Resume a background job
bfg() {	if [ ${#1} -ne 1 ]; then echo 'attempting to resume job "%1"'; j=1; else j=${1}; fi; %${j} & }
## Alternate which`fucntionality
#alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde '
which() { (alias; declare -f) | /bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@; }
#export -f which
define(){ IFS='\n' read -r -d '' ${1} || true; }

## Custom shell functions
## Btrfs recursive filesystem defragment
defrag() {
	echo "Starting system derfagment..."
	sudo btrfs filesystem defragment -r -v / & 
	find / -xdev -type d -print -exec sudo btrfs filesystem defragment -r -v "{}" \; &
}
#defrag() { find / -xdev -type d -print -exec sudo btrfs filesystem defragment -r -v -clzo "{}" \; & }
#alias defrag='sudo find / -xdev -type d -print -exec btrfs filesystem defragment "{}" \; '
odkms() { for i in /var/lib/dkms/*/[^k]*/source; do [ -e "$i" ] || echo "$i"; done; }
colortest() {
        local fgc bgc vals seq0

        printf "Color escapes are %s\n" '\e[${value};...;${value}m'
        printf "Values 30..37 are \e[33mforeground colors\e[m\n"
        printf "Values 40..47 are \e[43mbackground colors\e[m\n"
        printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

        # foreground colors
        for fgc in {30..37}; do
                # background colors
                for bgc in {40..47}; do
                        fgc=${fgc#37} # white
                        bgc=${bgc#40} # black

                        vals="${fgc:+$fgc;}${bgc}"
                        vals=${vals%%;}
     printf "  %-9s" "${seq0:-(default)}"
                        printf " ${seq0}TEXT\e[m"
                        printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
                done
                echo; echo
        done
}
prompt_confirm() {
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input"
    esac 
  done  
  return 2 # Nothing executed past this point

  ## Example usage
  command prompt_confirm "Overwrite File?" || exit 0

  ## For Bash >= version 3.2:
  [[ $REPLY =~ ^([yY][eE][sS]|[yY])$ ]] && true || false
  ## For Bash 4.x:
  REPLY=${REPLY,,}    # to lower
  [[ $REPLY =~ ^(yes|y)$ ]] && true || false
}
## Safety nets - originally commented out to build good habits
safetytoggle() {
    ## usage variable containing help/command usage
    local usagedoc="\n"'Usage: safetytoggle [option(s)]
  Toggle or set/unset "safety" aliases (toggle by default)
Options:
  -s --safe		Force enable all safety aliases.
  -n --notsafe		Force disnable all safety aliases.
  -h --help -u --usage	View this help/usage examples (overrides other options.)
Examples:
  safetytoggle
  safetytoggle -s|--set
  safetytoggle -n|--noset
  safetytoggle -h|--help|-u|--usage
List of aliases toggled: [rm,wget,mv,cp,ln,chown,chmod,chgrp]
  rm -I --preserve-root
  wget -c
  mv -i
  cp -i
  ln -i
  chown --preserve-root
  chmod --preserve-root
  chgrp --preserve-root'"\n"
  ## Parse options
  [[ "$*" =~ ^([\-]$|\-[0-9]+|\-[hu]+[snhu]*|\-\-help|\-\-usage)+.*$ ]] && { printf "$usagedoc"; return 0; }
  [[ "$*" =~ ^(\-s[snhu]*|\-\-set)+.*$ ]] && { unalias rm wget mv cp ln chown chmod chgrp &>/dev/null; }
  [[ "$*" =~ ^(\-n[snhu]*|\-\-noset)+.*$ ]] && { alias rm='rm -I ' &>/dev/null; }
  ## Set/unset aliases
  (( `(alias; declare -f) | egrep -q '^rm=.*$'`$? )) && {
	## start from scratch
	unalias rm wget mv cp ln chown chmod chgrp &>/dev/null
	## do not delete / or prompt if deleting more than 3 files at a time
	alias rm='rm -I --preserve-root '
	## this one saved by butt so many times
	alias wget='wget -c '
	## confirmatiob
	alias mv='mv -i '
	alias cp='cp -i '
	alias ln='ln -i '
	## Parenting changing permissions on root
	alias chown='chown --preserve-root '
	alias chmod='chmod --preserve-root '
	alias chgrp='chgrp --preserve-root '
	printf "\n \033[31m %s \033[0m\n" 'Safety aliases: [Enabled]'; } || {
	unalias rm wget mv cp ln chown chmod chgrp &>/dev/null
	printf "\n \033[32m %s \033[0m\n" 'Safety aliases: [Disabled]'; }
  ## Rest of code shouldn't be executed; return 255 if it was
  true || {
  ##(( $( (alias; declare -f) | egrep -q "^rm=" )$? ))
  ## "$tval" set by testing first two command aliases (or set with -s option
  #local tval=$([[ `which wget` != /bin/wget || `which rm` != /bin/rm ]])$?
  #[[ -z "$sval" ]] || tval="$sval"
  #[[ `(alias; declare -f) | egrep "^wget\="` ]] && local tval=0 || local tval=1
  #if (( "$tval" )); then ## if tval=0 then set all aliases
  #if [[ -z $((alias; declare -f) | egrep -q "^rm\="`) ]] && local tval=0 || local tval=1

  ## wait, $tval not even needed...
  ## [[ `(alias; declare -f) | egrep -q "^rm\="`$? ]] and
  ## ! ((`(alias; declare -f) | egrep -q "^rm\="`$?)) equivalent:
  ## delete all aliases / return 0 if rm is safety-aliased
  ## else re-add all aliases / return 99
  local usageexample="\n"'Usage: safetytoggle [option(s)]
 Toggle or set/unset a given family of "safety" aliases (toggle by default)
The options are:
 -a - --all                Scan the entire file, not just the data section [default]
 -d --data                 Only scan the data sections in the file
 -f --print-file-name      Print the name of the file before each string
-n --bytes=[number]       Locate & print any NUL-terminated sequence of at
	 -<number>                   least [number] characters (default 4).
-t --radix={o,d,x}        Print the location of the string in base 8, 10 or 16
 -w --include-all-whitespace Include all whitespace as valid string characters
 -o                        An alias for --radix=o
 -T --target=<BFDNAME>     Specify the binary file format
 -e --encoding={s,S,b,l,B,L} Select character size and endianness:
			   s = 7-bit, S = 8-bit, {b,l} = 16-bit, {B,L} = 32-bit
@<file>                   Read options from <file>
 -h --help                 Display this information
 -V --version           Print the program'\''s version number
 -v --verbose			Verbose setting'"\n"
  local pflag=
  local sflag=
  local vflag=
  while getopts vps: name
           do
               case $name in
		v)	vflag=1;;
		p)	pflag=1;;
		s)	sflag=1; local sval="$OPTARG";;
		?)	printf '\n%s\n' "${usagedoc}"; return 2;;
               esac
           done
  if [ ! "$vflag" ]; then
       printf "Option −v specified\n"
  fi
  if [ ! "$pflag" ]; then
       printf "Option −p specified\n"
  fi
  if [ ! "$sflag" ]; then
       printf 'Option −s "%s" specified\n' "$sval"
  fi
  shift $((OPTIND−1))
  printf "Remaining arguments are: %s\n$*"
  return 255; }
}
ufs(){
	[[ -z `find /mnt -maxdepth 1 -fstype "fuse.sshfs" -print` ]] || {
	find /mnt -maxdepth 1 -fstype "fuse.sshfs" -print0 | xargs -t0 -I{} sudo umount "{}"
	return 0; }
}
sfs() {
	[[ -z `find /mnt -maxdepth 1 -fstype "fuse.sshfs" -print` ]] && { 
		sshfs "192.168.1.99:/home/alyptik" "/mnt/arch"
		sshfs "192.168.1.99:/mnt/windows" "/mnt/windows"
		sshfs "192.168.1.99:/mnt/windows/Users/Administrator/Desktop/stuff" "/mnt/winserver"
		return 0; } || { ufs; return 1; } 
} 
sfs2() {
	true || {
	sshfs -f "192.168.1.99:/home/alyptik" "/mnt/arch"
	mpid=$!
	#sshfs -f "192.168.1.99:/mnt/windows" "/mnt/winserver" &
	#mpid="$mpid ${!}"
	sshfs -f "192.168.1.99:/mnt/windows/Users/Administrator/Desktop/stuff" "/mnt/winserver"
	mpid="$mpid $!" #`ps aux | grep -o $! | grep -v grep`
	mpid="$mpid "`ps aux | grep -o $! | uniq`
	trap "kill -15 $mpid; trap - " 0 1 2 15
	wait; }
	#[[ ! -z `mount | egrep -o "\/mnt\/(arch|windows)"` ]] && { ufs; trap - ; return 1; } || {
	#	sshfs "192.168.1.99:/home/alyptik" "/mnt/arch"
	#	sshfs "192.168.1.99:/mnt/windows" "/mnt/windows"
	#	sshfs "192.168.1.99:/mnt/windows/Users/Administrator/Desktop/stuff" "/mnt/winserver"
	#	wait; return 0; }
	#find /mnt -maxdepth 1 -fstype "fuse.sshfs" -exec grep -o "{}" $(mount) \;
	#find /mnt -maxdepth 1 -fstype "fuse.sshfs" -print0 | xargs -tr0 -I{} sudo umount "{}"
	#mounted=`find /mnt -maxdepth 1 -fstype "fuse.sshfs" -exec sudo umount "{}" \; -print`
	#mpid="$mpid `ps aux | grep $! | grep -v grep`"
	#trap ' { find /mnt -maxdepth 1 -fstype "fuse.sshfs" -print0 | \
	#xargs -t0 -I{} sudo umount "{}"; 
	#ps aux | grep $mpid | grep -v grep
}

alias usctl='systemctl --user '
alias uscdr='systemctl --user daemon-reload '
alias uscen='systemctl --user enable --now '
alias uscdn='systemctl --user disable --now '
alias uscs='systemctl --user status --full --no-pager '
alias uscf='systemctl --user --failed '
alias uscu='systemctl --user list-units --full '
alias usce='systemctl --user edit --full '
alias uscr='systemctl --user restart '
alias sctl='sudo systemctl '
alias scdr='sudo systemctl daemon-reload '
alias scen='sudo systemctl enable --now '
alias scdn='sudo systemctl disable --now '
alias scs='sudo systemctl status --full --no-pager '
alias scf='sudo systemctl --failed '
alias scu='sudo systemctl list-units --full '
alias sce='sudo systemctl edit --full '
alias scr='sudo systemctl restart '

alias ls='ls --color=auto '
#alias la='ls -al --color=auto '
alias la='ls -lAhqiQFs  --color=auto '
alias lA='ls -lAhqiQFso  --color=auto '
alias lB='ls -lAhqiQFXrso  --color=auto '
alias lC='ls -lAhqiQFSrso  --color=auto '
alias lD='ls -lAhqiQFtrso  --color=auto '
alias ll='ls -CBhp --color=auto '
alias l.='ls -dCX --color=auto .* '
alias l..='ls -dCX --color=auto .*/ */ '
alias ..='cd .. '
alias ...='cd ../../ '
alias ....='cd ../../../ '
## Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto '
alias egrep='egrep --color=auto '
alias fgrep='fgrep --color=auto '
#alias bc='bc -l '
## Generate sha1 digest
alias sha1='openssl sha1 '
alias mkdir='mkdir -pv '
## install colordiff package :)
alias vcdiff='colordiff -swBW 150 '
alias hcdiff='colordiff -swByW 150 '
alias bvcdiff='colordiff -swBW 150 --suppress-blank-empty '
alias bhcdiff='colordiff -swByW 150 --suppress-blank-empty '
alias svcdiff='colordiff -swBW 150 --suppress-blank-empty --suppress-common-lines '
alias shcdiff='colordiff -swByW 150 --suppress-blank-empty --suppress-common-lines '

## Stop after sending count ECHO_REQUEST packets
alias pong='ping -c 5 '
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s1 '
alias ports='netstat -tulanp '

alias enft='sudo nano /etc/nftables.conf '
alias rnft='sudo nft -f /etc/nftables.conf '
alias lnft='sudo nft list ruleset -a '

alias start-wmin='sudo /etc/webmin/start '
alias stop-wmin='sudo /etc/webmin/stop '
alias rs-wmin='sudo /etc/webmin/restart '
alias rl-wmin='sudo /etc/webmin/reload '

alias lsinitcpio='ls -lAXh --color=auto /usr/lib/initcpio '
alias cdinitcpio='cd /usr/lib/initcpio '
alias esp-hook='sudo gvim /usr/lib/initcpio/install/esp-update-linux '
alias lrepos='curl "https://wiki.archlinux.org/index.php/Unofficial_user_repositories" | \
grep "Server = " | sed "s/\$arch/$(uname -m)/g" | cut -f 3 -d" " '
alias rorphans='sudo pacman -Rns $(pacman -Qdtq) '
alias nmwifi='sudo nmcli dev wifi connect '
alias nmdwifi='sudo nmcli dev wifi disconnect '

alias zs-gen='sudo zonesigner -genkeys -keydirectory /etc/bind/private -usensec3 \
-dsdir /etc/bind/private -krfile /etc/bind/private/alyptik.xyz.krf -nosave \
-zone alyptik.xyz /etc/bind/db.alyptik.xyz /etc/bind/db.alyptik.xyz.signed'
alias zs-sign='sudo zonesigner -dsdir /etc/bind/private -krfile /etc/bind/private/alyptik.xyz.krf \
-nosave -zone alyptik.xyz /etc/bind/db.alyptik.xyz /etc/bind/db.alyptik.xyz.signed '

alias zedit='sudo vim /etc/bind/db.alyptik.xyz'
alias bedit='sudo vim /etc/named.conf'
alias gzedit='sudo gvim /etc/bind/db.alyptik.xyz'
alias gbedit='sudo gvim /etc/named.conf'
alias arch-ssh='ssh -Y alyptik@alyptik.xyz -p 222 '
alias rarch-ssh='ssh -Y root@@alyptik.xyz -p 2222 '
alias surface-ssh='ssh -Y alyptik@192.168.1.98 '
alias rsurface-ssh='ssh -Y root@192.168.1.98 '

alias powns='sudo pacman -Qo '
alias skonq='kdesudo konqueror '
alias tdmesg='dmesg | tail '
alias jctlxe='journalctl -xe '
alias jftrimstatus='journalctl -u fstrim '
alias ftrimstatus='systemctl status fstrim.timer '

alias kzshrc='kate ${HOME}/.zshrc'
alias kbashrc='kate ${HOME}/.bashrc'
alias kprofile='kate ${HOME}/.bash_profile'
alias vzshrc='vim ${HOME}/.zshrc'
alias vbashrc='vim ${HOME}/.bashrc'
alias vprofile='vim ${HOME}/.bash_profile'
alias gzshrc='gvim ${HOME}/.zshrc'
alias gbashrc='gvim ${HOME}/.bashrc'
alias gprofile='gvim ${HOME}/.bash_profile'
alias nzshrc='nano ${HOME}/.zshrc'
alias nbashrc='nano ${HOME}/.bashrc'
alias nprofile='nano ${HOME}/.bash_profile'
alias sbashrc='source ${HOME}/.bashrc'
alias sprofile='source ${HOME}/.bash_profile'
alias szshrc='source ${HOME}/.zshrc'

# SSH shortcuts
alias nputty='putty -ssh alyptik.ddns.net -l root -pw alpha01 -fn "client:Monospace 12" '
alias nssh='ssh netgear '
alias tssh='ssh root@alyptik.ddns.net -p 443 -D 8080 '

# Pacman shortcut aliases
alias spm='sudo apacman -S --noconfirm '
alias sspm='sudo apacman -Ss '
alias sipm='sudo apacman -Si '

alias nsmb='mount.cifs //192.168.1.1/opt /tmp/mnt/smbshare -o username=$(nvram get samba_user),password=$(nvram get samba_password) '
alias lsmb='mount.cifs //192.168.1.1/opt /tmp/mnt/smbshare -o username=$(nvram get samba_user),password=$(nvram get samba_password) '

alias nrefind='sudo nano /boot/EFI/refind/refind.conf'
alias listblackarch='sudo pacman -Sgg | grep blackarch | cut -d" " -f2 | sort -u | less'
alias catblackarch='sudo pacman -Sg | grep blackarch'

#alias newvnc="sudo x11vnc -bg -auth guess -forever -shared -display :0 -autoport -6 -rfbauth /etc/x11vnc.pass -ncache 10 -ncache_cr -ssldir /home/alyptik/certs/vnc -ssl /home/alyptik/certs/vnc/server-vencrypt.pem -vencrypt support:nox509 -anontls support:nox509 -dhparams /home/alyptik/certs/vnc/dh.pem -rmflag /var/run/x11vnc.pid && sudo sed -i '2,$ d; s/^.*$/`ps wwaux | grep x11vnc | awk ' { if ($1=="root") print $2 } ' | paste -s -d ' '`/' /var/run/x11vnc.pid "
#alias newvnc='sudo x11vnc -bg -auth guess -forever -shared -display :0 -autoport -6 -rfbauth /etc/x11vnc.pass -ncache 10 -ncache_cr -ssldir /home/alyptik/certs/vnc -ssl /home/alyptik/certs/vnc/server-vencrypt.pem -vencrypt support:nox509 -anontls support:nox509 -dhparams /home/alyptik/certs/vnc/dh.pem -rmflag /var/run/x11vnc.pid '
#newvnc() { x11vnc -env FD_SDDM=1 -auth /tmp/xauth-1000-_0 -forever -shared -display :0 -autoport -6 -rfbauth /etc/x11vnc.pass -ncache 10 -ncache_cr -ssldir /home/alyptik/certs/vnc -ssl /home/alyptik/certs/vnc/server-vencrypt.pem -vencrypt support:nox509 -anontls support:nox509 -dhparams /home/alyptik/certs/vnc/dh.pem -noxdamage -noxkb -noxfixes -rmflag /tmp/x11vnc-alyptik.pid & }
alias newvnc='x11vnc -env FD_SDDM=1 -auth /tmp/xauth-1000-_0 -forever -shared -display :0 -autoport -6 -rfbauth /etc/x11vnc.pass -ncache 10 -ncache_cr -ssldir /home/alyptik/certs/vnc -ssl /home/alyptik/certs/vnc/server-vencrypt.pem -vencrypt support:nox509 -anontls support:nox509 -dhparams /home/alyptik/certs/vnc/dh.pem -noxdamage -noxkb -noxfixes -rmflag /tmp/x11vnc-alyptik.pid & '
alias sedvnc="sudo sed -i '2,$ d; s/^.*$/$(pgrep x11vnc | paste -s -d " " | awk '{ print $NF }')/' /var/run/x11vnc.pid "
alias killvnc='sudo killall x11vnc'
alias updategrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

## Shortcut  for iptables and pass it via sudo
alias ipt='sudo iptables --line-numbers -vnL'
alias iptin='sudo iptables --line-numbers -vnL INPUT '
alias iptout='sudo iptables --line-numbers -vnL OUTPUT '
alias iptfw='sudo iptables --line-numbers -vnL FORWARD '
alias iptnat='sudo iptables --line-numbers -t nat -vnL '
alias ip6t='sudo ip6tables --line-numbers -vnL '
alias ip6tin='sudo ip6tables --line-numbers -vnL INPUT '
alias ip6tout='sudo ip6tables --line-numbers -vnL OUTPUT '
alias ip6tfw='sudo ip6tables --line-numbers -vnL FORWARD '
alias ip6tnat='sudo ip6tables -t nat --line-numbers -vnL '

alias 4routes='route -A inet -e -n '
alias 4nroutes='route -A inet -e '
alias 4iproutes='ip -4 route show '
alias 6routes='route -A inet6 -e -n '
alias 6nroutes='route -A inet6 -e '
alias 6iproutes='ip -6 route show '

## pass options to free ##
alias meminfo='free -m -l -t '
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 '
alias psmem10='ps auxf | sort -nr -k 4 | head -10 '
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 '
alias pscpu10='ps auxf | sort -nr -k 3 | head -10 '
## Get server cpu info ##
alias cpuinfo='lscpu '
## older system use /proc/cpuinfo ##
alias cpuinfo='less /proc/cpuinfo '
## get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log '



