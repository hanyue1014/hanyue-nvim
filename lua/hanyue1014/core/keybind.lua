vim.g.mapleader = " "

-- make kj map to esc for qol
vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

-- default nvim file explorer (will be removing soon possibly, gonna use neotree)
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex, { desc = "Open Netrw, default nvim explorer (Deprecated)" })

-- use leader p to paste over selected content without yanking it to clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- use leader c or d when selected or not selected anything to yank the stuff into void (so won't override system clipboard)
vim.keymap.set({"n", "v"}, "<leader>c", [["_c]], { desc = "[C]hange (yanking to void)" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "[D]elete (yanking to void)" })

-- bttr line wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- J or K in visual / select mode to move line up or down, thx theprimeagen
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

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>ws", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>wh", "<C-w>h") -- focus window on left
vim.keymap.set("n", "<leader>wl", "<C-w>l") -- focus window on right
vim.keymap.set("n", "<leader>wj", "<C-w>j") -- focus window on top
vim.keymap.set("n", "<leader>wk", "<C-w>k") -- focus window on bottom
vim.keymap.set("n", "<leader>we", "<C-w>=") -- make split windows equal width & height
vim.keymap.set("n", "<leader>wx", ":close<CR>") -- close current split window

vim.keymap.set("n", "<leader>wo", ":tabnew<CR>") -- open new tab
vim.keymap.set("n", "<leader>wx", ":tabclose<CR>") -- close current tab
vim.keymap.set("n", "<leader>wn", ":tabn<CR>") --  go to next tab
vim.keymap.set("n", "<leader>wp", ":tabp<CR>") --  go to previous tab
