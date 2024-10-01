CPUS = $(shell nproc --all || echo 4)
FROMHOME = home/user
OS = $(shell uname -s | tr '[:upper:]' '[:lower:]')
PACKAGES = autojump awk base-devel git fzf neovim neovim-vim-compat ripgrep rsync tmux xxd-standalone zsh

.DEFAULT_GOAL := help

.NOTPARALLEL:

help: ## Print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: install config ## Install packages and copy confir files to $HOME

install: sudo install_archlinux ## Install packages

config: submodules dotfiles symlinks ## Fetch submodules and copy config files

sudo: ## Check for sudo command
	@sudo echo 'Sudo available!' \
	|| echo "ALERT! sudo not available! You must install the following packages manually: $(PACKAGES)"

install_archlinux: ## Install packages in Arch Linux
	@command -v pacman > /dev/null \
	&& sudo pacman -Sy --needed --noconfirm $(PACKAGES) \
	|| echo "OPS! This is no Arch Linux, you'll have to install these manually: $(PACKAGES)" \
	&& echo "Note that other distros are not supported and some configs may not work, use at your own risk."

dotfiles: ## Copy config files (a.k.a. dot files) to $HOME
	rsync -amv --cvs-exclude $(FROMHOME)/ $(HOME)

symlinks: ## Create os-specific symlinks
	(cd ~/.config; rm -f os-config; ln -sfv "$(OS)-config" os-config)

submodules: ## Init and fetch git submodules
	git submodule update --init --depth=1 --jobs=$(CPUS)

submodules_update: ## Update git submodules
	git submodule update --init --remote --depth=1 --jobs=$(CPUS)

submodules_deinit: ## Deinit git submodules
	git submodule deinit --all --force
