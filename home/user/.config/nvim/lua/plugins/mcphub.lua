return {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "bundled_build.lua",
  opts = {
    use_bundled_binary = true,
    workspace = {
      enabled = true,
      look_for = { ".mcphub/servers.json", ".mcp.json", ".vscode/mcp.json", ".cursor/mcp.json" },
    },
  },
}
