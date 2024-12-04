return {
  "luisiacc/the-matrix.nvim",
  config = function()
    vim.g.thematrix_keyword_style = "NONE" -- italic, NONE

    require("thematrix.theme").setup()
  end,
}
