{ pkgs }:

{
  extraPackages = with pkgs; [
    bacon
    cargo
    cargo-watch
    clippy
    fd
    lua-language-server
    nil
    ripgrep
    rust-analyzer
    rustc
    rustfmt
    stylua
  ];

  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim
    cmp-buffer
    cmp-nvim-lsp
    cmp-path
    cmp_luasnip
    friendly-snippets
    gitsigns-nvim
    lualine-nvim
    luasnip
    nvim-cmp
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
    nvim-web-devicons
    plenary-nvim
    rustaceanvim
    telescope-nvim
  ];
}
