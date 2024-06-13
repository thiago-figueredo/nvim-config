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
keymap.set("n", "<leader>xc", "<cmd>close<CR>", { desc = "Close current split" })

-- File Explorer
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Toggle terminal background transparency
keymap.set("n", "<leader>xt", "<CMD>TransparentToggle<CR>", { desc = "Toggle terminal background transparency" })

-- Save and quit
keymap.set("n", "<C-q>", "<CMD>q!<CR>", { desc = "Quit without saving" })
keymap.set("n", "<C-s>", "<CMD>w!<CR>", { desc = "Force write to file" })

-- Quick fix list
keymap.set("n", "<C-n>", "<CMD>cnext<CR>", { desc = "Move to next item in the quick fix list" })
keymap.set("n", "<C-p>", "<CMD>cprevious<CR>", { desc = "Move to previous item in the quick fix list" })

-- Vim dad bod

keymap.set("n", "zl", "normal 15zl", { desc = "Move 15 characters to left" })
keymap.set("n", "zh", "normal 15zh", { desc = "Move 15 characters to right" })
