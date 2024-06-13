return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({ direction = "float" })
			-- require("toggleterm").setup({ direction = "vertical", size = 80 })
			-- require("toggleterm").setup({ direction = "horizontal", shade_terminals = false })

			vim.api.nvim_set_keymap(
				"n",
				"<leader>t",
				"<cmd>lua require('toggleterm').toggle()<CR>",
				{ noremap = true, silent = true, desc = "Toggle terminal" }
			)
		end,
	},
}
