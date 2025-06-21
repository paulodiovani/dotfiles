return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
    "echasnovski/mini.diff",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "paulodiovani/vim-darkroom",
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
              default = "claude-3.7-sonnet"
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
              default = "anthropic/claude-3.7-sonnet",
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
        provider = "mini_diff",
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

        keymaps = {
          accept_change = {
            modes = { n = "do" },
            description = "Diff obtain: Accept the suggested change",
          },
          reject_change = {
            modes = { n = "dr" },
            description = "Diff reject: Reject the suggested change",
          },
        },
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

    prompt_library = {
      ["Add documentation to this code or function"] = {
        strategy = "chat",
        description = "Create documentation for this code and update the buffer",
        opts = {
          auto_submit = true,
          -- ignore_system_prompt = true,
          is_slash_cmd = true,
          short_name = "document",
          adapter = {
            name = "copilot",
            model = "claude-3.7-sonnet",
          },
        },
        prompts = {
          {
            role = "user",
            content =
            [[#buffer
#buffer
@editor

Add documentation to the selected code or function.
Include argument and return types and examples in docs.
Be succinct.
Do not add comments to variables or single line expressions.
            ]],
          },
        },
      },

      ["Review this article"] = {
        strategy = "chat",
        description = "Review this blog post for typos, errors, or redundancy.",
        opts = {
          auto_submit = true,
          -- ignore_system_prompt = true,
          is_slash_cmd = true,
          short_name = "review-article",
          adapter = {
            name = "copilot",
            model = "gemini-2.5-pro",
          },
        },
        prompts = {
          {
            role = "user",
            content =
            [[#buffer
Review this blog post for:
- typos
- english semantic errors
- redundant sentences
- incorrect use of words

Then provide suggestions to fix or improve these issues.

Follow these rules:
- make small changes, words, not entire paragraphs
- do not change tone or writing style
- ignore the use of double dashes (`--`) for separation of sentences
- explain the changes.
            ]],
          },
        },
      },
    },
  },

  keys = {
    { "<Leader>ca", "<Cmd>CodeCompanionActions<CR>", mode = { "n", "v" } },
    {
      "<Leader>cc",
      "<Cmd>DarkRoomReplaceRight CodeCompanionChat<CR>",
      mode = { "n", "v" },
      desc = "Code Companion right window",
      silent = true
    },
    { "<Leader>cl", ":CodeCompanion ",               mode = { "v" },     desc = "Code Companion Inline" },
  },

  cmd = {
    "CodeCompanion",
    "CodeCompanionActions",
    "CodeCompanionChat",
    "CodeCompanionCmd",
  },

  init = function()
    require("modules.codecompanion.fidget-spinner"):init()

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
    -- use darkroom highlight
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionChatCreated",
      group = group,
      callback = function()
        vim.cmd [[
          set winhighlight=Normal:DarkRoomNormal
        ]]
      end,
    })
  end,
}
