# cursor handling for vi-mode
function zle-keymap-select zle-line-init zle-line-finish {
  case $KEYMAP in
    vicmd)         echo -ne '\e[1 q';;
    viins|main)    echo -ne '\e[5 q';;
  esac

  zle reset-prompt
  zle -R
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# vim keys
bindkey -v
export KEYTIMEOUT=1

# bindings
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^r' history-incremental-search-backward
bindkey '^f' history-incremental-search-forward
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# auto completion
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
# make auto completion case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# options
setopt AUTO_CD
setopt ALWAYS_TO_END
setopt COMPLETE_ALIASES
# setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt RM_STARSILENT
setopt HIST_IGNORE_ALL_DUPS
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY_TIME

# prompt
# export PS1="[%m@%1~]$ "
export PS1="[%1~]$ "
export PYTHONSTARTUP=$HOME/.pythonrc
export PYTHON_HISTORY_FILE=$HOME/.python_history

# aliases
alias ls="ls --color"
alias grep="grep --color=auto"
alias o="open.sh"
alias v="vim"
alias pi="sudo pacman -S --noconfirm"
alias pq="pacman -Ss"
alias history='history 1'
alias l="ls"
alias youtube-mp3='youtube-dl --ignore-errors --extract-audio --audio-format mp3'
alias gs="git status"
alias gc="git commit -a -m"
alias gp="git push"
alias p="pwd"
alias m="mpv --keep-open"
alias vi="echo viewing images && find . -type f -exec file --mime {} \; | grep 'image/' | cut -d ':' -f1 | xargs -d '\n' sxiv -a"
alias vv="echo viewing videos && find . -type f -exec file --mime {} \; | grep 'video/' | cut -d ':' -f1 | xargs -d'\n' -n1 mpv --keep-open"
alias tor_new_ip="echo -e 'AUTHENTICATE ""\r\nsignal NEWNYM\r\nQUIT' | nc 127.0.0.1 9051"

ffwm() {
    mime="$1"
    find -type f -exec file --mime {} \; | grep "$mime"
}
vir() {
    find -type f | grep -o 'e[0-9]\+\(_\|$\)' | tr -d 'e' | tr -d '_' | sort -nr | while read number; do echo num: $number; find . -name "image${number}_*" -exec open.sh {} \;; done
}
viR() {
    find -type f | shuf | while read image; do echo viewing $image; open.sh "$image"; done
}
oa() {
    trap "exit" 2
    for file in $(ls --color=no); do
        echo $file 
        open.sh $file || return;
    done
}

cmp_image() {
    convert "$1" "$2" -compose Difference -composite \
        -colorspace gray -format '%[fx:mean*100]' info:
}

# functions
c() {
    cd $@; ls
}

math() { awk "BEGIN {print ${@:1}}"; }

# command history
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.history

IFS='
'
