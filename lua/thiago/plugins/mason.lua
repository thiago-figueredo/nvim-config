return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")

    mason.setup({
      ensure_installed = {
        "tsserver",
        "lua_ls",
        "gopls",
        "clangd",
        "rust_analyzer",
        "pyright"
      },
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
  end,
}
