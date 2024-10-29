" Keep a yank history on vim registers

" show registers and allow to paste from one of them
map <Leader>y :call PasteReg()<CR>

" show current register and allow to paste
" with a single key
function! PasteReg()
  " Display the registers
  execute 'reg'
  " Prompt the user to type the register
  echo "Type the register to paste: "
  let char = getchar()
  " Check if the Esc key is pressed
  if char == 27
    redraw
    return
  endif
  " Convert the character code to a string
  let reg = nr2char(char)
  " Clear the message by redrawing the screen
  redraw
  " Execute the put command with the chosen register
  execute 'put ' . reg
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

" auto save yank history
augroup YankStore
  autocmd TextYankPost * call SaveLastReg()
augroup END
