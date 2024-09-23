return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  event = "BufWinEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    config = function()
      local harpoon = require("harpoon")

      harpoon:setup({
        global_settings = {
          mark_barnch = true
        },
      })

      vim.keymap.set("n", "<leader>ha", function()
        print("Added " .. vim.fn.expand("%:p") .. " to harpoon")
        harpoon:list():add()
      end)

      vim.keymap.set("n", "<leader>hc", function()
        print("Clearing harpoon")
        harpoon:list():clear()
      end)

      vim.keymap.set("n", "<leader>h1", function()
        harpoon:list():select(1)
      end)

      vim.keymap.set("n", "<leader>h2", function()
        harpoon:list():select(2)
      end)

      vim.keymap.set("n", "<leader>h3", function()
        harpoon:list():select(3)
      end)

      vim.keymap.set("n", "<leader>h4", function()
        harpoon:list():select(4)
      end)

      vim.keymap.set("n", "<leader>h5", function()
        harpoon:list():select(5)
      end)

      vim.keymap.set("n", "<leader>h6", function()
        harpoon:list():select(6)
      end)

      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)

      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)

      local telescope_conf = require("telescope.config").values

      local function toggle_telescope(harpoon_files)
        local file_paths = {}

        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
            .new({}, {
              prompt_title = "Harpoon",
              finder = require("telescope.finders").new_table({
                results = file_paths,
              }),
              previewer = telescope_conf.file_previewer({}),
              sorter = telescope_conf.generic_sorter({}),
            })
            :find()
      end

      vim.keymap.set("n", "<leader>he", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Open harpoon window" })
    end,
  },
}
