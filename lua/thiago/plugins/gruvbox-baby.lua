return {
  "luisiacc/gruvbox-baby",
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox-baby",
      callback = function()
        vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#83c07c", bold = false })
      end,
    })
  end,
}
