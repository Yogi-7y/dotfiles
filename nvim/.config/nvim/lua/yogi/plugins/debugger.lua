return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    local virtual_text = require("nvim-dap-virtual-text")

    virtual_text.setup({
      enabled_commands = true,         -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
      highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
      highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
      show_stop_reason = true,         -- show stop reason when stopped for exceptions
      commented = false,               -- prefix virtual text with comment string
      only_first_definition = true,    -- only show virtual text at first definition (if there are multiple)
      all_references = false,          -- show virtual text on all all references of the variable (not only definitions)
      clear_on_continue = false,       -- clear virtual text on "continue" (might cause flickering when stepping)
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == "inline" then
          return " = " .. variable.value:gsub("%s+", " ")
        else
          return variable.name .. " = " .. variable.value:gsub("%s+", " ")
        end
      end,
      virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
      all_frames = false,   -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
      virt_lines = false,   -- show virtual lines instead of virtual text (will flicker!)
      virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
    })

    require("dapui").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end

    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.configurations.dart = {
      {
        type = "dart",
        request = "launch",
        name = "Launch Flutter",
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
      },
    }

    dap.adapters.dart = {
      type = "executable",
      command = "dart",
      args = { "debug_adapter" },
    }

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open debug REPL" })
    vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug configuration" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
  end,
}
