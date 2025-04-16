-- Vim Test configuration
return {
  "vim-test/vim-test",
  config = function()
    -- vim-test config
    vim.cmd([[
      function! TerminalStrategy(cmd)
        exec 'Terminal ' . a:cmd
      endfunction

      let test#custom_strategies = {'terminal': function('TerminalStrategy')}
      let test#strategy = "terminal"
      let test#ruby#minitest#options = '--verbose'
      let test#ruby#rails#options = '--backtrace'
      let test#ruby#rspec#options = '--format doc'
      let test#python#pytest#options = '--verbosity=2'

      " mappings (in .vimrc)
      " map <F5> :TestFile<CR>                              " run tests for current file
      " map <leader><F5> :TestNearest<CR>                   " run tests nearest to cursor
    ]])
  end
}
