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
zstyle ':completion:*:default' menu select=2
bindkey "^[[Z" reverse-menu-complete


# sindresorhus/pure
PURE_PROMPT_SYMBOL='$'


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
function select-history() {
  BUFFER=$(history -n -r 1 | fzf)
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history


# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# rbenv
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi


# awscli
complete -C "$(which aws_completer)" aws


# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# my command
# export PATH=$PATH:$HOME/mycmd
export PATH=$PATH$(find $HOME/mycmd -type d | xargs -I % echo -n :%)


# alias
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -l'
# alias ls='ls -h --color=always'
# alias grep='grep --color=always'
alias diff='diff -u --color'
alias less='less -R'

alias vi='nvim'
alias nvi='nvim'
alias vimdiff='nvim -d'

alias apb='ansible-playbook'
