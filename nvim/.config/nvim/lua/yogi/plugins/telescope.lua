return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				defaults = {
					path_display = { "smart" },
					file_ignore_patterns = { ".git", "node_modules", "vendor" },
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Find help tags" })
			-- Inside the config function, modify the existing keymap or add a new one:

			vim.keymap.set("n", "<leader>ssd", function()
				builtin.find_files({
					prompt_title = "< Dart Files >",
					find_command = {
						"fd",
						"--type",
						"f",
						"--extension",
						"dart",
						"--exclude",
						"build",
						"--exclude",
						".dart_tool",
					},
				})
			end, { desc = "Search Dart Files" })

			require("telescope").load_extension("ui-select")
			telescope.load_extension("fzf")
		end,
	},
}
