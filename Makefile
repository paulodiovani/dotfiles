FROMHOME = home/user
BINFILES := $(wildcard $(FROMHOME)/bin/*)
SUBMODULES := $(shell git config --file .gitmodules --name-only --get-regexp path | sed s/\.path$$//g)
DOTFILES := $(wildcard $(FROMHOME)/\.[^\.]*)
DOTFILES := $(filter-out $(SUBMODULES), $(DOTFILES))
PACKAGES = awk git tmux vim zsh

# .PHONY: all

.NOTPARALLEL:

all: install config

install: sudo install_archlinux

config: dotfiles binfiles submodules

sudo:
	@sudo echo 'Sudo available!' \
	|| echo "ALERT! sudo not available! You must install the following packages manually: $(PACKAGES)"

install_archlinux:
	@command -v pacman > /dev/null \
	&& sudo pacman -Sy --noconfirm $(PACKAGES) \
	|| echo "OPS! This is no Arch Linux, you'll have to install these manually: $(PACKAGES)" \
	&& echo "Note that other distros are not supported and some configs may not work, use at your own risk."

dotfiles:
	cp -vru $(DOTFILES) $(HOME)/

binfiles:
	mkdir -p $(HOME)/bin/
	cp -vu $(BINFILES) $(HOME)/bin/

submodules:
	for submodule in $(SUBMODULES); do										\
		sm_path=$$(git config --file .gitmodules --get $$submodule.path);	\
		sm_path=$${sm_path#$(FROMHOME)/};									\
		sm_url=$$(git config --file .gitmodules --get $$submodule.url);		\
		if [ -d $(HOME)/$$sm_path ]; then									\
			cd $(HOME)/$$sm_path;											\
			git pull;														\
			cd -;															\
		else																\
			git clone --depth 1 $$sm_url $(HOME)/$$sm_path;					\
		fi																	\
	done
