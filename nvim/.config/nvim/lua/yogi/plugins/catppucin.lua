return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}
