return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },

  opts = {
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          name = "copilot",
          schema = {
            model = {
              default = "claude-3.7-sonnet"
            },
          },
        })
      end,
    },

    display = {
      chat = {
        show_header_separator = true,
        -- show_settings = true,
        window = {
          layout = "vertical",
          position = "right",
          -- width = 0.3,
          width = (vim.go.columns - 130) / 2,
        },
      },
    },

    send = {
      callback = function(chat)
        -- https://github.com/olimorris/codecompanion.nvim/discussions/640#discussioncomment-12866279
        vim.cmd("stopinsert")
        chat:submit()
        chat:add_buf_message({ role = "llm", content = "" })
      end,
      index = 1,
      description = "Send",
    },

    strategies = {
      chat = {
        adapter = "copilot",
        keymaps = {
          next_chat = { modes = { n = '<A-Right>' } },
          previous_chat = { modes = { n = '<A-Left>' } },
        },
      },
      inline = {
        adapter = "copilot",
      },
      cmd = {
        adapter = "copilot",
      }
    },

    opts = {
      ---@param opts table
      ---@return string
      system_prompt = function(opts)
        local language = opts.language or "English"

        local prompt_file = io.open(vim.env.HOME .. "/.config/nvim/assets/codecompanion-system-prompt.md", "r")
        local prompt_content = prompt_file and prompt_file:read("*a") or ""
        if prompt_file then prompt_file:close() end

        return string.format(
          prompt_content,
          language
        )
      end,
    },
  },

  keys = {
    {
      "<Leader>cc",
      "<Cmd>DarkRoomReplaceRight CodeCompanionChat<CR>",
      mode = { "n", "v" },
      desc = "Code Companion right window",
      silent = true
    },
  },

  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },

  config = function(_, opts)
    require("codecompanion").setup(opts)
    require("modules.codecompanion-spinner"):init()
  end
}
