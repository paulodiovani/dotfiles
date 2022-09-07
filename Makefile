FROMHOME = home/user
PACKAGES = awk base-devel git fzf neovim ripgrep rsync tmux zsh

# .PHONY: all

.NOTPARALLEL:

all: install config

install: sudo install_archlinux

config: dotfiles submodules

sudo:
	@sudo echo 'Sudo available!' \
	|| echo "ALERT! sudo not available! You must install the following packages manually: $(PACKAGES)"

install_archlinux:
	@command -v pacman > /dev/null \
	&& sudo pacman -Sy --noconfirm $(PACKAGES) \
	|| echo "OPS! This is no Arch Linux, you'll have to install these manually: $(PACKAGES)" \
	&& echo "Note that other distros are not supported and some configs may not work, use at your own risk."

dotfiles:
	rsync -amv --cvs-exclude $(FROMHOME)/ $(HOME)

submodules:
	git submodule update --init --depth=1

submodules_deinit:
	git submodule deinit --all --force
