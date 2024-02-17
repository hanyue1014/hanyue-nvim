-- one stop config for all the LSPs (with LSPZero)
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'gopls', 'tsserver', 'pyright', 'java_language_server', 'clangd' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    },
})

-- helper function for checking if there is word before
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local luasnip = require("luasnip")

-- <M-J> and <M-K> is the result of pressing left option and J or K
cmp.setup({
    -- make it bordered otherwise not clear cuz I have transparency enabled
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        -- Navigate between snippet placeholder
        -- I actually dk what this does
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),

        -- scroll the documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        -- use tab to select next autocomplete
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- use shift tab to go to previous suggestion
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

        -- Use option j to go to next suggestion
        ["<M-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                -- that way you will only jump inside the snippet region
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        -- use option k to go to previous suggestion
        ["<M-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    })
})

local lsp_sig_cfg = {
    hint_enable = false,
    -- offset x is already based on cursor position, just slightly to the left
    floating_window_off_x = 5,
    -- -- floating_window_off_x = function()
    --     -- the width of the left side (numbers, signs etc) need to unpack first becuz for whatever reason it is given in nested table ({{ props }})
    --     local gutterWidth = table.unpack(vim.fn.getwininfo(vim.fn.win_getid())).textoff;
    --     local colnr = vim.api.nvim_win_get_cursor(vim.fn.win_getid())[2] + 1 -- cursor col number, +1 accomodate for fat cursor
    --     return colnr --+ gutterWidth
    -- end,
    floating_window_off_y = function()
        -- local linenr = vim.api.nvim_win_get_cursor(vim.fn.win_getid())[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline()             -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then
            return pumheight
        end

        -- window bottom
        if winheight - winline < pumheight then
            return -pumheight
        end
        return 0
    end,
}
require("lsp_signature").setup(lsp_sig_cfg)

-- setup nvim comment to be able to use the CommentToggle command
require('nvim_comment').setup()

-- leader lf to use vim's default format
vim.keymap.set({ 'n', 'v' }, '<leader>lf', vim.lsp.buf.format, { desc = '[F]ormat' })
-- leader lr to rename identifier using vim's default lsp rename
vim.keymap.set({ 'n', 'v' }, '<leader>lr', vim.lsp.buf.rename, { desc = '[R]ename' })
-- leader lc to toggle comment
vim.keymap.set('n', '<leader>lc', function() vim.cmd("CommentToggle") end, { desc = 'Toggle [C]omment' })
vim.keymap.set('v', '<leader>lc', function() vim.cmd("'<,'>CommentToggle") end, { desc = 'Toggle [C]omment' })
-- leader li to view information on the selected text / text under cursor (as if hovering the text in vscode)
vim.keymap.set({ 'n', 'v' }, '<leader>li', vim.lsp.buf.hover, { desc = 'Show [I]nfo' })
-- with the help of telescope, but still is lsp related stuffs
-- leader ld to go to definition if there is only one, otherwise show all of them in telescope
vim.keymap.set({ 'n', 'v' }, '<leader>ld', require('telescope.builtin').lsp_definitions, { desc = 'Show [D]efinitions' })
-- leader lr to show all references of the word under cursor if there is only one, otherwise show all of them in telescope
vim.keymap.set({ 'n', 'v' }, '<leader>lr', require('telescope.builtin').lsp_references, { desc = 'Show [R]eferences' })
-- leader ls to see symbols provided by treesitter
vim.keymap.set({ 'n', 'v' }, '<leader>ls', require('telescope.builtin').treesitter, { desc = 'Show [S]ymbols (Provided by Treesitter)' })
-- leader lt to see troubles
vim.keymap.set('n', '<leader>lt', function() vim.cmd("TroubleToggle") end, { desc = 'Toggle [T]rouble (Diagnostics)' })

