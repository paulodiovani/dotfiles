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
- tinty (tinted-theme cli)
- tmux
- zsh

#### WM, UI tools, and launcher

- sway (check [docs/SWAYWM.md](docs/SWAYWM.md)

#### Password Manager

- browserpass
- pass (https://www.passwordstore.org/)
- pinentry-gnome

#### Extra settings

```bash
# configure git
<<EOF > "$HOME/.config/gitconfig.d/index"
[include]
  path = ./user
EOF

git config set --file="$HOME/.config/gitconfig.d/user" user.name "YOUR NAME"
git config set --file="$HOME/.config/gitconfig.d/user" user.email "YOUR EMAIL ADDRESS"

# add more includes to $HOME/.config/gitconfig.d/index if you need
# use [includeIf "gitdir:~/path/to/dir]" for conditional include
#   source: https://git-scm.com/docs/git-config#_includes

# configure tinted-theme
tinty sync
```

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
- autoraise

#### Extra settings

```bash
# remove quarantine from unsigned apps
xattr -d com.apple.quarantine /Applications/Alacritty.app

# fix font blur in Alacritty
defaults -currentHost write -g AppleFontSmoothing -int 0

# install and start autoraise with EXPERIMENTAL_FOCUS_FIRST flag
brew tap dimentium/autoraise
brew install autoraise --with-dexperimental_focus_first
brew services start autoraise

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
