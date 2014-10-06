
"                            .vimrc
"
" ---------------------------------------------------------------------
"
"   created by Arthur Furlan <arthur.furlan@gmail.com> on 2006-12-01
"                        use it by your own risk!
"
" ---------------------------------------------------------------------
"
"               http://arthurfurlan.org/dotfiles/vimrc.txt

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
set et st=4 ts=4        " configura o TAB
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

" background color (light|dark)
set background=dark

" aliases uteis para fechar o vim
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq| cab X x| cab Wqw wq| cab wqw wq
