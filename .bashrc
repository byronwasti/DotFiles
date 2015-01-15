#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for (( i=1; i<=$LINES; i++)); do echo; done; clear

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

say() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }

talk() { local words="$*"; echo ${words} | festival --tts &> /dev/null ;  }

alias OlinFiles='sudo mount //fsvs01/public /mnt/public -o user=bwasti,workgroup=olin.edu,uid=byron && sudo mount //fsvs01/sandbox /mnt/sandbox -o user=bwasti,workgroup=olin.edu,uid=byron'

alias nighttime='redshift -l 40.7127:74.0059'

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear #for background artifacting
fi
