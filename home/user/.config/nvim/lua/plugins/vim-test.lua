-- Vim Test configuration
return {
  "vim-test/vim-test",
  cmd = {
    "TestFile",
    "TestLast",
    "TestClass",
    "TestSuite",
    "TestVisit",
    "TestNearest",
  },
  keys = {
    -- also in .vimrc
    { '<F5>', ':TestFile<CR>', mode = { 'i', 'n', 'v' } },
    { '<Leader><F5>', ':TestNearest<CR>', mode = { 'i', 'n', 'v' } },
  },
  config = function()
    -- vim-test config
    vim.cmd([[
      function! TerminalStrategy(cmd)
        exec 'Terminal ' . a:cmd
      endfunction

      let test#custom_strategies = {'terminal': function('TerminalStrategy')}
      let test#strategy = "terminal"
      let test#javascript#vitest#options = '--silent=false'
      let test#python#pytest#options = '--verbosity=2'
      let test#ruby#minitest#options = '--verbose'
      let test#ruby#rails#options = '--verbose --backtrace'
      let test#ruby#rspec#options = '--format doc'
    ]])
  end
}
