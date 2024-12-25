return {
  "thiago-figueredo/present.nvim",
  config = function()
    vim.keymap.set("n", "<leader>p", function()
      require('present').start_presentation({
        width = vim.api.nvim_win_get_width(0),
        height = vim.api.nvim_win_get_height(0),
        circular_slide = true
      })
    end, { noremap = true, silent = true })
  end,
}
