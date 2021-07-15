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
"set noautoindent
"set splitbelow                      " split below
"set is ic                           " search
"set nobackup                        " don't write ~* backup files
"set termencoding=utf8               " all files are utf8set
"set tw=80                           " text width
set ai cindent sw=2                 " indentation
set bs=2                            " same as :set backspace=indent,eol,start
set conceallevel=0                  " do not conceal characters
set expandtab                       " convert tabs to spaces
set exrc                            " source .vimrc files in project dirs
set foldmethod=manual               " folding (manual, indent, syntax, expr, marker, diff)
set hidden                          " Allow unsaved hidden buffers
set history=5000                    " number of items to keep in history
set hlsearch                        " highlight search
set listchars=tab:▸\ ,eol:¬,space:. " custom symbols for hidden characters
set mouse=""                        " disable mouse support
set noequalalways                   " Do not resize windows on close
set nu                              " add line numbers
set path+=**                        " search subfolders (find, ...)
set ruler                           " show cursor position
set sessionoptions-=options         " do not save options in sessions
set showcmd                         " show command in statubar
set sm                              " color matching braces/parenthesis
set t_vb=                           " no
set title                           " show filename on title bar
set titlestring=%t                  " show only filename
set ts=2 sts=2 sw=2                 " TAB width

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
let g:fzf_layout = { 'window': 'botright ' . string(&lines * 0.3) . 'split' }
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

" ALE (Ascynchronous Linter Engine) config
set omnifunc=ale#completion#OmniFunc
let g:ale_linters_ignore = {'typescript': ['tslint']}
let g:ale_fixers = {
\ 'json': ['prettier'],
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'ruby': ['rubocop']
\}
let g:ale_hover_to_preview = 1

""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" disable ex mode access on Q
nnoremap Q <nop>

" open terminal below
cnoremap term bel term
map <Leader>` :terminal<CR>

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq

" Map <F*> keys...

map <expr><F2> ':Move ' . expand('%')                " rename/move
map <F3> :%s/\r//g<CR>                         " remove <CR>/^M from line endings
map <F4> ggVGg?                                " shuffle text content (to hide sentitive data)
map <F5> :throw 'No run command defined.'<CR>  " run command
map <F10> :set paste!<CR>:set paste?<CR>        " enable/disable paste mode with F10
set pastetoggle=<F10>

" Toggles

map <Leader>! :IndentLinesToggle<CR>                " <Leader><S-1> show/hide indentline
map <Leader>@ :SignatureToggle<CR>                  " <Leader><S-2> show/hide marks
map <Leader># :set invnumber<CR>                    " <Leader><S-3> show/hide line numbers
map <Leader>$ :set list!<CR>                        " <Leader><S-4> show/hide hidden chars
map <Leader>% :set hlsearch!<CR>                    " <Leader><S-5> toggle search highlight
map <Leader>^ :ALEToggle<CR>                        " <Leader><S-6> toggle ALE linting

" writeroom mode
nmap <silent><Leader><BS> :call WriteRoomToggle()<CR>

" show all F* keys and toggles
nmap <silent><Leader><F1> :
  \ for n in range(2,12) \| exec 'map <F'.n.'>' \| endfor \|
  \ for n in split('!@#$%^&*()', '\zs') \| exec 'map <Leader>'.n \| endfor<CR>

" go to next/prev marks, folds
nnoremap ]m ]`
nnoremap [m [`
nnoremap [z zk
nnoremap ]z zj

" List ALE offenses (open location list)
map <Leader>a :lopen<CR>

"navigate in ALE offences
map [a :ALEPrevious<CR>
map ]a :ALENext<CR>

" ALE Completion and go to definition
" must install language servers (e.g. typescript, solagraph...)
inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-x><C-o>
map <F12> :ALEGoToDefinition<CR>
inoremap <F12> <C-o>:ALEGoToDefinition<CR>

" ALE docs in preview window open/close
map <F9> :ALEHover<CR>
inoremap <F9> <C-o>:ALEHover<CR>
map <Leader>z <C-w>z

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
noremap <C-B> :ls<CR>:b<Space>
noremap gb <C-^>
noremap <Leader><Left> :bprev<CR>
noremap <Leader><Right> :bnext<CR>
noremap <Leader>, :bprev<CR>
noremap <Leader>. :bnext<CR>

" delete buffer without closing the window
noremap <Leader>x :Bdelete<CR>
noremap <Leader>X :Bdelete!<CR>
" close current window
noremap <Leader>q :q<CR>

" outdent with Shift+Tab
imap <S-Tab> <C-o><<
" create new file in same dir
map <expr><C-n> ':New ' . expand('%:h') . '/'
" search and replace
nmap <C-f> yiw:%s/<C-r>"//g<Left><Left>
vmap <C-f> :%s///g<Left><Left><Left>

" git (fugitive) maps
map <Leader>gd :Gdiffsplit<CR>
map <Leader>gb :Gblame<CR>

" open netrw/Explore (similar to NERDTree)
map <Leader>d :DrawerCwd<CR>
map <Leader>f :DrawerFind<CR>

" fzf and ripgrep maps

" list git files/files
map <C-p> :Ctrlp<CR>
map <Leader>p :Ctrlp<CR>
map <Leader>P :Files<CR>
" list buffers
map <Leader>b :Buffers<CR>
" list tags (current buffer / all)
map <Leader>t :BTags<CR>
map <Leader>T :Tags<CR>
" list lines (current buffer)
map <Leader>l :BLines<CR>
map <Leader>L :Lines<CR>
" list marks
map <Leader>m :Marks<CR>
" ripgrep search word under cursor, or selected
noremap <Leader>rg yiw:Rg <C-r>"
vnoremap <Leader>rg y:Rg <C-r>"
" paste word under cursor, or selected, in command mode
noremap <Leader>: yiw:<Space><C-r>"<Home>
vnoremap <Leader>: y:<Space><C-r>"<Home>

"""""""""""""""""""""""""""
" CUSTOM COMMANDS SECTION "
"""""""""""""""""""""""""""

command! -bang Bdelete if len(getbufinfo({'buflisted':1})) > 1 | bprev | bdelete<bang># | else | bdelete<bang> | endif

command! -nargs=1 -complete=dir New call mkdir(fnamemodify(<q-args>, ':h'), 'p') | edit <args>

command! Ctrlp execute (exists("*fugitive#head") && len(fugitive#head())) ? 'GFiles' : 'Files'

" file drawer
command! -nargs=? Drawer if winnr("$") == 1 | Vexplore <args>| else | 1 wincmd w | Explore <args> | endif
command! DrawerCwd execute 'Drawer' getcwd()
command! DrawerFind let @/=expand("%:t") | execute 'Drawer' expand("%:p:h") | normal n

" hextdump / reverse
command! Hexdump %!xxd
command! HexdumpReverse %!xxd -r

"""""""""""""""""""""
" FUNCTIONS SECTION "
"""""""""""""""""""""

" use a smaller viewport
function! WriteRoomToggle()
  let l:name = '_writeroom_'
  if bufwinnr(l:name) > 0
    only
  else
    let l:width = (&columns - &textwidth) / 5
    execute 'vert topleft' l:width . 'sview +setlocal\ nobuflisted' l:name | wincmd p
    execute 'vert botright' l:width . 'sview +setlocal\ nobuflisted' l:name | wincmd p
    endif
endfunction

" keep previously yanked texts in 1-9 registers
" https://vi.stackexchange.com/a/26883/26095
function! SaveLastReg()
  if v:event['regname']==""
    if v:event['operator']=='y'
      for i in range(8,1,-1)
        execute "let @".string(i+1)." = @". string(i)
      endfor
      if exists("g:last_yank")
        let @1=g:last_yank
      endif
      let g:last_yank=@"
    endif
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
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END

augroup YankStore
  autocmd TextYankPost * call SaveLastReg()
augroup END

augroup SessMngr
  let IsStdIn = 0
  autocmd!
  autocmd StdinReadPost * let IsStdIn = 1
  autocmd VimLeave * call SaveSess()
  autocmd VimEnter * nested if !argc() && !IsStdIn | call RestoreSess() | endif
augroup END

" disable unsafe commands in project-specific .vimrc files
set secure
