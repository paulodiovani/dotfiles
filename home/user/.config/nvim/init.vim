" Transition from Vim (https://neovim.io/doc/user/nvim.html#nvim-from-vim)
set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

""""""""""""""""""""
" SETTINGS SECTION "
""""""""""""""""""""

set jumpoptions-=unload             " Do not unload buffers with bdelete
                                    " (https://github.com/neovim/neovim/pull/29347)
set foldmethod=expr                 " enable fold for treesitter
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable                    " Disable folding at startup.

" Disable Netrw
" let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Require lua conf
lua require('config')

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" Toggles

map <Leader>^ :lua toggle_diagnostics()<CR>         " <Leader><S-6> toggle diagnostics visibility

" navigate in diagnostics
map [a :lua vim.diagnostic.goto_prev()<CR>
map ]a :lua vim.diagnostic.goto_next()<CR>

" open diagnostic in float window / location list
map <Leader>a :lua vim.diagnostic.open_float()<CR>
map <Leader>A :lua vim.diagnostic.setloclist()<CR>

" code completion with omni function
" inoremap <C-Space> <C-x><C-o>
" inoremap <C-@> <C-x><C-o>

" Show code actions
map <Leader>ca :CodeAction<CR>

" Open Copilot Panel
map <Leader>cp :Copilot panel<CR>>""
" Open Copilot Chat below
command! -range CopilotChatBelow :bel split | CopilotChatOpen
map <Leader>cc :CopilotChatBelow<CR>

" use <Escape> to go back to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""""
" CUSTOM COMMANDS SECTION "
"""""""""""""""""""""""""""

" show code actions
command! -range CodeAction lua vim.lsp.buf.code_action()

" open terminal in split window below
command! -nargs=* Terminal :bel split | terminal <args>

" file drawer (using nvim-tree)
command! -nargs=? Drawer lua drawer_open(<f-args>)
command! DrawerCwd execute 'Drawer' getcwd()
command! DrawerFind lua drawer_find()

" open checkhealth in an unlisted window above
command! -nargs=? -complete=checkhealth Checkhealth above checkhealth <args> | file <args>\ health | setlocal bufhidden=wipe nomodifiable nobuflisted
" override lsp commands to not open in tab (also in completion.lua)
command! LspInfo Checkhealth lspconfig
command! LspLog lua vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted', vim.lsp.get_log_path()))

" format code
command! -range Format if <range> | exec 'lua vim.lsp.buf.range_formatting({ timeout_ms = 2000 })' | else | exec 'lua vim.lsp.buf.format({ timeout_ms = 2000 })' | endif

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" force close terminal buffer with <Leader>x
autocmd TermOpen term://* map <buffer> <Leader>x :Bdelete!<CR>
" close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* map <buffer> <Leader>q :bd!<CR>
