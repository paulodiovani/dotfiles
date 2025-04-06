-- luacheck: globals vim
require('lua-utils')

----------------------
-- SETTINGS SECTION --
----------------------

-- diagnostics config
vim.diagnostic.config({
  virtual_text = false,
  float = {
    header = false,
    border = 'rounded',
    source = true,
    format = function(diagnostic)
      local source = diagnostic.source or 'lsp'
      local href = safe_get(diagnostic, 'user_data', 'lsp', 'codeDescription', 'href')
        or (
          diagnostic.code
            and string.format('https://google.com/search?q=%s+%s', diagnostic.source or '', diagnostic.code)
          or ''
        )
      return string.format('%s\n[%s] %s', diagnostic.message, source, href)
    end,
  },
})

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

require("lazy").setup("plugins")

------------------------------
-- CUSTOM FUNCTIONS SECTION --
------------------------------

vim.g.diagnostics_active = true

-- toggle diagnostics
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end

----------------------
-- INCLUDED CONFIGS --
----------------------
--require 'completion'
--require 'copilot-config'
--require 'copilot-chat-completion'
--require 'file-drawer'
