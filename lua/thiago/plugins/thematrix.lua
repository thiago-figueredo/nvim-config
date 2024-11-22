return {
  "luisiacc/the-matrix.nvim",
  config = function()
    vim.g.thematrix_keyword_style = "italic" -- italic, NONE

    require("thematrix.theme").setup()
  end,
}
