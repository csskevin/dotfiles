#################
# Configuration #
#################
export LC_ALL=C


export OPENER='nvim'
export EDITOR='nvim'
setopt PROMPT_SUBST
export TERM="xterm-256color"
export TERM_PROGRAM="foot"
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

USER_COLOR=$( cat /etc/os-release | grep arch > /dev/null && echo "yellow" || echo "green")
export PROMPT="[%F{$USER_COLOR}$USER@%M%F{white} %(3~|../%2~|%~)/]$%f "


#######################
# Man Page Completion #
#######################
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select
zstyle ':completion:*' menu select
zstyle ':completion:*'  		use-cache on
zstyle ':completion:*'			cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
autoload -U compinit; compinit
autoload -U add-zsh-hook

###########
# History #
###########
# Number of history commands that are loaded into memory
export HISTSIZE=100000
# Number of commands stored in the history file
export SAVEHIST=100000000
# Path/location of the history file
export HISTFILE=~/.zsh_history
# Immediate to history
setopt INC_APPEND_HISTORY

################
# File manager #
################

# Ctrl-O for lf
# function lfcd () {
#   cd "$(command lf -print-last-dir "$@")"
#   zle reset-prompt
# }
# zle -N lfcd


# lf icons
# source ~/.config/lf/icons

#################
# Trim Newlines #
#################

bracketed-paste() {
  zle .$WIDGET && LBUFFER=${LBUFFER%$'\n'}
}
zle -N bracketed-paste

zshaddhistory() {
   setopt LOCAL_OPTIONS
   setopt EXTENDED_GLOB
   print -sr -- "${1%%$'\n'##}"
   fc -p "$HISTFILE"
   return 1
}

#########
# Title #
#########

function preexec {
    print -Pn "\e]0;${(q)1}\e\\"
}

#######
# Vim #
#######

# Edit line in vim with ctrl-e:
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line

################
# Environments #
################

[ -f "$HOME/.env/misc.env" ] && source "/$HOME/.env/misc.env"
[ -f "$HOME/.env/basket.env" ] && source "/$HOME/.env/basket.env"
[ -f "$HOME/.env/glacier.env" ] && source "/$HOME/.env/glacier.env"; source "$HOME/.env/glacier-default.env"

###########
# Aliases #
###########

[ -f "$HOME/.aliases" ] && source "/$HOME/.aliases"

###################
# Scrollable less #
###################

export LESS='-R --mouse --wheel-lines=3'

###################
# Foot Spawn Term #
###################

function osc7-pwd() {
    emulate -L zsh # also sets localoptions for us
    setopt extendedglob
    local LC_ALL=C
    printf '\e]7;file://%s%s\e\' $HOST ${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}
}

function chpwd-osc7-pwd() {
    (( ZSH_SUBSHELL )) || osc7-pwd
}
add-zsh-hook -Uz chpwd chpwd-osc7-pwd

###########
# Plugins #
###########

[[ -f "/usr/share/fzf/key-bindings.zsh" ]] && source /usr/share/fzf/key-bindings.zsh

#############################################
# Don't override my bindkeys please section #
#############################################

# Plugins loaded before override keybinds/configs
# so I load them the lst


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

zle -N yazi y


bindkey '^o' yazi
# Ctrl+e edit command line in vim
bindkey '^e' edit-command-line
zle -N clear
# Ctrl+l clear line in vim
bindkey '^x' clear
bindkey -v

# Ctrl+j/k for going back in the history
bindkey '^j' history-search-forward
bindkey '^k' history-search-backward

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey '^[[Z' reverse-menu-complete

# Enviroment variablesk
[[ -f ~/.profile ]] && source ~/.profile

[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
alias in="source /usr/share/nvm/nvm.sh"

[[ -f /etc/profile.d/google-cloud-cli.sh ]] && source /etc/profile.d/google-cloud-cli.sh

export PATH=$PATH:$HOME/.local/bin/:$HOME/Documents/studies/master/2025_masterproject_saiger/code/build/
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org/"


export LESS_TERMCAP_mb=$(tput bold; tput setaf 2) # green
export LESS_TERMCAP_md=$(tput bold; tput setaf 6) # cyan
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)
export GROFF_NO_SGR=1         # For Konsole and Gnome-terminal

export TMPL=~/Documents/losfuzzys/LosTemplates/
export VIBE=~/Documents/losfuzzys/fuzzyland-challenges/vibe/

export ANDROID_SDK_ROOT=/opt/android-sdk/
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/36.1.0

# export BXSHARE=~/pkgs/bochs-2.7/dist/usr/local/share/bochs/
# export PATH=~/pkgs/bochs-2.7/dist/usr/local/bin/:$PATH
