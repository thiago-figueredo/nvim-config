return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      term_colors = true,
      no_italic = true,
      transparent_background = false,
    })

    vim.cmd("colorscheme catppuccin")
  end,
}
