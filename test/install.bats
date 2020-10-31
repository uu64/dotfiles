#!/usr/bin/env bats

@test "Login shell is zsh" {
  run bash -c "grep -E ^$(whoami): /etc/passwd | cut -d : -f 7 | xargs basename"
  # The default shell on macOS is zsh
  [ "$(uname)" = "Darwin" ] || [ "${output}" = "zsh" ]
}

@test "zplug is installed" {
  run zsh -c "source ~/.zplug/init.zsh && zplug --version"
  [ "${status}" -eq 0 ]
}