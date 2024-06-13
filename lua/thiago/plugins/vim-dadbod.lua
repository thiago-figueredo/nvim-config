local function run_query()
	local filepath = ".env"
	local env_file = io.open(filepath, "r")

	if env_file then
		print("reading file")
		local env = env_file:read("*a")

		print(env)
		env_file:close()
	else
		print("ERROR: could not read" .. filepath)
	end

	-- vim.cmd(opts.scheme ":://" . opts.username . ":" . opts.password . "@" . opts.host . "/" . opts.database)
end

return {
	"tpope/vim-dadbod",
	config = function()
		vim.keymap.set("n", "<leader>q", ":DB biztrip_dev", { desc = "Run database query" })
	end,
}
