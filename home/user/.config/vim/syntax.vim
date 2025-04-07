" configure vim syntax and colorscheme

" if &t_Co == 256 "for vim only
if $COLORTERM == "truecolor" || $COLORTERM == "24bit"
  set termguicolors       " enable true color support
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " tmux true color support
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " tmux true color support
endif

syntax on
set background=dark     " background color (light|dark)
let g:one_allow_italics = 1

" set base16 theme
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
  let base16_colorspace=256
  source $HOME/.config/tinted-theming/set_theme.vim
endif

" THEME OVERRIDES

" hide cursor line
highlight CursorLine guibg=NONE ctermbg=NONE
" make line numbers and sign column bg transparent
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
" set color of float window and borders
highlight! link FloatBorder LineNr
" fix issue with diagnostics windows (or the theme)
highlight! link NormalFloat Float
" remove end of buffer bg
highlight EndOfBuffer guibg=NONE
" remove text background in diagnostics windows
highlight DiagnosticFloatingError guibg=NONE
highlight DiagnosticFloatingWarn guibg=NONE
highlight DiagnosticFloatingInfo guibg=NONE
highlight DiagnosticFloatingHint guibg=NONE
highlight DiagnosticFloatingOk guibg=NONE

" NvimTree overrides
highlight link NvimTreeNormal WriteRoomNormal
" copilot chat overrides
highlight! link CopilotChatNormal WriteRoomNormal
autocmd BufEnter copilot-chat setlocal winhighlight=Normal:CopilotChatNormal
