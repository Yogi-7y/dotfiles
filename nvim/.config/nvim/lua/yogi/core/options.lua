local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"

-- Fold
opt.foldmethod = "indent"
opt.foldenable = false

opt.clipboard:append("unnamedplus") -- Use system clipboard

opt.laststatus = 3
opt.splitkeep = "screen"

opt.spell = true
