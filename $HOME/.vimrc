" Vundle install and config
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
"Plugin 'wakatime/vim-wakatime'

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

" ---------------------------------------------------------------------
" Based on .vimrc from http://arthurfurlan.org/dotfiles/vimrc.txt

"set nu                  " enumera as linhas
set ruler               " mostra a posicao do cursor
set title               " mostra o nome do arquivo na barra de titulo
set t_vb=               " desabilita o alerta sonoro (chato)
"set termencoding=utf8   " define todos os arquivos ocmo UTF-8
"set nobackup            " nao grava os arquivos ~* de backup
set fdm=marker          " habilita o folding
"set tw=80               " text width

set bs=2                " mexe com o backspace mas nao lembro o que faz
set sm                  " colore chaves/parenteses casados
set ai cindent sw=4     " configura a identacao
"set is ic              " configura a busca
set et st=2 ts=2        " configura o TAB
retab                   " substitui os TAB's por espacos
syntax on               " habilita a colocaracao de sintaxe
set noautoindent

" atalho para embaralhar letras quando alguem estiver olhando
map <F8> ggVGg?

" atalho para retirar ^M do final das linhas
map <F2> :%s/\r//g<CR>

" atalho para ativar/desativar o modo paste
map <F10> :set paste<CR>
map <F11> :set nopaste<CR>
imap <F10> <C-O>:set paste<CR>
imap <F11> <nop>
set pastetoggle=<F11>

" atalhos para o nerdtree
map <C-k><C-b> :Explore!<CR>
map <S-C-r> :NERDTreeFind<CR>

" background color (light|dark)
set background=dark

" aliases uteis para fechar o vim
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq
