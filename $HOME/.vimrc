" Vundle install and config
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'DavidEGx/ctrlp-smarttabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'editorconfig/editorconfig-vim'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'wakatime/vim-wakatime'

" Languages syntax
Plugin 'elixir-lang/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Airline config
set t_Co=256
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='silver'

" ---------------------------------------------------------------------
" Based on .vimrc from http://arthurfurlan.org/dotfiles/vimrc.txt

"set nu                  " add line numbers
set ruler               " show cursor position
set title               " show filename on title bar
set t_vb=               " no bell
"set termencoding=utf8   " all files are utf8
"set nobackup            " don't write ~* backup files
set fdm=marker          " folding
"set tw=80               " text width

set bs=2                " same as :set backspace=indent,eol,start
set sm                  " color matching braces/parenthesis
set ai cindent sw=2     " indentation
"set is ic              " search
set et st=2 ts=2        " TAB width
retab                   " use spaces for Tabs
syntax on
set noautoindent

" background color (light|dark)
set background=dark

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

" nerdtree keymaps
map <C-k><C-b> :NERDTreeToggle<CR>
map <S-C-r> :NERDTreeFind<CR>

" tabs/buffers keymaps (Note: Leader=\ by default)
map <Leader>f :tabfirst<CR>
map <Leader>l :tablast<CR>
map <Leader>p :tabprev<CR>
map <Leader><Left> :tabprev<CR>
map <Leader>n :tabnext<CR>
map <Leader><Right> :tabnext<CR>

" navigate in buffers
map <Leader><Up> :bprev<CR>
map <Leader><Down> :bnext<CR>
map <Leader>q :bdelete<CR>

" list buffers/tabs in CtrlP
map <C-b> :CtrlPBuffer<CR>
map <C-t> :CtrlPSmartTabs<CR>

" Git commands
map <C-g>b :Git blame %<CR>
map <C-g>d :Git diff %<CR>

" aliases to prevent typos in close commands
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq
