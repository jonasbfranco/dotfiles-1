#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -d ${HOME}/bin ] && export PATH=$PATH:$HOME/bin
[ -d ${HOME}/apps ] && export PATH=${PATH}:${HOME}/apps
[ -d ${HOME}/.npm/bin ] && export PATH=${PATH}:${HOME}/.npm/bin

[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services" ] && mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services"

dbus-update-activation-environment --systemd DISPLAY

# Vars
export DESKTOP_SESSION=i3
export TERMINAL=termite
export EDITOR=nano
export BROWSER=firefox
export COMPOSER_HOME=${HOME}/.composer

# iBus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

ibus-daemon -drx &

#session=${1:-i3}
session=${1:-xfce}

case $session in
	xfce|xfce4)
		#ln -sfT "/usr/share/dbus-1/services/org.freedesktop.Notifications.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		ln -sfT "/usr/share/dbus-1/services/org.xfce.xfce4-notifyd.Notifications.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec startxfce4
	;;
	bspwm)
		ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec bspwm
	;;
	i3|i3wm)
		wal -R -g
		ln -sfT "/usr/share/dbus-1/services/org.knopwob.dunst.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec i3
	;;
	mate)
        ln -sfT "/usr/share/dbus-1/services/org.freedesktop.Notifications.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
        exec mate-session
    ;;
    cinnamon|cinnamon-session)
		ln -sfT "/usr/share/dbus-1/services/org.freedesktop.Notifications.service" "${XDG_DATA_HOME:-$HOME/.local/share}/dbus-1/services/org.freedesktop.Notifications.service"
		exec cinnamon-session
	;;
	*)
		exec $1
	;;
esac

