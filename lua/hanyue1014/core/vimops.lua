-- qol vim options

-- use system clipboard
vim.o.clipboard = "unnamedplus"

-- highlight current line for better appearance with transparency
vim.o.cursorline = true

-- enable line numbers
vim.wo.number = true
vim.wo.rnu = true

-- save undo history
vim.o.undofile = true

-- enable break indent
vim.o.breakindent = true

-- indent with tabs and each indent is 4 chars long
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.opt.smartindent = true

-- allow undo tree to save undo history and access them
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true

-- removing auto comments on new lines after commenting on current line
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

-- always have 8 rows below
vim.opt.scrolloff = 8

-- fold settings (requires treesitter)
-- vim.o.foldmethod = "expr"
-- vim.o.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.o.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
-- vim.o.fillchars = "fold:\\"
-- vim.o.foldnestmax = 3
-- vim.o.foldminlines = 1
-- vim.opt.foldenable = false

-- UFO fold configs
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- very good practice for just having ONE autcmd (at least the one that I use, regardless, this is cited)
local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup '..group_name)
        api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            api.nvim_command(command)
        end
        api.nvim_command('augroup END')
    end
end


local autoCommands = {
    open_folds = {
        {"BufReadPost,FileReadPost", "*", "normal zR"} -- open all fold (zR in normal mode)
    }
}

M.nvim_create_augroups(autoCommands)
