return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()

      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-nh", "-q", "--interpreter=dap", "--eval-command", "set print pretty on", "./bin/debug" }
      }

      dap.configurations.c = {
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          stopAtEntry = true,
          program = function()
            return {
              executable_path = vim.fn.getcwd() .. '/'
            }
          end,
        }
      }

      vim.keymap.set("n", "<space>db", dap.toggle_breakpoint, { desc = "[DAP] Toggle breakpoint" })
      vim.keymap.set("n", "<space>dd", dap.run_to_cursor, { desc = "[DAP] Run to cursor" })

      vim.keymap.set("n", "<space>?", function()
        ui.eval(nil, { enter = true })
      end, { desc = "[DAP] Eval var under cursor" })

      vim.keymap.set("n", "<leader>du", ui.close, { desc = "[DAP] Close UI" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[DAP] Continue" })
      vim.keymap.set("n", "<leader>ds", dap.step_into, { desc = "[DAP] Step into" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "[DAP] Step over" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "[DAP] Step out" })
      vim.keymap.set("n", "<leader>dp", dap.step_back, { desc = "[DAP] Step back" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[DAP] Restart" })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
