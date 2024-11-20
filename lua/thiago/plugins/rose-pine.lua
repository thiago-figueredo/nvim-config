return {
  "rose-pine/neovim",
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "rose-pine-moon",
      callback = function()
        vim.api.nvim_set_hl(0, "@function.method.call", { fg = "#ea9a97" })
      end,
    })

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
  end,
}
