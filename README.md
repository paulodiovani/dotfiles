# .files

Config files for various programs.

Mostly for `$HOME`

## Fonts

- Source Code Pro
- Nerd Fonts patched fonts

## Package Requirements

### All distros

- alacritty
- asdf-vm
- autojump
- awk
- fzf
- git
- neovim
- ripgrep
- rsync
- tmux
- zsh

#### WM, UI tools, and launcher

- sway (check [docs/SWAYWM.md](docs/SWAYWM.md)

### Arch Linux

- base-devel

### macOS

- homebrew (install first)

#### WM, UI tools, and launcher

- aerospace
- karabiner-elements
- scroll-reverser

#### Extra settings

```bash
# remove quarantine from unsigned apps
xattr -d com.apple.quarantine /Applications/Alacritty.app

# fix font blur in Alacritty
defaults -currentHost write -g AppleFontSmoothing -int 0
```

## Usage

```bash
git clone --depth 1 https://github.com/paulodiovani/dotfiles.git
cd dotfiles
make all
```

Run `make help` or read the `Makefile` for more details.

## Supported OS and distros

- Arch Linux
- macOS

May or may not work with other Linux distros.
