# dotfiles

![macos](https://github.com/uu64/dotfiles/workflows/macos/badge.svg)
![ubuntu](https://github.com/uu64/dotfiles/workflows/ubuntu/badge.svg)

uu64's dotfiles.

## Prerequisites

This repository runs on macOS or ubuntu and depends on the following.

- git
- make
- Python 3.x
- aptitude (Ubuntu)
- python3-apt (Ubuntu)
- brew (MacOS)

## How to use

1. Install this repo's dependencies.
  ```sh
  $ pip install -r requirements.txt
  ```

2. Install zsh, dev tools and fonts. (Includes running `chsh`)
  ```
  $ make install
  ```

3. Create dotfiles symbolic links to your home directory.
  ```
  $ make deploy
  ```

## Local development

Run tests with [bats](https://github.com/sstephenson/bats).
```
$ make test
```

Run lint with ansible-lint and shellcheck.
```
$ make lint
```

Run all commands (`make install`, `make deploy`, `make test`, `make lint`) locally in Docker.
(like github actions)
```
$ make docker-build
$ make docker-test
```

## TODO

- install pynvim
