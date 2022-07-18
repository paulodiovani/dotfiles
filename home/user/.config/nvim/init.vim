" Transition from Vim (https://neovim.io/doc/user/nvim.html#nvim-from-vim)
set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

""""""""""""""""""""
" SETTINGS SECTION "
""""""""""""""""""""
" Disable Netrw
" let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" Require lua conf
lua require('config')

" LSP config
set omnifunc=v:lua.vim.lsp.omnifunc
set tagfunc=v:lua.vim.lsp.tagfunc

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" toggles
map <Leader>^ :lua toggle_diagnostics()<CR>         " <Leader><S-6> toggle diagnostics visibility

" navigate in diagnostics
map [a :lua vim.diagnostic.goto_prev()<CR>
map ]a :lua vim.diagnostic.goto_next()<CR>

" open diacnostic in float window / location list
map <Leader>a :lua vim.diagnostic.open_float()<CR>
map <Leader>A :lua vim.diagnostic.setloclist()<CR>

" open LSP definition
map <F9> :lua vim.lsp.buf.hover()<CR>
inoremap <F9> <C-o>:lua vim.lsp.buf.hover()<CR>

" go to definition
map <F12> :lua vim.lsp.buf.definition()<CR>
inoremap <F12> <C-o>:lua vim.lsp.buf.definition()<CR>

" code completion with omni function
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" use <Escape> to go back to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""""
" CUSTOM COMMANDS SECTION "
"""""""""""""""""""""""""""

" Open terminal in split window below
command! -nargs=* Terminal :bel split | terminal <args>

" file drawer (using nvim-tree)
command! -nargs=? Drawer lua drawer_open(<f-args>)
command! DrawerCwd execute 'Drawer' getcwd()
command! DrawerFind lua drawer_find()

" format code
command! -range Format if <range> | exec 'lua vim.lsp.buf.range_formatting()' | else | exec 'lua vim.lsp.buf.formatting()' | endif

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" force close terminal buffer with <Leader>x
autocmd TermOpen term://* map <buffer> <Leader>x :Bdelete!<CR>
" close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* map <buffer> <Leader>q :bd!<CR>
