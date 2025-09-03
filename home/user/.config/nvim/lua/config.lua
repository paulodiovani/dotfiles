-- luacheck: globals vim
require('modules.diagnostics')

----------------------
-- SETTINGS SECTION --
----------------------

-- lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = {
    -- version = "*", -- use latest tagged version
  },
  dev = {
    path = "~/Development/Vim",
    patterns = { "paulodiovani" },
    fallback = true,
  },
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
})
