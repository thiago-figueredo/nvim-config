function SplitTerminal(direction)
  local win_id = vim.api.nvim_get_current_win()
  local term_size = 100

  if win_id ~= nil then
    local win_config = vim.api.nvim_win_get_config(win_id)

    if direction == "vertical" then
      term_size = win_config.width / 2
    else
      term_size = win_config.height / 2
    end
  end

  vim.api.nvim_command("ToggleTerm direction=" .. direction .. " size=" .. term_size)
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({ direction = "float" })

      vim.api.nvim_set_keymap(
        "n",
        "<leader>tt",
        "<cmd>lua require('toggleterm').toggle()<CR>",
        { noremap = true, silent = true, desc = "Toggle terminal" }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>tv",
        '<cmd>lua SplitTerminal("vertical")<CR>',
        { noremap = true, silent = true, desc = "Toggle terminal vertically" }
      )

      vim.api.nvim_set_keymap(
        "n",
        "<leader>th",
        '<cmd>lua SplitTerminal("horizontal")<CR>',
        { noremap = true, silent = true, desc = "Toggle terminal horizontally" }
      )
    end,
  },
}
