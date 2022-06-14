" Transition from Vim (https://neovim.io/doc/user/nvim.html#nvim-from-vim)
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

""""""""""""""""""""
" SETTINGS SECTION "
""""""""""""""""""""

" Open terminal in split window below
command! -nargs=* Terminal :bel split | terminal <args>

" LSP config
set omnifunc=v:lua.vim.lsp.omnifunc

" Linter config (nvim-lint)
lua << EOF
  vim.diagnostic.config({ virtual_text = false })
  require('lint').linters_by_ft = {
    json = {'prettier'},
    javascript = {'eslint'},
    typescript = {'eslint'},
    ruby = {'rubocop'}
  }
EOF

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" navigate in diagnostics
map [a :lua vim.diagnostic.goto_prev()<CR>
map ]a :lua vim.diagnostic.goto_next()<CR>

" open offenses in location list
map <Leader>a :lua vim.diagnostic.setloclist()<CR>

" open diacnostics in preview window open/close
map <F9> :lua vim.diagnostic.open_float()<CR>
inoremap <F9> <C-o>:lua vim.diagnostic.open_float()<CR>

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" Close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* map <buffer> <Leader>q :bd!<CR>

" Run linters
autocmd BufReadPost,BufWritePost * lua require('lint').try_lint()
