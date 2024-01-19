local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "[F]ile" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "[G]rep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "[B]uffer" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "[H]elp tags" })
vim.keymap.set('n', '<leader>fi', builtin.current_buffer_fuzzy_find, { desc = "[I]n File" })

-- launch telescope find files on launch if no files provided
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argv(0) == "" then
      require("telescope.builtin").find_files()
    end
  end,
})
