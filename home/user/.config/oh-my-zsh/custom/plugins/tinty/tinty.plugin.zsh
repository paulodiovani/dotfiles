#!/bin/env zsh
if [[ -z "$BASE16_THEME" && -z "$BASE24_THEME" ]] && (( $+commands[tinty] )); then
  tinty init
fi
