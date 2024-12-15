return {
  "luisiacc/the-matrix.nvim",
  config = function()
    vim.g.thematrix_keyword_style = "NONE" -- italic, NONE
    vim.g.thematrix_function_style = "NONE"

    require("thematrix.theme").setup()
  end,
}
