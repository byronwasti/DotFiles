#/usr/bin/start-pulseaudio-x11 &
sysctl kernel.sysrq=1 &
xrdb -load ~/.Xresources &
if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi
xset -b & # Turn off the beep

feh --bg-scale ~/.config/wallpaper/logs.jpg &
#feh --bg-scale ~/.config/wallpaper/mountain.png &
#feh --bg-scale --randomize ~/.config/wallpaper/* &
#feh --bg-scale ~/.config/wallpaper/blue_guitar.png
#feh --bg-scale ~/.config/wallpaper/rocket.jpg
xset s 0
xss-lock slock &
#xscreensaver -no-splash &
#
xsetroot -cursor_name left_ptr &

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

#exec bspwm -c ~/.config/bspwm/bspwmrc
#/home/byron/.config/bspwm/panel/panel &
sxhkd -f 50 &
exec bspwm
