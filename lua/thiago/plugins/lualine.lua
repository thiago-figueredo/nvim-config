return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		lualine.setup({
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", path = 1 },
				},
				lualine_x = { "encoding", "fileformat", "filetype", "filesize", "searchcount" },
				lualine_y = {
					{ "datetime", style = "%Y-%m-%d %H:%M:%S %p" },
				},
				lualine_z = { "location" },
			},
		})
	end,
}
