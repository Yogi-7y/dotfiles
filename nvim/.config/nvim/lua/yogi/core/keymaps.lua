vim.g.mapleader = " "

local keymap = vim.keymap

-- Navigate vim panes
keymap.set('n', '<c-k>', ':wincmd k<CR>')
keymap.set('n', '<c-j>', ':wincmd j<CR>')
keymap.set('n', '<c-h>', ':wincmd h<CR>')
keymap.set('n', '<c-l>', ':wincmd l<CR>')

keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = "Clear search highlights" })
