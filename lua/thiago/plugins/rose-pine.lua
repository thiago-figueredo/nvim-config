return {
  "rose-pine/neovim",
  config = function()
    require("rose-pine").setup({
      variant = "main",
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
      },
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    })

    vim.cmd.highlight("@function.call gui=bold")
    vim.cmd("colorscheme rose-pine-main")
  end,
}
