return {
    {'rust-lang/rust.vim'},
    {'mrcjkb/rustaceanvim', version = '^3', ft = {'rust'}},
    -- LSP and completion plugins
    {'neovim/nvim-lspconfig'}, -- LSP configurations
    {'hrsh7th/nvim-cmp'}, -- Completion plugin
    {'hrsh7th/cmp-nvim-lsp'}, -- LSP source for nvim-cmp
    {'hrsh7th/cmp-buffer'}, -- Buffer completions
    {'hrsh7th/cmp-path'}, -- Path completions
    {'hrsh7th/cmp-cmdline'}, -- Command line completions
    {'saadparwaiz1/cmp_luasnip'}, -- Snippet completions
    {'L3MON4D3/LuaSnip'}, -- Snippet engine
    {'simrat39/rust-tools.nvim'}, -- Rust tools for nvim
    {'catppuccin/nvim', as = 'catppuccin'}, -- Catppuccin theme
    {'jose-elias-alvarez/null-ls.nvim'}, -- Null-ls for formatting and linting
    {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}},
    {"folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}, {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {"nvim-tree/nvim-web-devicons"},
        config = function() require("nvim-tree").setup {} end
    }
}
