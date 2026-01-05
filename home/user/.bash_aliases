# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Use cd -P to expand symlinks to full paths
alias cdp='cd -P'

# scrollable less and tabwidth=4
alias less='less -S -x4'
alias expand='expand -t4'

# vim less (user nvim as less for syntax highlight)
alias vimless='/usr/share/nvim/runtime/macros/less.sh'

# search files with preview
alias files='fzf -m --preview="bat --style=numbers --color=always {}"'

# aliases for common commands
alias bx='bundle exec'
alias dc='docker compose'

# list and select a tinted-theme
alias tinted-theme-select='tinty apply $(tinty list | fzf)'

# use tinted-theme for bat
alias bat="bat --theme='base16-256'"

# make aliases work with sudo and noglob
alias sudo='sudo '
alias noglob='noglob '

# make linux more polite
alias please='sudo'

# switch aws profiles from ~/.aws/credentials
alias aws-switch-profile="aws configure list-profiles | fzf | xargs -I{} echo export AWS_PROFILE={} | source /dev/stdin"

# git command overrides
git() {
  if [[ $@ =~ 'push -f' || $@ =~ 'push --force' ]]; then
    command git push --force-with-lease
  elif [[ $1 == 'diff' ]]; then
    cmd=$1
    shift
    command git "${cmd}vim" $@
  else
    command git "$@"
  fi
}

# use gradew script if available
gradle() {
  if [ -f ./gradlew ]; then
    ./gradlew "$@"
  else
    command gradle "$@"
  fi
}

# run tinty hooks loaging env vars
# source: https://github.com/tinted-theming/tinty/blob/516825415f2809d20a73fbcabe7f42902d655574/USAGE.md#sourcing-scripts-that-set-environment-variables
tinty() {
  newer_file=$(mktemp)
  command tinty $@
  subcommand="$1"

  if [ "$subcommand" = "apply" ] || [ "$subcommand" = "init" ]; then
    tinty_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"

    while read -r script; do
      # shellcheck disable=SC1090
      . "$script"
    done < <(find "$tinty_data_dir" -maxdepth 1 -type f -o -type l -name "*.sh" -newer "$newer_file")

    unset tinty_data_dir
  fi

  unset subcommand
}

# os-specific aliases
[ -f "$HOME/.config/os-config/.bash_aliases" ] && . "$HOME/.config/os-config/.bash_aliases"
