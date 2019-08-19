FROMHOME = ./home/user
BINFILES := $(wildcard $(FROMHOME)/bin/*)
SUBMODULES := $(FROMHOME)/.oh-my-zsh $(FROMHOME)/.vim
DOTFILES := $(wildcard $(FROMHOME)/\.[^\.]*)
DOTFILES := $(filter-out $(SUBMODULES), $(DOTFILES))

# .PHONY: all bin

.NOTPARALLEL:

all: binfiles dotfiles

binfiles:
	cp -vu $(BINFILES) $(HOME)/bin/

dotfiles:
	cp -vru $(DOTFILES) $(HOME)/

submodules:
	# for m in "$(SUBMODULES)"; do
	# 	echo $m
	# done
