" Map Space as <Leader>
let mapleader = " "


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

" nerdtree show hidden files
let NERDTreeShowHidden=1


""""""""""""""""""""
" MAPPINGS SECTION "
""""""""""""""""""""

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq

" show/hide line numbers
nmap <leader># :set invnumber<CR>

" show/hide hidden chars
nmap <leader>h :set list!<CR>

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

" Run Syntax check
map <Leader>s :SyntasticCheck<CR>
" Location list settings
map <Leader>l :lnext<CR>
map <Leader>L :lprevious<CR>

" nerdtree keymaps
map <C-k><C-b> :NERDTreeToggle<CR>
imap <C-k><C-b> <C-O>:NERDTreeToggle<CR>
map <C-k><C-r> :NERDTreeFind<CR>
imap <C-k><C-r> <C-O>:NERDTreeFind<CR>

" tabs/buffers keymaps (Note: Leader=\ by default)
noremap <Leader><Left> :tabprev<CR>
noremap <Leader><Right> :tabnext<CR>

" navigate in buffers
noremap <Leader><Up> :bprev<CR>
noremap <Leader><Down> :bnext<CR>
noremap <Leader>bd :bdelete<CR>

" paste word under cursor in command mode
noremap <Leader>: bye: <C-r>"<Home>
" silver search word under cursor
noremap <Leader>ag bye:!ag <C-r>" 

" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
" map <C-t> :CtrlPSmartTabs<CR>

" show/hide minimap
map <Leader>mm :MinimapToggle<CR>


"""""""""""""""""""""
" FUNCTIONS SECTION "
"""""""""""""""""""""

" auto save/load sessions, unless already opened
fu! IsCurrentSess()
  let l:lines = readfile(getcwd() . '/Session.lock')
  return get(l:lines, 0) == getpid()
endfunction

fu! SaveSess()
  " write session only if exists
  if filewritable(getcwd() . '/Session.vim') && IsCurrentSess()
    execute 'mksession!' getcwd() . '/Session.vim'
    " remove lock file
    call delete(getcwd() . '/Session.lock')
  endif
endfunction

fu! RestoreSess()
  " restore if no args, session exists and not yet opened (no Session.lock)
  if argc() == 0 && filereadable(getcwd() . '/Session.vim') && !filewritable(getcwd() . '/Session.lock')
    " create a (pseudo) lockfile with the current session pid
    call writefile([getpid()], getcwd() . '/Session.lock', 's')
    " source session file
    execute 'so' getcwd() . '/Session.vim'
    " open buffers in new tabs
    execute 'tab sball'
  endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * nested call RestoreSess()
