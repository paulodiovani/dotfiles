CPUS = $(shell nproc --all || echo 4)
FROMHOME = home/user
OS = $(shell uname -s | tr '[:upper:]' '[:lower:]')

.DEFAULT_GOAL := help

.NOTPARALLEL:

help: ## Print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

all: submodules dotfiles symlinks ## Run tasks: submodules, dotfiles, and symlinks

dotfiles: ## Copy config files (a.k.a. dot files) to $HOME
	rsync -amv --cvs-exclude --exclude=.git $(FROMHOME)/ $(HOME)

symlinks: ## Create os-specific symlinks
	(cd ~/.config; rm -f os-config; ln -sfv "$(OS)-config" os-config)

submodules: ## Init and fetch git submodules
	git submodule update --init --depth=1 --jobs=$(CPUS)

submodules_update: ## Update git submodules
	git submodule update --init --remote --depth=1 --jobs=$(CPUS)

submodules_deinit: ## Deinit git submodules
	git submodule deinit --all --force
