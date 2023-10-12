vim.g.mapleader = " "

-- make kj map to esc for qol
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

-- default nvim file explorer (will be removing soon possibly, gonna use neotree)
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- use leader p to paste over selected content without yanking it to clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- use leader c or d when selected or not selected anything to yank the stuff into void (so won't override system clipboard)
vim.keymap.set({"n", "v"}, "<leader>c", [["_c]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- bttr line wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- J or K in visual / select mode to move line up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- In mac iterm2, remapped left option to Esc+, and is interpreted by nvim as the M key
-- option backspace to delete word
vim.keymap.set('i', '<M-BS>', '<C-w>')

-- use option left / right arrow key to go left right one word in both insert and normal mode
vim.keymap.set('i', '<M-Right>', '<C-Right>')
vim.keymap.set('i', '<M-Left>', '<C-Left>')
vim.keymap.set('n', '<M-Right>', '<C-Right>')
vim.keymap.set('n', '<M-Left>', '<C-Left>')
