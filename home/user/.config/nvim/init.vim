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

" LSP config
lua << EOF
  require("nvim-lsp-installer").setup {
    automatic_installation = true
  }

  local lspconfig = require('lspconfig')
  lspconfig.bashls.setup {}
  lspconfig.html.setup {}
  lspconfig.solargraph.setup {}
  lspconfig.tsserver.setup {}
EOF

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" navigate in diagnostics
map [a :lua vim.diagnostic.goto_prev()<CR>
map ]a :lua vim.diagnostic.goto_next()<CR>

" open current diacnostic in float window
map <Leader>a :lua vim.diagnostic.open_float()<CR>

" open LSP definition
map <F9> :lua vim.lsp.buf.hover()<CR>
inoremap <F9> <C-o>:lua vim.lsp.buf.hover()<CR>

" go to definition
map <F12> :lua vim.lsp.buf.definition()<CR>
inoremap <F12> <C-o>:lua vim.lsp.buf.definition()<CR>

" code completion with omni function
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" Close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* map <buffer> <Leader>q :bd!<CR>

" Run linters
autocmd BufReadPost,BufWritePost * lua require('lint').try_lint()
