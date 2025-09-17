return {
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
      },
    },
    prompts = {
      {
        role = "user",
        content =
        [[
#{buffer}
@{insert_edit_into_file}

Add documentation to the selected code or function.
Include argument and return types (but omit types for typescript).
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
      },
    },
    prompts = {
      {
        role = "user",
        content =
        [[
#{buffer}
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

  ["Write tests for this file"] = {
    strategy = "chat",
    description = "Write tests for this file or module following existing convention.",
    opts = {
      auto_submit = true,
      -- ignore_system_prompt = true,
      is_slash_cmd = true,
      short_name = "write-tests",
      adapter = {
        name = "copilot",
      },
    },
    prompts = {
      {
        role = "user",
        content =
        [[
#{buffer}
@{full_stack_dev}

Write tests for this file or module.

Follow these additional rules:
- Check for existing tests under common paths, such as `test/`, `spec/`, or `src/**/*.test.*`.
- Follow conventions stablished by existing tests, if any.
- Write minimal tests, covering only the most common logic paths.
- Use mocks for external libraries.
- Do not install any new packages.
- Do not try to run the tests.
        ]],
      },
    },
  }
}
