# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# Modified by https://github.com/paulodiovani
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
PRIMARY_FG=black
PRIMARY_BG=blue
ALERT_FG=yellow
GIT_BG=cyan

# Characters
SEGMENT_SEPARATOR="\ue0b0"
PLUSMINUS="%B\u00b1%b"
BRANCH="\ue0a0"
DETACHED="\u27a6"
CROSS="\u2718"
LIGHTNING="\u26a1"
GEAR="\u2699"

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    print -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%}"
  else
    print -n "%{$bg%}%{$fg%}"
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && print -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    print -n "%{%k%}"
  fi
  print -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CONNECTION" ]]; then
    prompt_segment $PRIMARY_FG default " %(!.%{%F{$ALERT_FG}%}.)$user@%m "
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  print -n "%k%F{$CURRENT_BG}\$(git_prompt_info)$SEGMENT_SEPARATOR"
  CURRENT_BG=''
}

# Dir: current working directory
prompt_dir() {
  prompt_segment $PRIMARY_BG $PRIMARY_FG ' %F%c%f '
}

# Emoji to help distinguish prompts
shell_emoji() {
  icon_list=(👽 👾 🐙 🍄 🥑 🎃 🤔 🐧 💣 🎲)
  echo ${icon_list[$RANDOM % ${#icon_list[@]} + 1]}
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbol
  # show emoji
  symbol="%(5l..$(shell_emoji))"

  # show a $ALERT_FG ⚠︎ if privileged
  symbol="%(!.%F{$ALERT_FG}$LIGHTNING.${symbol})"

  # show a cog if there are any background jobs
  symbol="%(1j.%F{$GIT_BG}$GEAR.${symbol})"

  # show a cross if last return value is not
  #   0 success
  # 130 ctrl-c
  # 146 ctrl-z (macos)
  # 148 ctrl-z (linux)
  symbol="%(0?.${symbol}.%(130?.${symbol}.%(146?.${symbol}.%(148?.${symbol}.%F{red}$CROSS ))))"

  prompt_segment $PRIMARY_FG default " $symbol "
}

## Main prompt
prompt_agnoster_main() {
  CURRENT_BG='NONE'
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

# ZSH Git variables
# used by git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX="$(CURRENT_BG=$PRIMARY_BG prompt_segment $GIT_BG $PRIMARY_FG $BRANCH) "
ZSH_THEME_GIT_PROMPT_SUFFIX="$(CURRENT_BG='NONE' prompt_segment '' $GIT_BG)"
ZSH_THEME_GIT_PROMPT_DIRTY=" $(CURRENT_BG='NONE' prompt_segment $GIT_BG $ALERT_FG $PLUSMINUS)"
ZSH_THEME_GIT_PROMPT_CLEAN=" "

# set prompt
PROMPT="$(prompt_agnoster_main) "
RPROMPT=""
