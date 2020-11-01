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

# roles/tools
@test "pyenv is installed" {
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  run bash -c "eval $(pyenv init -) && pyenv --version"
  [[ "${output}" =~ pyenv\ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

@test "rbenv is installed" {
  export PATH="$HOME/.rbenv/bin:$PATH"
  run bash -c "eval $(rbenv init -) && rbenv --version"
  [[ "${output}" =~ rbenv\ [0-9]+\.[0-9]+\.[0-9]+ ]]
}

@test "nvm is installed" {
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  run bash -c "source $NVM_DIR/nvm.sh && nvm --version"
  [[ "${output}" =~ [0-9]+\.[0-9]+\.[0-9]+ ]]
}
