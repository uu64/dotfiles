#!/usr/bin/env bats

@test ".zshrc is present" {
  run ls ~/.zshrc
  [ "${status}" -eq 0 ]
}

@test ".zshenv is present" {
  run ls ~/.zshenv
  [ "${status}" -eq 0 ]
}

@test ".vimrc is present" {
  run ls ~/.vimrc
  [ "${status}" -eq 0 ]
}

@test ".tmux.conf is present" {
  run ls ~/.tmux.conf
  [ "${status}" -eq 0 ]
}
