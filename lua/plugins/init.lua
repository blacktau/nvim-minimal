return {
    { 
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function() 
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
    { "folke/which-key.nvim", lazy = true },
		{ "echasnovski/mini.nvim", branch = 'main' },
		{ "nvim-treesitter/nvim-treesitter", build = ':TSUpdate' },
    -- lsp
    "neovim/nvim-lspconfig",
    -- "onsails/lspkind-nvim",

    -- autocomplete
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-buffer"
    --     }
    -- },

    -- snippets
    -- "sirver/ultisnips",
    -- "quangnguyen30192/cmp-nvim-ultisnips",
    
    -- utilities
    -- { 
    --     "nvim-lualine/lualine.nvim",
    --     dependencies = {
    --         "kyazdani42/nvim-web-devicons"
    --     }
    -- },

--     "kdheepak/tabline.nvim",
--     {
--         "nvim-telescope/telescope.nvim",
--         dependencies = {
--             "nvim-lua/popup.nvim",
--             "nvim-lua/plenary.nvim"
--         }
--     }
}
