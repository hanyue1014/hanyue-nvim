vim.g.mapleader = " "

-- make kj map to esc for qol
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

-- default nvim file explorer
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- bttr line wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- In mac iterm2, remapped left option to Esc+, and is interpreted by nvim as the M key
-- option backspace to delete word
vim.keymap.set('i', '<M-BS>', '<C-w>')

-- use option left / right arrow key to go left right one word in both insert and normal mode
vim.keymap.set('i', '<M-Right>', '<C-Right>')
vim.keymap.set('i', '<M-Left>', '<C-Left>')
vim.keymap.set('n', '<M-Right>', '<C-Right>')
vim.keymap.set('n', '<M-Left>', '<C-Left>')
