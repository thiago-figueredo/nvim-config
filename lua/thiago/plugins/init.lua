local plugins = {
  {
    "nvim-lua/plenary.nvim",
    event = "BufRead",
  },
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
  },
  "github/copilot.vim",
  "mg979/vim-visual-multi",
  "morhetz/gruvbox",
  "jnurmine/Zenburn",
  "alexmozaidze/palenight.nvim",
  "EdenEast/nightfox.nvim",
  "sainnhe/sonokai",
  "sainnhe/everforest",
  "jwalton512/vim-blade",
  "dhruvasagar/vim-open-url",
  "rockerBOO/boo-colorscheme-nvim",
  "JoosepAlviste/palenightfall.nvim",
  "jacoborus/tender.vim",
  "marko-cerovac/material.nvim",
}

local function load_custom_plugins(path)
  local handle = vim.loop.fs_scandir(path)

  if not handle then return plugins end

  while true do
    local name, type = vim.loop.fs_scandir_next(handle)

    if not name then break end

    if type == 'file' then
      table.insert(plugins, {
        path .. name,
        dir = path,
        name= name,
        config = function()
          local filename = vim.fn.fnamemodify(name, ':t:r')
          require('thiago.plugins.' .. path:gsub('/', '') .. '.' .. filename).setup()
        end
      })
    else
      load_custom_plugins(path .. "/" .. name)
    end
  end
end

load_custom_plugins("custom/")

return plugins
