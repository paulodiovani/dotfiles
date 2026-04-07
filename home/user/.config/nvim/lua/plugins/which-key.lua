return {
  "folke/which-key.nvim",
  version = "~3",
  event = "VeryLazy",
  opts = {
    delay = 1000, -- milliseconds
    preset = "helix",
    keys = {
      scroll_down = "<S-Down>", -- binding to scroll down inside the popup
      scroll_up = "<S-Up>", -- binding to scroll up inside the popup
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
