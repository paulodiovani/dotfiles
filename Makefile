FROMHOME = home/user
BINFILES := $(wildcard $(FROMHOME)/bin/*)
SUBMODULES := $(shell git config --file .gitmodules --name-only --get-regexp path | sed s/\.path$$//g)
DOTFILES := $(wildcard $(FROMHOME)/\.[^\.]*)
DOTFILES := $(filter-out $(SUBMODULES), $(DOTFILES))
PACKAGES = git tmux vim zsh

# .PHONY: all

.NOTPARALLEL:

all: install config

install: install_archlinux install_debian

config: dotfiles binfiles submodules

install_archlinux:
	command -v pacman > /dev/null && pacman -Sy $(PACKAGES)

install_debian:
	command -v apt-get > /dev/null && apt-get install $(PACKAGES)

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
		git clone --depth 1 $$sm_url $(HOME)/$$sm_path;						\
	done
