#!/usr/bin/env bats

# roles/zsh
@test "Login shell is zsh" {
  run bash -c "grep -E ^$(whoami): /etc/passwd | cut -d : -f 7 | xargs basename"
  # The default shell on macOS is zsh
  [ "$(uname)" = "Darwin" ] || [ "${output}" = "zsh" ]
}

@test "zplug is installed" {
  run zsh -c "source ~/.zplug/init.zsh && zplug --version"
  [[ "${output}" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

# roles/vim
@test "neovim is installed" {
  run nvim --version
  [ "${status}" -eq 0 ]
}

# roles/tools
@test "pyenv is installed" {
  export PYENV_ROOT="$HOME/.pyenv"
  # shellcheck disable=SC2030
  export PATH="$PYENV_ROOT/bin:$PATH"
  run bash -c "eval $(pyenv init -) && pyenv --version"
  [[ "${output}" =~ pyenv\ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

@test "rbenv is installed" {
  # shellcheck disable=SC2031
  export PATH="$HOME/.rbenv/bin:$PATH"
  run bash -c "eval $(rbenv init -) && rbenv --version"
  [[ "${output}" =~ rbenv\ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

@test "nvm is installed" {
  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  export NVM_DIR
  run bash -c "source $NVM_DIR/nvm.sh && nvm --version"
  [[ "${output}" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

@test "shellcheck is installed" {
  run which shellcheck
  [[ "${status}" -eq 0 ]]
}

@test "tmux is installed" {
  run which tmux
  [[ "${status}" -eq 0 ]]
}

# roles/fonts
@test "HackGen is installed" {
  if [ "$(uname)" = "Linux" ]
  then
    run bash -c "fc-list | grep HackGen -c"
    # 16 fonts are istalled
    [ "${output}" = "16" ]
  elif [ "$(uname)" = "Darwin" ]
  then
    run bash -c "brew list --cask | grep font-hackgen-nerd -c"
    [ "${output}" = "1" ]
  else
    return 1
  fi
}
