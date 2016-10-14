man keymaps
xdg-mime query default inode/directory'\

xdg-mime query default inode/directory\

v ~/.local/share/applications/FoxitReader.desktop
v /usr/share/applications/pcmanfm-qt.desktop
xdg-mime set-default
xdg-mime set-default --help
xdg-mime default pcmanfm.desktop;
cp /usr/share/applications/pcmanfm* ~/.local/share/applications/
xdg-mime query default /home/alyptik
xdg-mime query /home/alyptik
xdg-mime query filetype file:/home/alyptik
xdg-mime query filetype /home/alyptik
xdg-open file://home/alyptik
xdg-mime default pcmanfm-qt inode/directory
xdg-mime query default inode/directory
xdg-mime default pcmanfm-qt.desktop; inode/directory
v ~/.local/share/applications/mimeapps.list
google 'why does xdg-open directories in browser'
echo $XDG_CURRENT_DESKTOP
man gvfs-open
gvfs-open ~
v ~/.local/share/applications/mimeapps.list /etc/mime.types
xdg-mime default pcmanfm-qt.desktop inode/directory
_ xdg-mime default pcmanfm-qt.desktop inode/directory
gvfs-open ~/
xdg-mime query default application/x-directory
xdg-mime default pcmanfm-qt.desktop application/x-directory
xdg-open file://.home/alyptik
xdg-open file:///home/alyptik
_ xdg-mime default pcmanfm-qt.desktop application/x-directory
_ v usr/share/applications/mimeinfo.cache
_ v usr/share/applications/mimeinfo.list
_ v /usr/share/applications/mimeinfo.cache
cat cat ~/.config/mimeapps.list
cat ~/.config/mimeapps.list
v ~/.config/mimeapps.list
_ visudo
update-desktop-database /usr/share/application
_ update-desktop-database /usr/share/application
update-desktop-database
_ update-desktop-database
xdg-open /home/alyptik
mwiflex.sh
sspc tox
	find /@media/microSDXC/audio -maxdepth 1 -name "*TSL*" -type d -print | \\
		sed 's/^.*\/\(TSL.*\)$/\1/' | \\
		while read -r; do\
			rclone move "/@media/microSDXC/audio/${REPLY}" dropbox:/EDM/TSL/${REPLY} && \\
			rmdir "/@media/microSDXC/audio/${REPLY}"\
		done\
	find /@media/microSDXC/audio -maxdepth 1 -name "*alyptik*" -type d -print | \\
		sed 's/^.*\/alyptik - \(.*\)$/\1/' | \\
		while read -r; do\
			rclone lsd "dropbox:/edm/audio/$(<<<${REPLY:l} sed 's/ (.*//')" 2>/dev/null && {\
				printf '\n \033[31m %s \n\033[0m' \\
					"Directory dropbox:/edm/audio/$(<<<${REPLY/*- /} \\
					sed 's/./\l&/g;s/ (.*//') exists\
				read -rsk 1 ?"Continue? [y/n]: " cont\
				case $cont in\
					[Yy]*|'') : ;; ## Continue\
					[Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."; return 1 ;;\
					*) printf " \033[31m %s \n\033[0m" "Invalid input..."; return 1 ;;\
				esac\
			}\
			rclone move "/@media/microSDXC/audio/alyptik - ${REPLY}" \\
				"dropbox:/edm/audio/$(<<<${REPLY/*- /} \\
				sed 's/./\l&/g;s/ (.*//')" && \\
				rmdir "/@media/microSDXC/audio/alyptik - ${REPLY}"\
		done\
	find /@media/microSDXC/wanderlust -maxdepth 1 -name "*Wanderlust Ep.*" -type d -print | \\
		while read -r; do\
        		rclone move "$REPLY" \\
				'dropbox:/edm/wanderlust/'"${REPLY/*wanderlust\//}"  && \\
				rmdir "${REPLY}"\
		done\
	find /@media/microSDXC/wanderlust -maxdepth 1 -name "*alyptik*" -type d -print | \\
		sed 's/^.*\/alyptik - \(.*\)$/\1/' | \\
		while read -r; do\
			rclone lsd "dropbox:/edm/wanderlust/$(<<<${REPLY:l} sed 's/ (.*//')" 2>/dev/null && {\
			    printf '\n \033[31m %s \n\033[0m' \\
				    "Directory dropbox:/edm/wanderlust/$(<<<${REPLY/*- /} \\
				    sed 's/./\l&/g;s/ (.*//') exists\!"\
				read -rsk 1 ?"Continue? [y/n]: " cont\
				case $cont in\
					[Yy]*|'') : ;; ## Continue\
					[Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."; return 1 ;;\
					*) printf " \033[31m %s \n\033[0m" "Invalid input..."; return 1 ;;\
				esac\
			}\
			rclone move "/@media/microSDXC/wanderlust/alyptik - ${REPLY}" \\
				"dropbox:/edm/wanderlust/$(<<<${REPLY/*- /} \\
				sed 's/./\l&/g;s/ (.*//')" && \\
				rmdir "/@media/microSDXC/wanderlust/alyptik - ${REPLY}"\
		done\
	#rclone sync /@media/microSDXC/audio/ dropbox:/EDM/audio/\
	rclone sync "/@media/microSDXC/Music/djzomg/" "dropbox:/EDM/djzomg/"\
	rclone move "/@media/microSDXC/Practice Mixes/" "dropbox:/EDM/practice/"\
	#rclone move /@media/microSDXC/Practice\ Mixes/ dropbox:/EDM/practice/\

which dbr
\
        find /@media/microSDXC/audio -maxdepth 1 -name "*TSL*" -type d -print | sed 's/^.*\/\(TSL.*\)$/\1/' | while read -r\
        do\
                rclone move "/@media/microSDXC/audio/${REPLY}" dropbox:/EDM/TSL/${REPLY} && rmdir "/@media/microSDXC/audio/${REPLY}"\
        done\
        find /@media/microSDXC/audio -maxdepth 1 -name "*alyptik*" -type d -print | sed 's/^.*\/alyptik - \(.*\)$/\1/' | while read -r\
        do\
                rclone lsd "dropbox:/edm/audio/$(<<<${REPLY:l} sed 's/ (.*//')" 2> /dev/null && {\
                        printf '\n \033[31m %s \n\033[0m' "Directory dropbox:/edm/audio/$(<<<${REPLY/*- /} \\
                                        sed 's/./\l&/g;s/ (.*//') exists\
                        read -rsk 1 ?"Continue? [y/n]: " cont\
                        case $cont in\
                                ([Yy]* | '') : ;;\
                                ([Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."\
                                        return 1 ;;\
                                (*) printf " \033[31m %s \n\033[0m" "Invalid input..."\
                                        return 1 ;;\
                        esac\
                }\
                rclone move "/@media/microSDXC/audio/alyptik - ${REPLY}" "dropbox:/edm/audio/$(<<<${REPLY/*- /} \\
                                sed 's/./\l&/g;s/ (.*//')" && rmdir "/@media/microSDXC/audio/alyptik - ${REPLY}"\
        done\
        find /@media/microSDXC/wanderlust -maxdepth 1 -name "*Wanderlust Ep.*" -type d -print | while read -r\
        do\
                rclone move "$REPLY" 'dropbox:/edm/wanderlust/'"${REPLY/*wanderlust\//}" && rmdir "${REPLY}"\
        done\
        find /@media/microSDXC/wanderlust -maxdepth 1 -name "*alyptik*" -type d -print | sed 's/^.*\/alyptik - \(.*\)$/\1/' | while read -r\
        do\
                rclone lsd "dropbox:/edm/wanderlust/$(<<<${REPLY:l} sed 's/ (.*//')" 2> /dev/null && {\
                        printf '\n \033[31m %s \n\033[0m' "Directory dropbox:/edm/wanderlust/$(<<<${REPLY/*- /} \\
                                    sed 's/./\l&/g;s/ (.*//') exists\!"\
                        read -rsk 1 ?"Continue? [y/n]: " cont\
                        case $cont in\
                                ([Yy]* | '') : ;;\
                                ([Nn]*) printf " \033[31m %s \n\033[0m" "Exiting..."\
                                        return 1 ;;\
                                (*) printf " \033[31m %s \n\033[0m" "Invalid input..."\
                                        return 1 ;;\
                        esac\
                }\
                rclone move "/@media/microSDXC/wanderlust/alyptik - ${REPLY}" "dropbox:/edm/wanderlust/$(<<<${REPLY/*- /} \\
                                sed 's/./\l&/g;s/ (.*//')" && rmdir "/@media/microSDXC/wanderlust/alyptik - ${REPLY}"\
        done\
        rclone sync "/@media/microSDXC/Music/djzomg/" "dropbox:/EDM/djzomg/"\
        rclone move "/@media/microSDXC/Practice Mixes/" "dropbox:/EDM/practice/"\

v aliases.sh
la /boot/efi/EFI
la /boot/efi/EFI/grub
sbverify --list  /boot/efi/EFI/refind/PreLoader.efi
sbverify /boot/efi/EFI/refind/PreLoader.efi
sbverify --list ARCHISO_EFI/EFI/shellx64_v1.efi
sbverify -h /boot/efi/EFI/arch/grubx64.efi
sbverify --list /boot/efi/EFI/arch/grubx64.efi
sbverify /boot/efi/EFI/arch/grubx64.efi
_ cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/EFI/refind/PreLoader.efi
sbverify --list /boot/efi/EFI/arch/HashTool.efi
_ cp /boot/efi/EFI/arch/HashTool.efi /boot/efi/EFI/refind/HashTool.efi
sbverify --list /boot/efi/EFI/arch/KeyTool.efi
. ~/aliases.sh
which efiupdategrub
_ grub-mkconfig -o /boot/efi/EFI/grub/grub.cfg
pm -Qs grub
_ grub-install --efi-directory=/boot/efi --boot-directory=/boot/efi/EFI /dev/sda
la /dev/fd
la /dev/fd/
\
  ls /dev/fd/9 >/dev/null 2>&1 && {\
           exec 2>&9\
           exec 9>&-\
    }
ls /dev/fd
ls /dev/fd/
la /dev/fd/9
_ v /etc/default/grub
efiupdategrub
npc
ping alyptik.lan
man dnsmasq
_ v /etc/dnsmasq.conf
scs distccd
cd ~/sdxc
nmixx
jctlxe
systemctl status systemd-swap.service
sctl unmask dev-sda4.swap
scdn dev-sda4.swap
scs dev-sda4.swap
scrs dev-sda4.swap
</home/alyptik/.zsh_history
less /home/alyptik/.zsh_history
echo $HISTFILE
la ~/*history
man zshall
rm /home/alyptik/.bash_history
test 1
la ~/.*history
touch /store/config/.bash_history
ln -s /store/config/.bash_history ~/
ln -s /store/config/.zsh_history ~/
cat ~/.zsh_history >> /store/config/.zsh_history
google 'share zsh and bash history\
'
lgr
google 'share zsh bash history'
scrs dnsmasq
_ swapoff /dev/sda4
<~/.bash_history
cat ~/.bash_history
echo 1
nmcli c
nmcli d mlan0 connect
nmcli d connect mlan0
nmcli d disconnect mlan0
nmcli d
nmcli d h
nmcli h
nmcli
_ ip link set eth0 down
_ ip link set eth0 up
ifconfig eth0
sc-stop dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth && kpulse
sc-stop dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth; kpulse; killall compton
usctl --failed
ports
_ ports
sc-stop dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth dropbearftpd rsyncd; kpulse; killall compton
scrs  bluetooth
scs bluetooth
_ v /etc/bluetooth/main.conf
sc-stop dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth dropbear ftpd rsyncd; kpulse; killall compton
scrs dropbear
sc-stop dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth ftpd rsyncd; kpulse; killall compton
sctl --failed
scs dropbear.service
nmixxx
v /home/alyptik/.bash_history
v ~/.zsh_history
ln -f /store/config/.zsh_history ~/.zsh_history
ln -f /store/config/.zsh_history ~/.bash_history
la  /store/config/.zsh_history
bash
killall zsh
_ killall zsh
pgrep zsh
_ kill -9 $(pidof zsh)
urxvt -kuake-hotkey "F10" & disown
screen -ls
screen -x weechat
scs cronie
scen cronie
crontab -e
sed 's/: [0-9]*:[0-9]*;//' /store/config/.zsh_history
rm /store/config/.zsh_history.swp
setopt noextendedhistory
setopt noextended_history
sed -i 's/: [0-9]*:[0-9]*;//' /store/config/.zsh_history
zrc
zmodload -u zsh/datetime
v /store/config/.zsh_history
htop
man compton
sc-start dovecot.service postfix.service spamassassin.service avahi-daemon.service avahi-daemon.socket distccd tor libvirtd bluetooth ftpd rsyncd; par; compton -cCGfF -b -i 0.85 & disown
echo yes
src
_ v /etc/inputrc
la /tmp
weechat
v ~/.config/chromium-flags.conf
csox alyptik\ -\ \[Uplifting\ \&\ Vocal\ Trance\]\ Wanderlust\ Ep.038.wav ogg 10
csox alyptik\ -\ \[Uplifting\ \&\ Vocal\ Trance\]\ Wanderlust\ Ep.038.wav flac 8
kid3-qt *.mp3
v *.txt
v `which rcompose.sh `
rcompose.sh
setxkbmap -option compose:caps
xmodmap /home/alyptik/.Xmodmap
cd ~/sdxc/wanderlust/alyptik\ -\ \[Uplifting\ \&\ Vocal\ Trance\]\ Wanderlust\ Ep.038
ls ..
sspc shim
ipc aur/shim-efi
spc aur/shim-efi
sbsign --li ~/sdxc/PreLoader.efi 
sbsign --list ~/sdxc/PreLoader.efi 
sbverify  --list ~/sdxc/PreLoader.efi 
man cryptboot-efikeys 
cryptboot-efikeys 
cryptboot-efikeys -h
_ cryptboot-efikeys -h
_ cryptboot-efikeys status
_ cryptboot-efikeys create
_ cryptboot-efikeys 
_ cryptboot-efikeys enroll
_ cryptboot-efikeys enroll /boot/efikeys/PK.key 
_ cryptboot-efikeys list
pushd /boot/efi
_ sbsign --key ../efikeys/db.key --cert ../efikeys/db.crt --output EFI/refind/PreLoader.efi EFI/refind/PreLoader.efi 
_ refind-install -hEFI/refind/PreLoader.efi
rpc refind-efi 
spc refind-efi 
_ refind-install --shim EFI/refind/PreLoader.efi
_ ncdu/@efi/../
_ ncdu /@efi/../
_ ncdu /boot
la /boot/efi/EFI/refind
la /boot/efi/EFI/refind/keys
sbverify  --list EFI/refind/PreLoader.efi 
sbverify  --list EFI/refind/loader.efi 
sbverify  --list EFI/refind/HashTool.efi 
sbverify  --list /usr/share/efitools/efi/PreLoader.efi 
sspc efi
sspc prebootloader
_ v /@efi/../refind/refind.conf 
cd /usr/share/efitools
< README 
popd
cd efi
sbverify  --list ./*
sbverify  --list ./HashTool.efi ./HelloWorld.efi ./KeyTool.efi ./Loader.efi ./LockDown.efi ./PreLoader.efi ./ReadVars.efi ./SetNull.efi ./ShimReplace.efi ./UpdateVars.efi 
sbverify  --list *
sbverify  --list HashTool.efi HelloWorld.efi KeyTool.efi Loader.efi LockDown.efi PreLoader.efi ReadVars.efi SetNull.efi ShimReplace.efi UpdateVars.efi 
sbverify  --list HashTool.efi 
sbverify  --list PreLoader.efi 
ipc efitools
sbverify --list /home/alyptik/sdxc/PreLoader.efi 
sbverify  --list /boot/efi/EFI/refind/HashTool.efi 
sbverify  --list /boot/efi/EFI/refind/PreLoader.efi 
cd /usr/lib/shim/
sbverify  --list MokManager.efi 
sbverify  --list shimx64.efi 
sbverify  --list fallback.efi 
_ v /boot/refind_linux.conf
_ sed 's/cent=50/cent=20/' /boot/refind_linux.conf
TRACKLIST:
01. Reflekt ft. Delline Bass - Need To Feel Loved (Marc Van Linden Remix).
02. Bjorn Akesson - Paper Dreams (Original Mix)
03. Paul van Dyk & Alex M.O.R.P.H. ft. Ashley Tomberlin - Get Back (Giuseppe Ottaviani Remix)
04. Rene Ablaze & Jam Da Bass - Sunstream (Original Mix)
05. Jurgen Vries - The Theme (Jam X & De Leon's Dumonde Remix)\
06. Cate Kanell - Into The Light (First Effect Extended Mix)\
07. Cold Rush - Distraction (Original Mix)
_ sed -i 's/cent=50/cent=20/' /boot/refind_linux.conf
_ mkinitcpio -p linux-surfacepro3 -p linux -p linux-surfacepro3-rt -p linux && efiupdategrub
_ v /etc/systemd-swap.conf /etc/systemd-swap.conf.pacnew 
scrs systemd-swap.service
scs fcron cronie
scs ananicy.service 
scdn ananicy.service 
scen verynice
scs verynice.service
tmux
ssh -Y larch
man pinfo grub-install 
pinfo grub-install 
dbr
screen -S weechat
_ grub-mkconfig -o /boot/efi/EFI/altlinux/grub.cfg 
_ grub-install --efi-directory=/boot/efi --boot-directory=/boot/efi/EFI --uefi-loader/dev/sda
_ grub-install --efi-directory=/boot/efi --boot-directory=/boot/efi/EFI --uefi-loader /dev/sda
man grub
sspc grub eufi
sspc grub uefi
sspc grub 
spc aur/grub2-x86_64-efi-git
la /boot/efi/EFI/
la arch
cp altlinux/* arch/
_ cp altlinux/* arch/
_ mv altlinux /store/
mv arch altlinux
_ mv arch altlinux
_ ln -sf /boot/efi/EFI/altlinux /@efi
v /store/config/esp-update-linux
la altlinux
fg
efibootmgr -v
_ efibootmgr -B -b 0001
_ efibootmgr -B -b 0000
_ efibootmgr -v
cmount
blkid
_ dd bs=4M if=/home/alyptik/sdxc/OS\ ISOs/archlinux-2016.10.01-dual.iso of=/dev/sdc status=progress && sync
ipc grub-git 
la /.@efi
la /@efi
la /@efi/
spc grub-git 
sbverify  --list /@efi/shim.efi 
cd /@efi
sbverify  --list /@efi/grubx64.efi 
sbverify  --list /@efi/loader.efi 
man grub-glue-efi 
man 8 grub-set-default 
v /tmp/tmp-pacaur-1000/grub-git/
cd grub-efi-x86_64
./configure --help
cd grub-extras
..
cd grub
man grub-install 
grub-install --shim
grub-install --shim-bootlader
grub-install --
efibootmgr -hj
grub-install -v
la /boot;
la /boot/frub
la /boot/grrub
la /boot/gr\ub
.a /boot
cp /boot/efi/EFI/arch
cd /boot/efi/EFI/arch
cd /boot/efi/EFI/
l
//
cd
cd /tmp/tmp-pacaur-1000/grub-git/src/grub
cd /tmp/tmp-pacaur-1000/
cd grub2-git/grub/
fdf
man 8 grub-install 
cd /tmp/
[p[d
screen -S arch
_ cp /@efi/HashTool.efi 
cd /tmp/tmp-pacaur-1000
s
la
ls
sctl 
q
/ 
scg
la 
screen -x weechat
scg
weechat
cd /@media/ALT\ regular-rescue_x86_64
la
la EFI
cd EFI
la
la refind
la
la BOOT
la refind
sbverify --list refind/refind_x64.efi 
sbverify --list refind/drivers_x64
sbverify --list refind/drivers_x64/ext4_x64.efi 
la /boot/gr\ub
spc grub
la /boot/efi
la /boot/efi/EFI
la /boot/efi/EFI/refind
_ ncdu /boot
la
la tools
la enroll
la BOOT
v BOOT/refind.conf 
v refind
man refind-install
refind-install 
refind-install --help
_ refind-install --shim /boot/efi/EFI/altlinux/shim.efi --alldrivers 
_ ncdu /boot
_ cp refind/refind_x64.efi /boot/efi/EFI/refind/grubx64.efi 
efibootmgr -v
_ umount /dev/sdc1 
..
_ umount /dev/sdc1 
cd /@efi
la
_ ln -sf /boot/efi/EFI /@efi
_ rm /@efi 
_ ln -sf /boot/efi/EFI /@efi
sbverify --list /boot/efi/EFI/refind/shim.efi 
sbverify --list /boot/efi/EFI/grub/shim.efi 
sbverify --list /boot/efi/EFI/altlinux/grubx64.efi 
sbverify --list /boot/efi/EFI/altlinux/shim.efi 
aw 'zsh'
v ~/.gitconfig 
git credential fill
v ~/.gitconfig 
git send-email 
git send-email --cc=kinchahoy@gmail.com grub.cfg 
qpc alsa-utils
qpc alsa-utils | ptpb
mv ~/.gitconfig /store/config/
ln -s /store/config/.gitconfig ~/
qpc alsa-utils | less
npc
tmux
bash
sspc chromium
v /store/config/.zsh_history 
v /etc/systemd/journald.conf
