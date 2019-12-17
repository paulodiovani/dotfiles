" let mapleader = "\\"
nmap <Space> \

""""""""""""""""""""
" SETTINGS SECTION "
""""""""""""""""""""

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
set hlsearch            " highlight search
set expandtab           " convert tabs to spaces
set ts=2 sts=2 sw=2     " TAB width
" set noautoindent
set listchars=tab:▸\ ,eol:¬,space:. " custom symbols for hidden characters
" do not save buffers or options in sessions
set sessionoptions-=buffers
set sessionoptions-=options

" syntax and color scheme
set termguicolors       " enable true color support
colorscheme one
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
set background=dark     " background color (light|dark)

" fix arrow keys when using tmux
if &term =~ '^tmux' || &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" Lightline config
set t_Co=256
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ]
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

" Vim Fugitive Github Browse on (almos) any domain
let g:github_enterprise_urls = ['[-_\.a-zA-Z0-9]\+']

" CtrlP custom listing
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard', 'find %s -maxdepth 4 -type f']

" nerdtree config
let NERDTreeShowHidden=1
let NERDTreeMapOpenInTab='<C-t>'
let NERDTreeQuitOnOpen = 1

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq

" Map <F*> keys...

" shuffle text content (to hide sentitive data)
map <F8> ggVGg?
" Rename/Move
map <expr> <F2> ':Move ' . expand('%')
" remove <CR>/^M from line endings
map <F3> :%s/\r//g<CR>
" enable/disable paste mode with F10
map <F10> :set paste!<CR>:set paste?<CR>
set pastetoggle=<F10>
" open definition (using ctags) in new tab
noremap <silent><F12> <C-w><C-]><C-w>T
inoremap <silent><F12> <Esc><C-w><C-]><C-w>T

" show/hide line numbers
nmap <Leader># :set invnumber<CR>
nmap <Leader>3 :set invnumber<CR>
" show/hide hidden chars
nmap <Leader>$ :set list!<CR>
nmap <Leader>4 :set list!<CR>
" toggle search highlight
noremap <Leader>n :set hlsearch!<CR>

" go to next/prev marks
nnoremap <Leader>m ]`
nnoremap <Leader>M [`

" Run Syntax check
map <Leader>s :SyntasticCheck<CR>
" Location list mappings
command! Lnext try | lnext | catch | lfirst | catch | endtry
map <Leader>, :Lnext<CR>

" navigate in tabs
noremap <Leader><Left> :tabprev<CR>
noremap <Leader><Right> :tabnext<CR>
noremap <Leader>h :tabprev<CR>
noremap <Leader>l :tabnext<CR>
" move tabs
noremap <Leader><S-Left> :tabm -1<CR>
noremap <Leader><S-Right> :tabm -1<CR>
noremap <Leader>H :tabm -1<CR>
noremap <Leader>L :tabm +1<CR>
" navigate in buffers
noremap <Leader><Up> :bprev<CR>
noremap <Leader><Down> :bnext<CR>
noremap <Leader>k :bprev<CR>
noremap <Leader>j :bnext<CR>
noremap <Leader>bd :bdelete<CR>

" paste word under cursor in command mode
noremap <Leader>: bye: <C-r>"<Home>
" silver search word under cursor
noremap <Leader>ag bye:!ag <C-r>" 

" nerdtree keymaps
map <C-k><C-b> :NERDTreeToggle<CR>
imap <C-k><C-b> <C-O>:NERDTreeToggle<CR>
map <C-k><C-r> :NERDTreeFind<CR>
imap <C-k><C-r> <C-O>:NERDTreeFind<CR>
" show/hide minimap
map <C-k><C-m> :MinimapToggle<CR>
" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
map <C-t> :CtrlPSmartTabs<CR>
" tags navigation: goto tag or pop back
command! -range Tag try | pop | catch | execute '<line1>,<line2>tag' expand("<cword>") | catch | endtry
map <C-]> :Tag<CR>


"""""""""""""""""""""
" FUNCTIONS SECTION "
"""""""""""""""""""""

" auto save/load sessions, unless already opened
function! IsCurrentSess()
  let l:lines = readfile(getcwd() . '/Session.lock')
  return get(l:lines, 0) == getpid()
endfunction

function! SaveSess()
  " write session only if exists
  if filewritable(getcwd() . '/Session.vim') && IsCurrentSess()
    execute 'mksession!' getcwd() . '/Session.vim'
    " remove lock file
    call delete(getcwd() . '/Session.lock')
  endif
endfunction

function! RestoreSess()
  " restore session exists and not yet opened (no Session.lock)
  if filereadable(getcwd() . '/Session.vim') && !filewritable(getcwd() . '/Session.lock')
    " create a (pseudo) lockfile with the current session pid
    call writefile([getpid()], getcwd() . '/Session.lock', 's')
    " source session file
    execute 'so' getcwd() . '/Session.vim'
    " open buffers in new tabs
    execute 'tab sball'
  endif
endfunction

augroup SessMngr
  let IsStdIn = 0
  autocmd!
  autocmd StdinReadPost * let IsStdIn = 1
  autocmd VimLeave * call SaveSess()
  autocmd VimEnter * nested if !argc() && !IsStdIn | call RestoreSess() | endif
augroup END
