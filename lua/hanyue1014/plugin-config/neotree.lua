require("neo-tree").setup({
    -- auto close on file opened
    event_handlers = {
        {
            event = "file_opened",
            handler = function(file_path)
              -- auto close after open file
              -- vimc.cmd("Neotree close")
              -- OR
              require("neo-tree.command").execute({ action = "close" })
            end
        },
    }
})

-- use leader fe to open neotree
vim.keymap.set('n', '<leader>fe', function() vim.cmd("Neotree toggle") end, { desc = "Toggle File [E]xplorer" })
