vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end
})

local colorscheme = "gruvbox"

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "trouble",
  callback = function()
    vim.cmd("colorscheme " .. colorscheme)
  end,
})

vim.api.nvim_create_augroup("GoFileColorscheme", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "rose-pine-moon",
  callback = function()
    vim.api.nvim_set_hl(0, "@function.method.call", { fg = "#ea9a97" })
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.schedule(function()
      local harpoon = require("harpoon")
      local harpoon_items = harpoon:list().items
      local neovim_args = vim.fn.argv()
      local filepath = neovim_args[1]

      if not filepath then
        return
      end

      local _, end_idx = filepath:find("://")

      if not end_idx then
        return
      end

      filepath = filepath:sub(end_idx + 1)

      if filepath ~= vim.fn.getcwd() .. '/' then
        return
      end

      for _, item in ipairs(harpoon_items) do
        if io.open(item.value) ~= nil then
          vim.cmd('edit ' .. item.value)
          vim.api.nvim_win_set_cursor(0, { item.context.row, item.context.col })
        end
      end
    end)
  end,
})
