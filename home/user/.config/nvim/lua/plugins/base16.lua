-- Base16 theme configuration
return {
  "tinted-theming/base16-vim",
  lazy = false,
  priority = 1000, -- Load theme early
  config = function()
    -- source the syntax settings and theme load
    vim.cmd("source " .. vim.fn.expand("$HOME/.config/vim/syntax.vim"))
  end
}
