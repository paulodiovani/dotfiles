FROMHOME = home/user
BINFILES := $(wildcard $(FROMHOME)/bin/*)
SUBMODULES := $(shell git config --file .gitmodules --name-only --get-regexp path | sed s/\.path$$//g)
DOTFILES := $(wildcard $(FROMHOME)/\.[^\.]*)
DOTFILES := $(filter-out $(SUBMODULES), $(DOTFILES))

# .PHONY: all

.NOTPARALLEL:

all: binfiles dotfiles

binfiles:
	mkdir -p $(HOME)/bin/
	cp -vu $(BINFILES) $(HOME)/bin/

dotfiles:
	cp -vru $(DOTFILES) $(HOME)/

submodules:
	for submodule in $(SUBMODULES); do										\
		sm_path=$$(git config --file .gitmodules --get $$submodule.path);	\
		sm_path=$${sm_path#$(FROMHOME)/};									\
		sm_url=$$(git config --file .gitmodules --get $$submodule.url);		\
		git clone --depth 1 $$sm_url $(HOME)/$$sm_path;						\
	done
