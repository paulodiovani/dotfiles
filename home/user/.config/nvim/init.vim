" Transition from Vim (https://neovim.io/doc/user/nvim.html#nvim-from-vim)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

""""""""""""""""""""
" SETTINGS SECTION "
""""""""""""""""""""

" Open terminal in split window below
command! -nargs=* Terminal :bel split | terminal <args>

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" Close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* noremap <buffer> <Leader>q :bd!<CR>
