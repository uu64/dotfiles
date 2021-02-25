#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|

# init
source ~/.zplug/init.zsh


# zplug
zplug "b4b4r07/enhancd", use:init.sh
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "mafredri/zsh-async", from:github
zplug "plugins/git", from:oh-my-zsh
zplug "sindresorhus/pure, use:pure.zsh," from:github, as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load


# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt nonomatch


# complement
autoload -U compinit && compinit
autoload bashcompinit && bashcompinit
zmodload zsh/complist
zstyle ':completion:*:default' menu select=2
bindkey "^[[Z" reverse-menu-complete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char


# sindresorhus/pure
if [ -n "${SSH_CONNECTION}" ];
then
  PURE_PROMPT_SYMBOL='$'
fi


# zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^N' history-substring-search-down


# b4b4r07/enhancd
export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_HOME=1
export ENHANCD_DOT_ARG=...
export ENHANCD_HYPHEN_NUM=100


# junegunn/fzf-bin
export FZF_DEFAULT_OPTS="--exact --layout reverse --no-sort"

function search_history() {
  BUFFER=$(history -n -r 1 | fzf)
  CURSOR=$#BUFFER
}

function search_file() {
  BUFFER="$(ag -g "" | fzf --preview "bat --style=numbers --color=always --line-range :500 {}")"
  if [ -n "$BUFFER" ];
  then
    BUFFER="vi $BUFFER"
    zle accept-line
  fi
}

function search_ghq() {
  BUFFER="$(ghq list -p | fzf)"
  if [ -n "$BUFFER" ];
  then
    BUFFER="cd $BUFFER"
    zle accept-line
  fi
}

zle -N search_history
bindkey '^r' search_history

zle -N search_file
bindkey '^o' search_file

zle -N search_ghq
bindkey '^[' search_ghq


# awscli
complete -C "$(which aws_completer)" aws


# alias
alias la='ls -A'
alias ll='ls -l'

alias less='bat'
alias diff='diff -u'

alias cgrep='grep --color=always'

alias vi='nvim'
alias vimdiff='nvim -d'

alias apb='ansible-playbook'

case "${OSTYPE}" in
  darwin*)
    alias ls='ls -hF -G'
    alias cdiff='colordiff -u'
  ;;
  linux*)
    alias bat='batcat'
    alias ls='ls -hF --color=always'
    alias cdiff='diff -u --color'
  ;;
esac
