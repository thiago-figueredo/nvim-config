return {
	"projekt0n/github-nvim-theme",
	config = function()
		require("github-theme").setup({
			options = {
				transparent = true,
			},
		})

		vim.cmd("colorscheme github_dark_dimmed")
	end,
}
