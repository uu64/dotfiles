#!/bin/bash

print_green() {
    case "$(get_platforms)" in
        "Mac" )
            printf "\e[32m%s\e[0m\n" "${1}"
            ;;
        "Linux" )
            # TODO: Linuxでの処理
            ;;
    esac
}

print_red() {
    case "$(get_platforms)" in
        "Mac" )
            printf "\e[31m%s\e[0m\n" "${1}"
            ;;
        "Linux" )
            # TODO: Linuxでの処理
            ;;
    esac
}

get_platforms(){
    if [ "$(uname)" = "Darwin" ]; then
        echo "Mac"
    else
        echo "Linux"
    fi
}