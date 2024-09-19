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
				exception_breakpoints = {},
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
			project_config = {
				enabled = true,
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
					onlyAnalyzeProjectsWithOpenFiles = true,
					analysisExcludedFolders = {
						"build",
						".dart_tool",
						".idea",
						".pub",
						".vscode",
						vim.fn.expand("$HOME/.pub-cache"),
					},
					lineLength = (function()
						local path = vim.fn.expand("%:p")
						return path:find("^/Users/yogi") and 100 or 80
					end)(),
				},
			},
			register_configurations = function(_)
				require("dap.ext.vscode").load_launchjs()
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>fr", "<Cmd>FlutterRun<CR>", { desc = "Run Flutter" })
	end,
}
