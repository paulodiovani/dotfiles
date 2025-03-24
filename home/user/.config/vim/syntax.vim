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

" hide split separator
highlight WinSeparator ctermfg=bg ctermbg=NONE cterm=NONE guifg=bg guibg=NONE gui=NONE
" hide floating windows borders
highlight FloatBorder ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
" hide NonText character
highlight NonText guifg=bg ctermbg=bg
" make cursor line same bg
highlight CursorLine guibg=bg ctermbg=bg
" make line numbers bg transparent
highlight LineNr guibg=none
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

" Function to darken a hex color
function! DarkenColor(hex, percent)
  let l:rgb = [str2nr(a:hex[1:2], 16), str2nr(a:hex[3:4], 16), str2nr(a:hex[5:6], 16)]
  let l:factor = 1 - (a:percent / 100.0)
  let l:darker_rgb = map(l:rgb, {_, v -> printf('%02x', max([0, float2nr(v * l:factor)]))})
  return '#' . join(l:darker_rgb, '')
endfunction

" Get the current background color
let current_bg = synIDattr(hlID('Normal'), 'bg#')
let darker_bg = DarkenColor(current_bg, 25)

" Set non-current window a slightly darker bg
exec 'highlight NormalNC guibg=' .. darker_bg
exec 'highlight EndOfBufferNC guibg=' .. darker_bg .. ' guifg=' .. darker_bg
exec 'highlight WinSeparatorNC guibg=' .. darker_bg .. ' guifg=' .. darker_bg
autocmd WinLeave,BufLeave * setlocal winhighlight=Normal:NormalNC,EndOfBuffer:EndOfBufferNC,WinSeparator:WinSeparatorNC
autocmd WinEnter,BufEnter * setlocal winhighlight=Normal:Normal,EndOfBuffer:EndOfBuffer,WinSeparator:WinSeparator
