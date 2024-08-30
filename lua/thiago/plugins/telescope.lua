return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        hidden = true,
        path_display = { "truncate" },
        layout_strategy = "vertical",
        layout_config = {
          horizontal = {
            preview_width = 0,
          },
          vertical = {
            mirror = false,
            preview_cutoff = 0.5,
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[telescope] [S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sc", builtin.command_history, { desc = "[telescope] [S]earch [C]ommand history" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[telescope] [S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sa", builtin.git_stash, { desc = "[telescope] [S]earch Git stash" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[telescope] [S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[telescope] [S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[telescope] [S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[telescope] [S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[telescope] [S]earch [R]esume" })
    vim.keymap.set("n", "<leader>ss", builtin.git_status, { desc = "[telescope] [S]earch file in git [S]tatus" })
    vim.keymap.set(
      "n",
      "<leader>s.",
      builtin.oldfiles,
      { desc = '[telescope] [S]earch Recent Files ("." for repeat)' }
    )
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[telescope] Find existing buffers" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[telescope] [S]earch [F]iles" })

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
        layout_config = {
          width = 150
        },
      }))
    end, { desc = "[telescope] [/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
    end, { desc = "[telescope] [S]earch [/] in Open Files" })

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[telescope] [S]earch [N]eovim files" })

    vim.keymap.set("n", "<leader>su", "<cmd>Telescope undo<cr>", { desc = "[telescope] [S]earch [U]ndo history" })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
    pcall(require("telescope").load_extension, "undo")
  end,
}
