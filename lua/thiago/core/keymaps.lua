vim.g.mapleader = " "

local keymap = vim.keymap

-- General Keymaps -------------------
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Go half down page and center cursor" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Go half page up and center the cursor" })
keymap.set("v", "<", "<gv", { desc = "Ident tab left mutliple times in visual mode" })
keymap.set("v", ">", ">gv", { desc = "Ident tab right mutliple times in visual mode" })
keymap.set(
  "n",
  "gx",
  ':execute "silent!xdg-open ". shellescape(vim.fn.expand("<cWORD>"), 1)<cr>',
  { desc = "Open link under the cursor" }
)

-- Window management
keymap.set("n", "<leader>xv", "<cmd>vsplit <CR>", { desc = "Split vertically" })
keymap.set("n", "<leader>xh", "<cmd>split <CR>", { desc = "Split horizontally" })
keymap.set("n", "<leader>xc", "<cmd>close<CR>", { desc = "Close current split" })

-- File Explorer
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Save and quit
keymap.set("n", "<C-q>", "<CMD>q!<CR>", { desc = "Quit without saving" })
keymap.set("n", "<C-s>", "<CMD>w!<CR>", { desc = "Force write to file" })

-- Quick fix list
keymap.set("n", "<C-j>", "<CMD>cnext<CR>", { desc = "Move to next item in the quick fix list" })
keymap.set("n", "<C-k>", "<CMD>cprevious<CR>", { desc = "Move to previous item in the quick fix list" })
keymap.set("n", "<C-x>", function()
  local qflist = vim.fn.getqflist()
  local index = vim.fn.getqflist({ idx = 0 }).idx

  table.remove(qflist, index)

  vim.fn.setqflist(qflist)

  if #qflist == 0 then
    vim.cmd('cclose')
    return
  end

  vim.cmd('copen')

  if index > 1 then
    vim.cmd('cc ' .. index + 1)
  else
    vim.cmd('cc ' .. 1)
  end
end, { desc = "Remove item from quick fix list" })

-- Buffers
keymap.set("n", "<leader>bd", "<CMD>bd<CR>", { desc = "Delete current buffer" })

-- Vim dad bod
keymap.set("n", "<leader>zl", "normal 15zl", { desc = "Move 15 characters to left" })
keymap.set("n", "<leader>zh", "normal 15zh", { desc = "Move 15 characters to right" })
keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { desc = "[vim-dadboad-ui] Toggle Database UI" })

-- Git
keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "[vim-fuigitive] Open git status in a horizontal split" })
keymap.set("n", "<leader>hn", "<CMD>Gitsigns next_hunk<CR>", { desc = "[gitsigns] Go to next buffer hunk" })
keymap.set("n", "<leader>hp", "<CMD>Gitsigns prev_hunk<CR>", { desc = "[gitsigns] Go to previous buffer hunk" })
keymap.set("n", "<leader>hr", "<CMD>Gitsigns reset_hunk<CR>", { desc = "[gitsigns] Reset hunk" })
keymap.set("n", "<leader>hR", "<CMD>Gitsigns reset_buffer<CR>", { desc = "[gitsigns] Reset buffer" })
keymap.set("n", "<leader>hh", "<CMD>Gitsigns preview_hunk<CR>", { desc = "[gitsigns] Preview hunk" })
keymap.set("n", "<leader>hd", "<CMD>Gitsigns diffthis<CR>", { desc = "[gitsigns] Diff this buffer" })
keymap.set("n", "<leader>td", "<CMD>Gitsigns toggle_deleted<CR>", { desc = "[gitsigns] Toggle deleted" })

keymap.set("n", "<leader>mm", function()
  local messages = vim.api.nvim_exec2("messages", { output = true })
  local lines = require("thiago.core.helpers").split(messages.output, "\n")

  vim.cmd("split [messages]")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
end, { desc = "Show messages in a buffer" })

vim.keymap.set("n", "<leader>hi", function()
  require("lsp-inlayhints").toggle()
end, { noremap = true, silent = true, desc = "Toggle Inlay Hints" })
