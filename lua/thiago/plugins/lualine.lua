return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")

    lualine.setup({
      options = {
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = ' ', right = ' ' },
      },
      sections = {
        lualine_a = { "mode"},
        lualine_b = { "branch", "diff", "diagnostics"},
        lualine_c = {
          { "filename", path = 3},
        },
        lualine_x = { "encoding", "filetype", "filesize"},
        lualine_y = {
          { "datetime", style = "%Y-%m-%d %H:%M:%S %p"},
        },
        lualine_z = { "progress", "location"},
      },
    })
  end,
}
