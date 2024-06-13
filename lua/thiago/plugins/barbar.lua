return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config = function()
		require("barbar").setup({})

		vim.keymap.set("n", "<S-x>", "<cmd>BufferClose<CR>", { desc = "Close current buffer" })
		vim.keymap.set("n", "<S-l>", "<cmd>BufferNext<CR>", { desc = "Go to next buffer" })
		vim.keymap.set("n", "<S-h>", "<cmd>BufferPrevious<CR>", { desc = "Go to previous buffer" })

		for i = 1, 9 do
			vim.keymap.set(
				"n",
				"<leader>" .. i,
				"<cmd>BufferGoto " .. i .. "<CR>",
				{ desc = "(Barbar) Go to buffer " .. i }
			)
		end
	end,
}
