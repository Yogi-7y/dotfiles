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
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			clear_on_continue = false,
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		})

		dapui.setup()

		local function open_dapui()
			dapui.open()
		end

		-- dap.listeners.before.attach.dapui_config = function()
		-- 	dapui.open()
		-- end
		--
		-- dap.listeners.before.launch.dapui_config = function()
		-- 	dapui.open()
		-- end

		dap.listeners.after.event_terminated.dapui_config = function()
			dapui.close({ force = true })
		end

		dap.listeners.after.event_exited.dapui_config = function()
			dapui.close({ force = true })
		end

		-- Flutter/Dart configuration
		dap.adapters.dart = {
			type = "executable",
			command = "dart",
			args = { "debug_adapter" },
		}

		dap.configurations.dart = {
			{
				type = "dart",
				request = "launch",
				name = "Launch Flutter",
				program = "${workspaceFolder}/lib/main.dart",
				cwd = "${workspaceFolder}",
			},
		}

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<leader>du", open_dapui, { desc = "Open DAP UI" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue debugging" })
		vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open debug REPL" })
		vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last debug configuration" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
	end,
}
