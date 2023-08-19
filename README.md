# dotfiles

## Prerequisites

- git
- zsh
- [aqua](https://aquaproj.github.io/)
- [chezmoi](https://www.chezmoi.io/)
- [HackGen](https://github.com/yuru7/HackGen)

## Setup

### shell

- setup authentication to github

- deploy dotfiles
	```
	$  chezmoi init --apply uu64

	```

- install tools
	```
	$ aqua i -a
	```

### vim

- install [vim-plug](https://github.com/junegunn/vim-plug)

- call `:PlugInstall` on vim

### linux desktop

TODO