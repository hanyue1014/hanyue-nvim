local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ile" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "[G]rep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[B]uffer" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[H]elp tags" })
vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = "[C]ontents" })
vim.keymap.set(
    'n',
    '<leader>fa',
    function()
        builtin.find_files({
            no_ignore = true,
            hidden = true,
            -- some general ignore patterns that I know I would never need to access the file contents of
            -- this list will keep expanding as I explore more stuffs
            file_ignore_patterns = {
                'node_modules',
                '.git/',
                '.venv',
                '.DS_Store', -- avg mac experience
                'build', -- preferrably this is the folder for built contents across ALL the languages
            }
        })
    end,
    { desc = "[A]ll Files (Including Hidden and .gitignore)" }
)

-- <C-d> in insert mode to delete buffer in buffer picker
require('telescope').setup {
    pickers = {
        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            mappings = {
                i = {
                    ["<C-x>"] = "delete_buffer",
                }
            }
        }

    }
}

-- launch telescope find files on launch if no files provided
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argv(0) == "" then
            require("telescope.builtin").find_files()
        end
    end,
})
