" syntax and color scheme
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
  let base16colorspace=256
  source $HOME/.config/tinted-theming/set_theme.vim
endif

" hide vertical split separator
" highlight VertSplit ctermfg=bg ctermbg=NONE cterm=NONE guifg=bg guibg=NONE gui=NONE
highlight WinSeparator ctermfg=bg ctermbg=NONE cterm=NONE guifg=bg guibg=NONE gui=NONE
" hide floating windows borders
highlight FloatBorder ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" highlight FloatBorder ctermfg=NONE ctermbg=NONE cterm=NONE
" hide NonText character
highlight NonText guifg=bg ctermfg=bg
" make line numbers bg transparent
highlight LineNr guibg=none
" set non-current window a different bg
highlight NormalNC guibg=#24282f
highlight NvimTreeNormalNC guibg=#24282f
" set color of float borders
highlight link FloatBorder LineNr
" fix issue with diagnostics windows (or the theme)
highlight! link NormalFloat Float
" remove text background in diagnostics windows
highlight ErrorFloat guibg=NONE
highlight WarningFloat guibg=NONE
highlight InfoFloat guibg=NONE
highlight HintFloat guibg=NONE
highlight OkFloat guibg=NONE
