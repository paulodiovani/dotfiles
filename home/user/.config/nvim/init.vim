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
set winborder=rounded               " Use rounded borders for all windows

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
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>

" use <Escape> to go back to normal mode in terminal
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""""
" CUSTOM COMMANDS SECTION "
"""""""""""""""""""""""""""

" open terminal in split window below
command! -nargs=* Terminal :bel split | terminal <args>

" Delete buffer, than move to most recent or previous buffer
command! -bang Bdelete if len(getbufinfo({'buflisted':1})) > 1 | if buflisted(bufnr('#')) | b# | else | bprev | endif | bdelete<bang># | else | bdelete<bang> | endif

" open checkhealth in an unlisted window above
command! -nargs=? -complete=checkhealth Checkhealth above checkhealth <args> | file <args>\ health | setlocal bufhidden=wipe nomodifiable nobuflisted

" format code
command! -range Format if <range> | exec 'lua vim.lsp.buf.range_formatting({ timeout_ms = 2000 })' | else | exec 'lua vim.lsp.buf.format({ timeout_ms = 2000 })' | endif

"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

" force close terminal buffer with <Leader>x
autocmd TermOpen term://* map <buffer> <Leader>x :Bdelete!<CR>
" close terminal buffer alongside window with <Leader>q
autocmd TermOpen term://* map <buffer> <Leader>q :bd!<CR>

" override lsp commands to not open in tab (also in completion.lua)
autocmd VimEnter * command! LspInfo Checkhealth vim.lsp
autocmd VimEnter * command! LspLog lua vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted', vim.lsp.get_log_path()))
