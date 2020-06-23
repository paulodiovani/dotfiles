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
set mouse=""            " disable mouse support
set nu                  " add line numbers
set ruler               " show cursor position
" set splitbelow          " split below
set title               " show filename on title bar
set titlestring=%t      " show only filename
set t_vb=               " no
"set termencoding=utf8   " all files are utf8set nobackup
"set nobackup            " don't write ~* backup files
set history=500         " number of items to keep in history
set foldmethod=manual   " folding (manual, indent, syntax, expr, marker, diff)
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
set sessionoptions-=options  " do not save options in sessions
set path+=**            " search subfolders (find, ...)
set conceallevel=0      " do not conceal characters

" netrw/Explore (almost) like NERDTree
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" syntax and color scheme
set termguicolors       " enable true color support
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " tmux true color support
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " tmux true color support
syntax on
set background=dark     " background color (light|dark)
let g:one_allow_italics = 1
colorscheme one
" hide vertical split separator
hi VertSplit guifg=bg guibg=NONE gui=NONE

" fix arrow keys when using tmux
if &term =~ '^tmux' || &term =~ '^screen'
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif

" FZF config
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': 'below ' . string(&lines * 0.3) . 'split' }
let g:fzf_commits_log_options = '--format="%C(yellow)%h %ad%C(reset) %C(auto)| %s%d %C(cyan)[%an]" --date=short'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

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

" indentline config
let g:indentLine_char = '▏'
" let g:indentLine_conceallevel = 0

" Vim Fugitive Github Browse on (almos) any domain
let g:github_enterprise_urls = ['[-_\.a-zA-Z0-9]\+']

" interestingwords colors
let g:interestingWordsGUIColors = ['#808080', '#008080', '#800080', '#000080', '#808000', '#800000']
let g:interestingWordsTermColors = ['8', '6', '5', '4', '3', '1']

" emmet-vim config
let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_mode='iv'  " enable only in insert and visual modes
""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" open terminal below
cnoremap term bel term

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq

" Map <F*> keys...

" Rename/Move
map <expr> <F2> ':Move ' . expand('%')
" remove <CR>/^M from line endings
map <F3> :%s/\r//g<CR>
" shuffle text content (to hide sentitive data)
map <F8> ggVGg?
" fold/unfold with F9/*{{{*/
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf}}}
" enable/disable paste mode with F10
map <F10> :set paste!<CR>:set paste?<CR>
set pastetoggle=<F10>

" open definition (using ctags) in new buffer
noremap <F12> <C-]>
noremap g<F12> g<C-]>
inoremap <F12> <C-o><C-]>
" open definition (using ctags) in new tab
" noremap <F12> <C-w><C-]><C-w>T
" inoremap <F12> <C-o><C-w><C-]><C-w>T
noremap <Leader><F12> :pop<CR>
inoremap <Leader><F12> <C-o>:pop<CR>

" Toggles

nmap <Leader>1 :IndentLinesToggle<CR>       " show/hide indentline
nmap <Leader>2 :SignatureToggle<CR>         " show/hide marks
nmap <Leader>3 :set invnumber<CR>           " show/hide line numbers
nmap <Leader>4 :set list!<CR>               " show/hide hidden chars
nmap <Leader>5 :set hlsearch!<CR>           " toggle search highlight
nmap <Leader>6 :ALEToggle<CR>               " toggle ALE linting
nmap <silent><Leader>0 :call WriteRoomToggle()<CR>  " writeroom mode
" show all toggles
nmap <silent><Leader><Backspace> :for n in [1,2,3,4,5,6,7,8,9,0] \| exec 'map <Leader>' . n \| endfor<CR>

" go to next/prev marks
nnoremap m] ]`
nnoremap m[ [`

" Location list mappings
map <Leader>s :lopen<CR>
map <Leader>, :lprev<CR>
map <Leader>. :lnext<CR>

" navigate in windows
noremap <Leader>w <C-w>p
noremap <Leader>o <C-w>o
" navigate in tabs
noremap <Leader><PageUp> :tabprev<CR>
noremap <Leader><PageDown> :tabnext<CR>
" move tabs
noremap <Leader><S-PageUp> :tabm -1<CR>
noremap <Leader><S-PageDown> :tabm +1<CR>
" navigate in buffers
noremap gb <C-^>
noremap <Leader><Left> :bprev<CR>
noremap <Leader><Right> :bnext<CR>
noremap <Leader>< :bprev<CR>
noremap <Leader>> :bnext<CR>
" delete buffer without closing the window
command! Bdelete if len(getbufinfo({'buflisted':1})) > 1 | bprev | bdelete# | else | bdelete | endif
noremap <Leader>x :Bdelete<CR>

" close current window
noremap <Leader>q :q<CR>

" past in command (:) with Shift + Insert
cnoremap <S-Insert> <C-R>"

" outdent with Shift+Tab
imap <S-Tab> <C-o><<

" open netrw/Explore (similar to NERDTree)
command! -nargs=? Drawer if winnr("$") == 1 | Vexplore <args>| else | 1 wincmd w | Explore <args>| endif
command! DrawerCwd execute 'Drawer' getcwd()
command! DrawerFind let @/=expand("%:t") | execute 'Drawer' expand("%:h") | normal n
map <C-k><C-b> :DrawerCwd<CR>
map <Leader>d :DrawerCwd<CR>
map <C-k><C-f> :DrawerFind<CR>
map <Leader>f :DrawerFind<CR>

" fzf and ripgrep maps

" list files/git files
command! Ctrlp execute (exists("*fugitive#head") && len(fugitive#head())) ? 'GFiles' : 'Files'
map <C-p> :Ctrlp<CR>
map <Leader>p :Ctrlp<CR>
map <Leader>P :Ctrlp<CR>
" list buffers
map <Leader>b :Buffers<CR>
" list tags (current buffer / all)
map <Leader>t :BTags<CR>
map <Leader>T :Tags<CR>
" list lines (current buffer)
map <Leader>l :BLines<CR>
map <Leader>L :Lines<CR>
" ripgrep search word under cursor
noremap <Leader>rg yiw:Rg <C-r>"
" paste word under cursor in command mode
noremap <Leader>: yiw:<Space><C-r>"<Home>

"""""""""""""""""""""""""""
" CUSTOM COMMANDS SECTION "
"""""""""""""""""""""""""""
command! Hexdump %!xxd
command! HexdumpReverse %!xxd -r

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

augroup FileTypes
  autocmd BufNewFile,BufRead *.es6 set filetype=javascript
augroup END

augroup SessMngr
  let IsStdIn = 0
  autocmd!
  autocmd StdinReadPost * let IsStdIn = 1
  autocmd VimLeave * NERDTreeClose
  autocmd VimLeave * call SaveSess()
  autocmd VimEnter * nested if !argc() && !IsStdIn | call RestoreSess() | endif
augroup END
