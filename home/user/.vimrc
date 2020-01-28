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
set hidden              " Allow unsaved hidden buffers
set noequalalways       " Do not resize windows on close
" set noautoindent
set listchars=tab:▸\ ,eol:¬,space:. " custom symbols for hidden characters
" do not save options in sessions
set sessionoptions-=options

" syntax and color scheme
set termguicolors       " enable true color support
colorscheme one
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
set background=dark     " background color (light|dark)
" hide vertical split separator
hi VertSplit guifg=bg guibg=NONE gui=NONE

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
set showtabline=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'active': {
      \   'left': [['mode', 'paste' ],
      \            ['gitbranch', 'readonly', 'relativepath', 'conflicted', 'modified']],
      \ },
      \ 'inactive': {
      \   'left': [['filename', 'conflicted']],
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['close'], ['tabs']],
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help" ? "" : &readonly ? "\ue0a2" : ""}',
      \   'gitbranch': "\ue0a0 %{fugitive#head()}",
      \   'conflicted': "\u22b6 %{exists('*ConflictedVersion') ? ConflictedVersion() : ''}",
      \ },
      \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
      \ 'component_type': { 'buffers': 'tabsel' },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help" && &readonly)',
      \   'gitbranch': '(exists("*fugitive#head") && "" != fugitive#head())',
      \   'conflicted': '(exists("*ConflictedVersion") && "" != ConflictedVersion())',
      \ },
      \ }
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#unnamed      = '[No Name]'

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
let NERDTreeQuitOnOpen = 0

" interestingwords colors
let g:interestingWordsGUIColors = ['#808080', '#008080', '#800080', '#000080', '#808000', '#800000']
let g:interestingWordsTermColors = ['8', '6', '5', '4', '3', '1']

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
nnoremap m] ]`
nnoremap m[ [`

" Run Syntax check
map <Leader>s :SyntasticCheck<CR>
" Location list mappings
command! Lnext try | lnext | catch | lfirst | catch | endtry
map <Leader>, :Lnext<CR>

" navigate in windows
noremap <Leader>w <C-w>w
" navigate in tabs
noremap <Leader><PageUp> :tabprev<CR>
noremap <Leader><PageDown> :tabnext<CR>
" move tabs
noremap <Leader><S-PageUp> :tabm -1<CR>
noremap <Leader><S-PageDown> :tabm +1<CR>
" navigate in buffers
noremap gb :<C-U>execute "buffer" . v:count<CR>
noremap <Leader><Left> :bprev<CR>
noremap <Leader><Right> :bnext<CR>
noremap <Leader>h :bprev<CR>
noremap <Leader>l :bnext<CR>
noremap <Leader>bd :bdelete<CR>
noremap <Leader>x :bdelete<CR>

" past in command (:) with Shift + Insert
cnoremap <S-Insert> <C-R>"
" paste word under cursor in command mode
noremap <Leader>: bye: <C-r>"<Home>
" silver search word under cursor
noremap <Leader>ag bye:!clear;ag <C-r>"

" outdent with Shift+Tab
imap <S-Tab> <C-o><<

" nerdtree keymaps
map <C-k><C-b> :NERDTreeToggle<CR>
imap <C-k><C-b> <C-o>:NERDTreeToggle<CR>
map <C-k><C-f> :NERDTreeFind<CR>
imap <C-k><C-f> <C-o>:NERDTreeFind<CR>
map <Leader>f :NERDTreeFind<CR><C-w><C-p>
" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
map <C-t> :CtrlPSmartTabs<CR>
" tags navigation: goto tag or pop back
command! -range Tag try | pop | catch | execute '<line1>,<line2>tag' expand("<cword>") | catch | endtry
map <C-]> :Tag<CR>

" writeroom keymap (see functions section)
map <silent><Leader>v :call WriteRoomToggle()<CR>

"""""""""""""""""""""
" FUNCTIONS SECTION "
"""""""""""""""""""""

" use a smaller viewport
function! WriteRoomToggle()
  let l:name = '_writeroom_'
  if bufwinnr(l:name) > 0
    wincmd o
  else
    let l:width = (&columns - &textwidth) / 5
    execute 'topleft' l:width . 'vsplit +setlocal\ nobuflisted' l:name | wincmd p
    execute 'botright' l:width . 'vsplit +setlocal\ nobuflisted' l:name | wincmd p
    endif
endfunction

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
    " execute 'tab sball'
  endif
endfunction


"""""""""""""""""""
" AUTOCMD SECTION "
"""""""""""""""""""

augroup SessMngr
  let IsStdIn = 0
  autocmd!
  autocmd StdinReadPost * let IsStdIn = 1
  autocmd VimLeave * call SaveSess()
  autocmd VimEnter * nested if !argc() && !IsStdIn | call RestoreSess() | endif
augroup END
