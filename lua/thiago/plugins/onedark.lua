return {
  "navarasu/onedark.nvim",
  config = function()
    require("onedark").setup({
      lualine = {
        transparent = true,
      },
    })
  end,
}
