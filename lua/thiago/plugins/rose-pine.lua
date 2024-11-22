return {
  "rose-pine/neovim",
  config = function()
    require("rose-pine").setup({
      variant = "main",
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
      },
      highlight_groups = {
        ["@variable.parameter"] = { fg = "#f9cc9d" },
        ["@function.method.call"] = { fg = "#ebbcba" },
      },
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    })

    vim.cmd("colorscheme rose-pine")
  end,
}
