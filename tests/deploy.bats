#!/usr/bin/env bats

@test ".zshrc is present" {
  run bash -c "ls ~/.zshrc"
  [ "${status}" -eq 0 ]
}

@test ".zshenv is present" {
  run bash -c "ls ~/.zshenv"
  [ "${status}" -eq 0 ]
}

@test ".vimrc is present" {
  run bash -c "ls ~/.vimrc"
  [ "${status}" -eq 0 ]
}

@test ".tmux.conf is present" {
  run bash -c "ls ~/.tmux.conf"
  [ "${status}" -eq 0 ]
}
