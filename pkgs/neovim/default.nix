{ pkgs }:

let
  inherit (import ./shared.nix { inherit pkgs; })
    extraPackages
    plugins
    ;

  configDir = ../../dotfiles/nvim;

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    inherit plugins;
    customLuaRC = ''
      vim.opt.runtimepath:prepend("${configDir}")

      local after_dir = "${configDir}/after"
      if vim.fn.isdirectory(after_dir) == 1 then
        vim.opt.runtimepath:append(after_dir)
      end

      dofile("${configDir}/init.lua")
    '';
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (
  neovimConfig
  // {
    wrapperArgs = neovimConfig.wrapperArgs ++ [
      "--prefix"
      "PATH"
      ":"
      (pkgs.lib.makeBinPath extraPackages)
    ];
  }
)
