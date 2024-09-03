vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  desc = "Highlight selection on yank",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end
})

local current_day = os.date("%d")
local colorscheme = "gruvbox"

if current_day % 2 == 0 then
  colorscheme = "retrobox"
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.rs",
  callback = function()
    if colorscheme == "retrobox" then
      vim.treesitter.stop()
    end

    vim.cmd("colorscheme " .. colorscheme)
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = "trouble",
  callback = function()
    vim.cmd("colorscheme " .. colorscheme)
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.schedule(function()
      local harpoon = require("harpoon")
      local harpoon_items = harpoon:list().items

      for _, item in ipairs(harpoon_items) do
        vim.cmd('edit ' .. item.value)
        vim.api.nvim_win_set_cursor(0, { item.context.row, item.context.col })
      end
    end)
  end,
})
