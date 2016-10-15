#!/bin/sh

## Set Caps Lock as Compose Key
#setxkbmap -option compose:caps

## Analog stereo card
SOUND_CARD_PCI_ID=00:1b.0
## HDMI
#SOUND_CARD_PCI_ID=00:03.0
sudo setpci -v -d *:* latency_timer=b0
sudo setpci -v -s "$SOUND_CARD_PCI_ID" latency_timer=ff
## eg. SOUND_CARD_PCI_ID=03:00.0 (use `lspci | grep -i audio)

printf '%b' "performance\nperformance\nperformance\nperformance" | \
	sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor; echo
printf '%s' "2048" | sudo tee /sys/class/rtc/rtc0/max_user_freq; echo
printf '%s' "2048" | sudo tee  /proc/sys/dev/hpet/max-user-freq; echo
#dd <<<"2048" of='/sys/class/rtc/rtc0/max_user_freq'
#dd <<<"2048" of='/proc/sys/dev/hpet/max-user-freq'

#SOUND_CARD_PCI_ID=00:03.0 ## HDMI card
#printf '%s' "2048" | sudo tee '/sys/class/rtc/rtc0/max_user_freq' '/proc/sys/dev/hpet/max-user-freq' > /dev/nullSOUND_CARD_PCI_IDSOUND_CARD_PCI_IDSOUNDSOUND_CARD_PCI_IDSOUND_CARD_PCI_ID_CARD_PCI_ID
#sudo su -c 'echo 2048 > /sys/class/rtc/rtc0/max_user_freq'
#sudo su -c 'echo 2048 > /proc/sys/dev/hpet/max-user-freq'
#cat '/sys/class/rtc/rtc0/max_user_freq' '/proc/sys/dev/hpet/max-user-freq'

