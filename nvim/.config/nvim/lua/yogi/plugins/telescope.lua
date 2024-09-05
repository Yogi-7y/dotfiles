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

      telescope.setup({

        defaults = {
          path_display = { "smart" },
          file_ignore_patterns = { ".git", "node_modules", "vendor" },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            hidden = true,
          },
          live_grep = {
            theme = "dropdown",
          },
          buffers = {
            theme = "dropdown",
          },
          help_tags = {
            theme = "dropdown",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Find help tags" })

      require("telescope").load_extension("ui-select")
    end,
  },
}
