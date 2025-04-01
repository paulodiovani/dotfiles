" Write Room
" creates a center window to focus on text

" toggle writeroom mode
nmap <silent><Leader><BS> :call WriteRoomToggle()<CR>

" use a smaller viewport
function! WriteRoomToggle()
  let l:params = 'buftype=nofile\ bufhidden=wipe\ nomodifiable\ nobuflisted\ noswapfile\ nocursorline\ nocursorcolumn\ nonumber\ norelativenumber\ noruler\ nolist\ noshowmode\ noshowcmd'
  let l:name = '__writeroom__'

  " make only window if writeroom is in use, of there is any vertical split
  if bufwinnr(l:name) > 0 || len(filter(range(1, winnr('$')), 'winwidth(v:val) != &columns')) > 0
    " focus on first non-writeroom window, if needed
    if bufname() == l:name
      let l:focus_window = filter(range(1, winnr('$')), 'bufname(winbufnr(v:val)) != l:name')[0]
      exec l:focus_window . 'wincmd w'
    endif
    only
  else
    " or create writeroom windows
    let l:min_columns = 130
    let l:width = (&columns - min_columns) / 2
    if l:width < 0
      return
    end
    execute 'vert topleft' l:width . 'sview +setlocal\' l:params l:name | wincmd p
    execute 'vert botright' l:width . 'sview +setlocal\' l:params l:name | wincmd p
  endif
endfunction
