local plugins = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
        }
    },
    "nvim-lua/plenary.nvim",
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    -- for LSP configs
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "rust", "go", "typescript", "c", "cpp", "java", "lua", "vim", "vimdoc",
                    "javascript", "html" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    "terrortylor/nvim-comment",
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            filesystem = {
                filtered_items = {
                    visible = true,
                    show_hidden_count = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        '.git',
                        '.DS_Store',
                        'thumbs.db',
                        'node_modules',
                    },
                    never_show = {},
                },
            }
        },
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },
    'tpope/vim-fugitive',
    'mbbill/undotree',
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    },
    { 'kevinhwang91/nvim-ufo', dependencies = { 'kevinhwang91/promise-async' } },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },
    'nvim-treesitter/nvim-treesitter-context',
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter",
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "aznhe21/actions-preview.nvim",
        config = function()
            -- code action on <leader>la
            vim.keymap.set({ "v", "n" }, "<leader>la", require("actions-preview").code_actions, { desc = "[A]ctions" })
        end,
    }
}

local opts = {}

-- use lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(plugins, opts)

require("hanyue1014.plugin-config.telescope")
require("hanyue1014.plugin-config.lspZero")
require("hanyue1014.plugin-config.neotree")
require("hanyue1014.plugin-config.lualine")
require("hanyue1014.plugin-config.whichkey")
require("nvim_comment").setup() -- no need own file cuz im cool with the defaults (will see if i wanna switch in the future)
require("hanyue1014.plugin-config.ufo_cfg")
require("hanyue1014.plugin-config.ts_objects")
require("ibl").setup() -- cool with the configs
