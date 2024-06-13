return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]c", {
					noremap = true,
					callback = function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end,
					desc = "Go to next hunk in diff view or navigate next hunk",
				})

				map("n", "[c", {
					noremap = true,
					callback = function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end,
					desc = "Go to prev hunk in diff view or navigate prev hunk",
				})

				map("n", "<leader>hs", {
					noremap = true,
					callback = gitsigns.stage_hunk,
					desc = "Stage current hunk",
				})

				map("n", "<leader>hr", {
					noremap = true,
					callback = gitsigns.reset_hunk,
					desc = "Reset current hunk",
				})

				map("v", "<leader>hs", {
					noremap = true,
					callback = function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Stage selected lines as a hunk",
				})

				map("v", "<leader>hr", {
					noremap = true,
					callback = function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end,
					desc = "Reset selected lines as a hunk",
				})

				map("n", "<leader>hS", {
					noremap = true,
					callback = gitsigns.stage_buffer,
					desc = "Stage entire buffer",
				})

				map("n", "<leader>hu", {
					noremap = true,
					callback = gitsigns.undo_stage_hunk,
					desc = "Undo stage of current hunk",
				})

				map("n", "<leader>hR", {
					noremap = true,
					callback = gitsigns.reset_buffer,
					desc = "Reset entire buffer",
				})

				map("n", "<leader>hp", {
					noremap = true,
					callback = gitsigns.preview_hunk,
					desc = "Preview current hunk",
				})

				map("n", "<leader>hb", {
					noremap = true,
					callback = function()
						gitsigns.blame_line({ full = true })
					end,
					desc = "Show blame info for current line",
				})

				map("n", "<leader>tb", {
					noremap = true,
					callback = gitsigns.toggle_current_line_blame,
					desc = "Toggle blame info for current line",
				})

				map("n", "<leader>hd", {
					noremap = true,
					callback = gitsigns.diffthis,
					desc = "Diff this hunk",
				})

				map("n", "<leader>hD", {
					noremap = true,
					callback = function()
						gitsigns.diffthis("~")
					end,
					desc = "Diff this hunk against the working tree",
				})

				map("n", "<leader>td", {
					noremap = true,
					callback = gitsigns.toggle_deleted,
					desc = "Toggle deleted status of current hunk",
				})

				map({ "o", "x" }, "ih", {
					noremap = true,
					callback = function()
						vim.cmd(":<C-U>Gitsigns select_hunk<CR>")
					end,
					desc = "Select current hunk",
				})
			end,
		})
	end,
}
