" vim-test config
function! TerminalStrategy(cmd)
  exec 'Terminal ' . a:cmd
endfunction
let test#custom_strategies = {'terminal': function('TerminalStrategy')}
let test#strategy = "terminal"
let test#ruby#minitest#options = '--verbose'
let test#ruby#rspec#options = '--format doc'
let test#python#pytest#options = '--verbosity=1'

" mappings (in .vimrc)
" map <F5> :TestFile<CR>                              " run tests for current file
" map <leader><F5> :TestNearest<CR>                   " run tests nearest to cursor
