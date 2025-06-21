return {
  "echasnovski/mini.diff",

  config = function()
    local diff = require("mini.diff")
    diff.setup({
      -- Disabled by default
      -- USed only by CodeCompanion
      source = diff.gen_source.none(),
    })
  end,
}
