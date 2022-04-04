#            _
#    _______| |__   ___ _ ____   __
#   |_  / __| '_ \ / _ \ '_ \ \ / /
#  _ / /\__ \ | | |  __/ | | \ V /
# (_)___|___/_| |_|\___|_| |_|\_/


# prevent duplicate values in PATH
typeset -U PATH path


# disable zsh path_helper
if [ "$(uname)" = "Darwin" ]; then
  unsetopt GLOBAL_RCS
  export PATH="$PATH:/usr/local/bin"
fi


# dotfiles home directory
export XDG_CONFIG_HOME=~/.config
export DOTFILES_HOME="${XDG_CONFIG_HOME}/dotfiles"


# custom configuration
source "${DOTFILES_HOME}/zsh-custom-conf.zsh"
