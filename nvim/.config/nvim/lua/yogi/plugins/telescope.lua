return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			local function is_in_flutter_example()
				local cwd = vim.fn.getcwd()
				return string.match(cwd, "example$")
			end

			local find_command = {
				"fd",
				"--type",
				"f",
				"--hidden",
				"--follow",
				"--exclude",
				".git",
				"--search-path",
				".",
			}

			if is_in_flutter_example() then
				table.insert(find_command, "--search-path")
				table.insert(find_command, "..")
			end

			telescope.setup({
				pickers = {
					find_files = {
						find_command = find_command,
					},
				},
				defaults = {
					path_display = { "smart" },
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help tags" })

			require("telescope").load_extension("ui-select")
		end,
	},
}
