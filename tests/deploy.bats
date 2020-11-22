#!/usr/bin/env bats

@test ".zshrc is present" {
  run ls ~/.zshrc
  [ "${status}" -eq 0 ]
}

@test ".zshenv is present" {
  run ls ~/.zshenv
  [ "${status}" -eq 0 ]
}

# @test ".vimrc is present" {
#   run ls ~/.vimrc
#   [ "${status}" -eq 0 ]
# }

@test ".init.vim is present" {
  run ls ~/.config/nvim/init.vim
  [ "${status}" -eq 0 ]
}

@test ".tmux.conf is present" {
  run ls ~/.tmux.conf
  [ "${status}" -eq 0 ]
}

@test ".zsh-custom-conf.zsh is present" {
  run ls ~/.config/dotfiles/zsh-custom-conf.zsh
  [ "${status}" -eq 0 ]
}
