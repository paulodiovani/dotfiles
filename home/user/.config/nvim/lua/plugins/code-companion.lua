return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "paulodiovani/darkroom.nvim",
  },

  opts = {
    adapters = {
      opts = {
        show_defaults = false,
        show_model_choices = true,
      },

      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          formatted_name = "GitHub Copilot",
          schema = {
            model = {
              default = "claude-sonnet-4"
            },
          },
        })
      end,

      openrouter = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          formatted_name = "OpenRouter",
          env = {
            url = "https://openrouter.ai/api/v1",
            api_key = "OPENROUTER_API_KEY",
            chat_url = "/chat/completions",
            models_endpoint = "/models"
          },
          schema = {
            model = {
              default = "anthropic/claude-sonnet-4",
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

      diff = {
        provider = "default",
      },
    },

    strategies = {
      chat = {
        adapter = "copilot",
        keymaps = {
          debug = { modes = { n = 'gD' } },
          next_chat = { modes = { n = '<A-Right>' } },
          previous_chat = { modes = { n = '<A-Left>' } },
        },
        roles = {
          llm = function(adapter)
            local name = adapter.formatted_name
            if (adapter.model and adapter.model.name) then
              name = name .. " (" .. adapter.model.name .. ")"
            end
            return name
          end,
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

    prompt_library = require("modules.codecompanion.prompt-library"),
  },

  keys = {
    { "<Leader>ca", "<Cmd>CodeCompanionActions<CR>",                   mode = { "n", "v" } },
    { "<Leader>cc", "<Cmd>DarkRoomReplaceRight CodeCompanionChat<CR>", mode = { "n", "v" } },
    { "<Leader>cl", ":CodeCompanion ",                                 mode = { "v" },     desc = "Code Companion Inline" },
  },

  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },

  init = function()
    require("modules.codecompanion.fidget-spinner"):init()
  end,
}
