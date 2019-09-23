#!/bin/bash

# shellcheck disable=SC1091
source ./common.sh

usage() {
    echo "${0} [--zsh]"
    echo "  no_option  install all"
    echo "  --zsh      install zsh, zplug"
    echo "  --ruby     install rbenv"
    echo "  --node     install nvm"
    echo "  --vim      install vim, nvim, dein.vim"
    echo "  --help     show this help"
}

brew_install() {
    brew install "$@"
}

install() {
    case "$(get_platforms)" in
        "Mac" )
            brew_install "$@"
            ;;
        "Linux" )
            # TODO: Linuxでの処理
            ;;
    esac
}

install_zsh() {
    echo "Install zsh, zplug ... "
    install zsh
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    print_green "OK"
}

install_rbenv() {
    echo "Install rbenv ... "
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    cd ~/.rbenv && src/configure && make -C src
    mkdir -p "$("$HOME"/.rbenv/bin/rbenv root)"/plugins
    git clone https://github.com/rbenv/ruby-build.git "$("$HOME"/.rbenv/bin/rbenv root)"/plugins/ruby-build
    print_green "OK"
}

install_node() {
    echo "Install nvm ... "
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    print_green "OK"
}

install_vim() {
    echo "Install vim, nvim, dein.vim ... "
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
    sh ./installer.sh ~/.cache/dein
    install vim nvim
    print_green "OK"
}


if ! type "curl" > /dev/null 2>&1; then
    print_red "curl is not found."
    exit 1
fi

if [[ $# -eq 0 ]]; then
    flag_zsh=true
    flag_rbenv=true
    flag_node=true
    flag_vim=true
else
    flag_zsh=false
    flag_rbenv=false
    flag_node=false
    flag_vim=false
    for arg in "$@"; do
        case "${arg}" in
            --help)
                usage
                exit 0
                ;;
            --zsh)
                flag_zsh=true
                ;;
            --ruby)
                flag_rbenv=true
                ;;
            --node)
                flag_node=true
                ;;
            --vim)
                flag_vim=true
                ;;
            *)
                usage
                exit 1
                ;;
        esac
    done
fi

if ${flag_zsh}; then
    install_zsh
fi

if ${flag_rbenv}; then
    install_rbenv
fi

if ${flag_node}; then
    install_node
fi

if ${flag_vim}; then
    install_vim
fi