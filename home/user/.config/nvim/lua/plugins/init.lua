return {
  -- custom plugins config
  { import = "plugins.treesitter" },
  { import = "plugins.null-ls" },
  { import = "plugins.completion" },
  { import = "plugins.copilot" },
  { import = "plugins.file-drawer" },
  -- other plugins
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "editorconfig/editorconfig-vim" },
  { "tomtom/tcomment_vim" },
  { "tpope/vim-fugitive" },
  { "christoomey/vim-conflicted" },
  { "itchyny/lightline.vim" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-rhubarb" },
  { "lfv89/vim-interestingwords" },
  { "kshenoy/vim-signature" },
  { "mengelbrecht/lightline-bufferline" },
  { "Yggdroot/indentLine" },
  { "ajorgensen/vim-markdown-toc" },
  { "mattn/emmet-vim" },
  { "tinted-theming/base16-vim",
    lazy = false,
    config = function()
        vim.cmd("source " .. vim.fn.expand("$HOME/.config/vim/syntax.vim"))
    --   local theme_file = vim.fn.expand("$HOME/.config/tinted-theming/set_theme.lua")
    --   if vim.fn.filereadable(theme_file) == 1 then
    --       vim.g.tinted_colorspace = 256
    --       dofile(theme_file)
    --   end
    end
  },
  { "daviesjamie/vim-base16-lightline" },
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },
  { "CopilotC-Nvim/CopilotChat.nvim" },
  { "vim-test/vim-test" },
  { "AndrewRadev/linediff.vim" },
  { "paulodiovani/vim-writeroom",
    dependencies = {
      "tinted-theming/base16-vim",
    }
  },
}
