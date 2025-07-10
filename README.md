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
- bat
- fzf
- git
- neovim
- ripgrep
- rsync
- tmux
- zsh

#### WM, UI tools, and launcher

- sway (check [docs/SWAYWM.md](docs/SWAYWM.md)

#### Password Manager

- browserpass
- pass (https://www.passwordstore.org/)
- pinentry-gnome

### Arch Linux

- base-devel

### macOS

- homebrew (install first)
- pinentry-mac

#### WM, UI tools, and launcher

- aerospace
- karabiner-elements
- raycast
- scroll-reverser

#### Extra settings

```bash
# remove quarantine from unsigned apps
xattr -d com.apple.quarantine /Applications/Alacritty.app

# fix font blur in Alacritty
defaults -currentHost write -g AppleFontSmoothing -int 0

# fix browserpass use homebrew-installed gpg
# source: https://github.com/browserpass/browserpass-legacy?tab=readme-ov-file#faq-1
sudo ln -s /opt/homebrew/bin/gpg /usr/local/bin/gpg
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
