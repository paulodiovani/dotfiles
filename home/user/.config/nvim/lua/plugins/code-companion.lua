return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "paulodiovani/darkroom.nvim",
    "ravitemer/codecompanion-history.nvim",
    "ravitemer/mcphub.nvim",
  },
  version = "*",

  opts = {
    adapters = {
      acp = {
        opts = {
          show_presets = false,
        },

        claude_code = vim.env.CLAUDE_CODE_OAUTH_TOKEN and "claude_code",
      },

      http = {
        opts = {
          show_presets = false,
          show_model_choices = true,
        },

        copilot = "copilot",
        ollama = "ollama",

        openrouter = vim.env.OPENROUTER_API_KEY and function()
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
        provider = "split",
        provider_opts = {
          inline = {
            layout = "buffer",
          },
        },
      },
    },

    extensions = {
      history = {
        enabled = true,
        auto_save = true,
        expiration_days = 45,
        opts = {
          picker_keymaps = {
            rename = { n = "<F2>", i = "<C-r>" },
            delete = { n = "dd", i = "<C-d>" },
            duplicate = { n = "yyp", i = "<C-y>" },
          },
          title_generation_opts = {
            adapter = "copilot",
            model = "gpt-4o",
          },
        },
      },

      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true
        }
      }
    },

    prompt_library = require("modules.codecompanion.prompt-library"),

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

    rules = {
      opts = {
        chat = {
          autoload = { "default", "readme" },
          enabled = true,
        },
      },

      readme = {
        description = "Read the README.md file, if it exists",
        files = {
          "README.md",
        },
      },
    },
  },

  keys = {
    { "<Leader>ca", "<Cmd>CodeCompanionActions<CR>",                          mode = { "n", "v" } },
    { "<Leader>cn", "<Cmd>DarkRoomReplaceRight CodeCompanionChat<CR>",        mode = { "n", "v" } },
    { "<Leader>cc", "<Cmd>DarkRoomReplaceRight CodeCompanionChat Toggle<CR>", mode = { "n" } },
    { "<Leader>cc", "<Cmd>DarkRoomReplaceRight CodeCompanionChat Add<CR>",    mode = { "v" } },
    { "<Leader>cl", ":CodeCompanion ",                                        mode = { "v" } },
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
