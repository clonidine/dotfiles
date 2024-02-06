vim.opt.relativenumber = true
lvim.format_on_save = true
lvim.transparent_window = false

lvim.keys.normal_mode["<C-t>"] = ":ToggleTerm direction=float<CR>"
lvim.keys.term_mode["<C-t>"] = "<C-d>"

lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "latte",
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
    },
  },
}

lvim.colorscheme = "catppuccin-mocha"
