#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Git Stuff
source /usr/share/git/completion/git-prompt.sh
PS1='[\u \W]$(__git_ps1 "(%s)") '

# Nice 'nd pretty
alias ls='ls --color=auto'

# Everything is Vim now
export EDITOR=vim

# ALIASES
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Functions
function RESTART_INTERNET {
    systemctl restart netctl-auto@wlp58s0
}

function fsize {
    printf '\33]50;%s\007' "xft:Source\ Code\ Pro\ Medium:pixelsize=${1}:antialias=true:hinting=true"
}

function HDMI_on {
    xrandr --output DP1 --left-of eDP1
}

function HDMI_off {
    xrandr --output DP1 --off
}

function SLEEP_ON {
    xset s on && xset +dpms
}

function SLEEP_OFF {
    xset -dpms && xset s off
}

function WATCH_VIM {
    while true; do inotifywait -q --event move_self --format '%w' $1; done
}

