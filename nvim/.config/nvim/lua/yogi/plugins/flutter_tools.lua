return {
	"akinsho/flutter-tools.nvim",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local flutter_tools = require("flutter-tools")

		flutter_tools.setup({
			debugger = {
				enabled = true,
				run_via_dap = true,
			},
			flutter_path = vim.fn.expand("$HOME/fvm/versions/3.22.3/bin/flutter"),
			fvm = true,
			outline = { auto_open = false },
			decoration = {
				statusline = {
					device = true,
					app_version = true,
				},
			},
			widget_guides = { enabled = true },
			dev_log = { enabled = true, open_cmd = "tabedit" },
			lsp = {
				color = {
					enabled = true,
					background = false,
					virtual_text = true,
				},
				settings = {
					showtodos = true,
					renameFilesWithClasses = "prompt",
				},
			},
			register_configurations = function(_)
				require("dap").configurations.dart = {} -- This line clears the default configurations
			end,
		})
	end,
}
