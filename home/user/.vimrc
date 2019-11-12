" Map Space as <Leader>
let mapleader = " "

" GUI settings (gvim only)
set guifont=Source\ Code\ Pro\ Regular\ 11
" set guioptions -=m     " hide menu
set guioptions -=T     " hide toolbar

" General config
set nu                  " add line numbers
set ruler               " show cursor position
set title               " show filename on title bar
set titlestring=%t      " show only filename
set t_vb=               " no
"set termencoding=utf8   " all files are utf8set nobackup
"set nobackup            " don't write ~* backup files
set fdm=marker          " folding
"set tw=80               " text width
set bs=2                " same as :set backspace=indent,eol,start
set sm                  " color matching braces/parenthesis
set ai cindent sw=2     " indentation
"set is ic              " search
set expandtab           " convert tabs to spaces
set ts=2 sts=2 sw=2     " TAB width
" set noautoindent
set listchars=tab:▸\ ,eol:¬,space:. " custom symbols for hhidden characters

" show hidden chars
nmap <leader>h :set list!<CR>

" shuffle text content (to hide sentitive data)
map <F8> ggVGg?
" remove <CR>/^M from line endings
map <F2> :%s/\r//g<CR>
" enable/disable paste mode
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq

" syntax and color scheme
set termguicolors       " enable true color support
colorscheme one
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
set background=dark     " background color (light|dark)

" Lightline config
set t_Co=256
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"\ue0a2":""}',
      \   'gitbranch': "\ue0a0 %{fugitive#head()}"
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help" && &readonly)',
      \   'gitbranch': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

" Syntastic config
if exists("*SyntasticStatuslineFlag")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
endif

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = './node_modules/.bin/eslint'

let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exec = '/home/diovani/.rbenv/shims/rubocop'

map <Leader>s :SyntasticCheck<CR>

" Location list settings
" map <Leader>lo :lopen<CR>
" map <Leader>lc :lclose<CR>
" map <Leader>ln :lnext<CR>
map <Leader>l :lnext<CR>
" map <Leader>ll :lnext<CR>
" map <Leader>lp :lprevious<CR>
map <Leader>L :lprevious<CR>
" map <Leader>lL :lprevious<CR>
" map <Leader>LL :lprevious<CR>

" CtrlP custom listing
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', 'find %s -maxdepth 4 -type f']

" nerdtree keymaps
map <C-k><C-b> :NERDTreeToggle<CR>
map <C-k><C-r> :NERDTreeFind<CR>

" tabs/buffers keymaps (Note: Leader=\ by default)
map <Leader>tp :tabprev<CR>
map <Leader><Left> :tabprev<CR>
map <Leader>tn :tabnext<CR>
map <Leader><Right> :tabnext<CR>

" navigate in buffers
map <Leader>bp :bprev<CR>
map <Leader><Up> :bprev<CR>
map <Leader>bn :bnext<CR>
map <Leader><Down> :bnext<CR>
map <Leader>bd :bdelete<CR>
map <Leader>q :bdelete<CR>

" silver search word under cursor
map <Leader>ag bye:!ag <C-r>"

" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
" map <C-t> :CtrlPSmartTabs<CR>

" open definition (using ctags) in new tab
nnoremap <silent><F12> <C-w><C-]><C-w>T

" do not save buffers in sessions
set ssop-=buffers

fu! IsCurrentSess()
  let l:lines = readfile(getcwd() . '/Session.lock')
  return get(l:lines, 0) == getpid()
endfunction

" auto save/load sessions, unless already opened
fu! SaveSess()
  if filewritable(getcwd() . '/Session.vim') && IsCurrentSess()
    execute 'mksession!' getcwd() . '/Session.vim'
    " remove lock file
    call delete(getcwd() . '/Session.lock')
  endif
endfunction

fu! RestoreSess()
  if filereadable(getcwd() . '/Session.vim') && !filewritable(getcwd() . '/Session.lock')
    " create a (pseudo) lockfile
    call writefile([getpid()], getcwd() . '/Session.lock', 's')
    " source session file and open args/buffers in new tabs (if any)
    execute 'so' getcwd() . '/Session.vim'
    execute 'tab sball'
  endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()
