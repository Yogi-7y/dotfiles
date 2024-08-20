vim.g.mapleader = " "

local keymap = vim.keymap

-- Navigate vim panes
keymap.set("n", "<c-k>", ":wincmd k<CR>", { desc = "Move to the pane above" })
keymap.set("n", "<c-j>", ":wincmd j<CR>", { desc = "Move to the pane below" })
keymap.set("n", "<c-h>", ":wincmd h<CR>", { desc = "Move to the left pane" })
keymap.set("n", "<c-l>", ":wincmd l<CR>", { desc = "Move to the right pane" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
