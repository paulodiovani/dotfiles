-- Base16 theme configuration
return {
  "tinted-theming/tinted-vim",
  lazy = false,
  priority = 1000, -- Load theme early
  commit = 'dfc1d89',
  init = function()
    -- source the syntax settings and theme load
    vim.cmd("source " .. vim.fn.expand("$HOME/.config/vim/syntax.vim"))
  end
}
