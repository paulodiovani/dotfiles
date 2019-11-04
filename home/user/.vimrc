" " Vundle install and config
" set nocompatible              " be iMproved, required
" filetype off                  " required
"
" " set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
"
" " Keep Plugin commands between vundle#begin/end.
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" " Plugin 'edkolev/tmuxline.vim'
" Plugin 'editorconfig/editorconfig-vim'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'DavidEGx/ctrlp-smarttabs'
" Plugin 'scrooloose/nerdtree'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'tomtom/tcomment_vim'
" " Plugin 'tpope/vim-fugitive'
" Plugin 'vim-syntastic/syntastic'
" " Plugin 'christoomey/vim-conflicted'
" " Plugin 'wakatime/vim-wakatime'
"
" " Languages syntax
" Plugin 'elixir-lang/vim-elixir'
"
" " All of your Plugins must be added before the following line
" call vundle#end()            " required
" filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" Map Space as <Leader>
let mapleader = " "

" General config
" Based on .vimrc from http://arthurfurlan.org/dotfiles/vimrc.txt
set nu                  " add line numbers
set ruler               " show cursor position
set title               " show filename on title bar
set titlestring=%t      " show only filename
set t_vb=               " no bell
"set termencoding=utf8   " all files are utf8
set nobackup            " don't write ~* backup files
set fdm=marker          " folding
"set tw=80               " text width
set bs=2                " same as :set backspace=indent,eol,start
set sm                  " color matching braces/parenthesis
set ai cindent sw=2     " indentation
"set is ic              " search
set et st=2 ts=2        " TAB width
retab                   " use spaces for Tabs
set noautoindent

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

" GUI settings (gvim only)
set guifont=Source\ Code\ Pro\ Regular\ 11

" hide menu and toolbar
" :set guioptions -=m
:set guioptions -=T

" Airline config
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='one'

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

map <Leader>s :SyntasticCheck<CR>
map <Leader>ss :SyntasticCheck<CR>
map <Leader>st :SyntasticToggleMode<CR>

" Location list settings
map <Leader>lo :lopen<CR>
map <Leader>lc :lclose<CR>
map <Leader>ln :lnext<CR>
map <Leader>l :lnext<CR>
map <Leader>ll :lnext<CR>
map <Leader>lp :lprevious<CR>
map <Leader>L :lprevious<CR>
map <Leader>lL :lprevious<CR>
map <Leader>LL :lprevious<CR>

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

" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
map <C-t> :CtrlPSmartTabs<CR>
