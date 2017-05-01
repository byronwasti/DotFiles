xrdb -load ~/.Xresources_raven &
xss-lock slock &
xsetroot -cursor_name left_ptr &
xset -b &  % Turn off Beep
sh ~/.fehbg &
compton -r 0 -b --xrender-sync --xrender-sync-fence &
exec xmonad
#exec i3
