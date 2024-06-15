return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 0,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
		})

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = vim.api.nvim_get_current_buf()
			vim.keymap.set(mode, l, r, opts)
		end
	end,
}
