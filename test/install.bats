#!/usr/bin/env bats

@test "Login shell is zsh" {
  run grep -E "^$(whoami):" /etc/passwd | cut -d ":" -f 7 | xargs basename
  # The default shell on macOS is zsh
  [ "$(uname)" = "Darwin" ] || [ "${output}" = "zsh" ]
}