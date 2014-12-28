/usr/bin/start-pulseaudio-x11 &
sysctl kernel.sysrq=1 &
# xbindkeys &
xrdb -load ~/.Xresources &
xset -b &
sxhkd &
feh --bg-scale ~/.config/wallpaper/ArchLines.png &
/home/byron/.config/bspwm/panel/panel &
xss-lock -- xscreensaver-command --lock &
xscreensaver -no-splash &
#exec bspwm -c ~/.config/bspwm/bspwmrc
exec bspwm
