return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", ":Git<CR>", { desc = "Open git status in a horizontal split" })
		vim.keymap.set("n", "<leader>gr", function()
			print("TODO: Implement git restore file in current line")
			local current_line = vim.api.nvim_get_current_line()
			local filepath = string.match(current_line, " (.+)")

			-- TODO: if the file is staged then use `git restore --staged`
			--       if the file is not staged then use `git restore`
			vim.cmd("Git restore " .. filepath)
		end, { desc = "Restore file in the current line or files selected in visual mode" })
	end,
}
