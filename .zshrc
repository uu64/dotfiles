#            _
#    _______| |__  _ __ ___
#   |_  / __| '_ \| '__/ __|
#  _ / /\__ \ | | | | | (__
# (_)___|___/_| |_|_|  \___|


# init
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# zinit
zinit light-mode for \
    sindresorhus/pure \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit wait lucid blockf light-mode for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/fast-syntax-highlighting \
    atload"async_init" mafredri/zsh-async \
    from"gh-r" sbin"fzf" junegunn/fzf-bin \
    pick"init.sh" b4b4r07/enhancd

zinit snippet OMZP::git


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
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zmodload zsh/complist
zstyle ':completion:*' menu select=2


# junegunn/fzf-bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--exact --layout reverse --no-sort"


function search_history() {
  BUFFER=$(history -n -r 1 | fzf)
  CURSOR=$#BUFFER
}

function search_ghq() {
  BUFFER="$(ghq list -p | fzf)"
  if [ -n "$BUFFER" ];
  then
    BUFFER="cd $BUFFER"
    zle accept-line
  fi
}

# fb - checkout git branch
fb() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | sed "s/\* //" | awk '{print $1}')
}

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch -vv --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/\* //" | awk '{print $1}' | sed "s#remotes/[^/]*/##")
}


# bindkeys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey "^[[Z" reverse-menu-complete

# zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^P' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^N' history-substring-search-down

# search
zle -N search_history
zle -N search_ghq
bindkey '^R' search_history
bindkey '^[' search_ghq


# b4b4r07/enhancd
export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_HOME=1
export ENHANCD_DOT_ARG=...
export ENHANCD_HYPHEN_NUM=100


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

