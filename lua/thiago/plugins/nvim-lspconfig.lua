return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim",                   opts = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = require('thiago.core.lsp').on_attach,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    vim.lsp.inlay_hint.enable()

    mason_lspconfig.setup_handlers({
      function(server_name)
        if server_name == "tsserver" then
          server_name = "ts_ls"
        end

        lspconfig[server_name].setup({ capabilities = capabilities })
      end,
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
          },
        })
      end,
      ["ts_ls"] = function()
        lspconfig["ts_ls"].setup({
          capabilities = capabilities,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all", -- "none" | "literals" | "all"
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        })
      end,
      ["gopls"] = function()
        lspconfig["gopls"].setup({
          capabilities = capabilities,
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = true,
                functionTypeParameters = false,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
              hint = {
                enable = true,
                arrayIndex = "Auto", -- "Enable", "Auto", or "Disable"
                await = true,
                paramName = "All",   -- "All", "Literal", or "Disable"
                paramType = true,
                semicolon = "Disable",
                setType = true,
              },
            },
          },
        })
      end,
    })
  end,
}
