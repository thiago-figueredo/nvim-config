local M = {}

function M.setup_handlers(handlers)
  for server_name, config in pairs(handlers) do
    if type(config) == "table" then
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = config.filetypes,
        callback = function(event)
          if not config.cmd then
            vim.notify("\nNo cmd found for LSP client: " .. vim.inspect(config), vim.log.levels.ERROR)
            return
          end

          for i, cmd in ipairs(config.cmd) do
            config.cmd[i] = config.cmd[i]:gsub("~", vim.fn.expand("~"))
          end

          local client_id = vim.lsp.start(config)

          if not client_id then
            vim.notify("\nFailed to start LSP client: " .. vim.inspect(config), vim.log.levels.ERROR)
            return
          end

          if not vim.lsp.buf_attach_client(0, client_id) then
            vim.notify("\nFailed to attach LSP client: " .. vim.inspect(config), vim.log.levels.ERROR)
          end
        end
      })
    end
  end
end

function M.on_attach(ev)
  local helpers = require("thiago.core.helpers")
  local keymap = vim.keymap
  local opts = { buffer = ev.buf, silent = true }

  opts.desc = "Show LSP references"
  keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

  opts.desc = "Go to declaration"
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

  opts.desc = "Show LSP definitions"
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

  opts.desc = "Show LSP implementations"
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

  opts.desc = "Show LSP type definitions"
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

  opts.desc = "See available code actions"
  keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

  opts.desc = "Smart rename"
  keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  opts.desc = "Show buffer diagnostics"
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

  opts.desc = "Show line diagnostics"
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

  opts.desc = "Go to previous diagnostic"
  keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

  opts.desc = "Go to next diagnostic"
  keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

  opts.desc = "Show documentation for what is under cursor"
  keymap.set("n", "K", helpers.hover, opts)
end

return M
