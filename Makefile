FROMHOME = home/user
BINFILES := $(wildcard $(FROMHOME)/bin/*)
SUBMODULES := $(shell git config --file .gitmodules --get-regexp path | awk '{ print $$2 }')
DOTFILES := $(wildcard $(FROMHOME)/\.[^\.]*)
DOTFILES := $(filter-out $(SUBMODULES), $(DOTFILES))

# .PHONY: all bin

.NOTPARALLEL:

all: binfiles dotfiles

binfiles:
	mkdir -p $(HOME)/bin/
	cp -vu $(BINFILES) $(HOME)/bin/

dotfiles:
	cp -vru $(DOTFILES) $(HOME)/

submodules:
	git submodule init
	git submodule update
	for module in $(SUBMODULES); do				\
		pushd $$module;							\
		url="$$(git remote get-url origin)";	\
		path="$${module#$(FROMHOME)/}";			\
		echo git clone $$url $(HOME)/$$path;	\
		popd;									\
	done
