return {
  "comfysage/aki",
  config = function()
    require('aki').setup({
      -- transparent_background = false,
      -- contrast_dark = 'medium', -- 'hard'|'medium'|'soft'
      -- override_terminal = true,
      -- style = {
      --   search = { reverse = true },
      -- },
      -- overrides = {},
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "aki",
      callback = function()
        vim.api.nvim_set_hl(0, "@type", { fg = "#9bc2b1", bold = false })
      end,
    })
  end
}
