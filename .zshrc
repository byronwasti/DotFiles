# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
bindkey -v '^?' backward-delete-char
#bindkey "^R" history-incremental-search-backward
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/byron/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
PROMPT="[%n %1~]\$vcs_info_msg_0_ "
zstyle ':vcs_info:git:*' formats '(%b)'


alias vim='nvim'
alias ls='ls --color=auto'
alias rm='rm -I'
export EDITOR=nvim
export HISTCONTROL=ignoreboth:erasedups
# export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude target'
export PATH=$PATH:~/.cargo/bin

# SSH Agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi
clear

# Separate Yay from Pacman
alias yay='yay --aur'
