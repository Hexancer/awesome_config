#!/usr/bin/bash

## run (only once) processes which spawn with the same name
# function run {
#   users=($(ps -ef | grep $1 | grep -v grep | awk '{print $1}' | sort | uniq))
#   if ( command -v $1 ) && [[ ! " ${users[@]} " =~ " ${USER} " ]]; then
#     echo "Running $1"
#     $@ >/tmp/aaa >>/tmp/aaa &
#   fi
# }
function run {
	if (command -v $1 && ! pgrep -x $1); then
		$@ &
	fi
}

## run (only once) processes which spawn with different name
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
	gnome-keyring-daemon --daemonize --login &
fi

#if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
#	start-pulseaudio-x11 &
#fi

if (command -v /usr/lib/polkit-kde-authentication-agent-1 && ! pgrep polkit-kde-auth) ; then
        /usr/lib/polkit-kde-authentication-agent-1 & fi
# if (command -v /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 && ! pgrep polkit-gnome-au) ; then
#     /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & fi
#if (command -v  xfce4-power-manager && ! pgrep xfce4-power-man) ; then
#    xfce4-power-manager &
#fi

#run xfsettingsd
#run pulseaudio -D
# run light-locker
# run xcape -e 'Super_L=Super_L|Control_L|Escape'
#run thunar --daemon
#run pa-applet
# run pamac-tray

## The following are not included in minimal edition by default
## but autorun.sh will pick them up if you install them

# if (command -v system-config-printer-applet && ! pgrep applet.py ); then
#   system-config-printer-applet &
# fi

#run compton --shadow-exclude '!focused'
#run blueman-applet
#run msm_notifier

run snixembed --fork
# run sogou-qimpanel
# run enpass
# run kdeconnect-indicator
# run indicator-stickynotes
run nm-applet
run clipit
run safeeyes
run fcitx5
#run xiccd
#run /opt/clashforwindows/cfw
run clash-verge

# run evolution
#run xautolock -time 20 -locker '/home/pc/.bin/lockscreen'
#run qbittorrent
# run picom
