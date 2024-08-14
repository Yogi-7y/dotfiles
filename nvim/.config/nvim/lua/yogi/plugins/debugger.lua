return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

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
        name = "Launch Dart",
        dartSdkPath = "/opt/homebrew/bin/dart",
        program = "${workspaceFolder}/bin/nvim_dart_playground.dart",
        cwd = "${workspaceFolder}",
      },
    }

    dap.adapters.dart = {
      type = "executable",
      command = "dart",
      args = { "debug_adapter" },
    }

    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", dap.continue, {})
    vim.keymap.set("n", "<leader>dr", dap.repl.open, {})
  end,
}
