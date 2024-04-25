{ pkgs, ...}: {
   programs.vscode = {
     enable = true;
     package = pkgs.vscodium;
     extensions = with pkgs.vscode-extensions; [
       rust-lang.rust-analyzer
       tamasfe.even-better-toml
       ms-azuretools.vscode-docker
       usernamehw.errorlens
       vscodevim.vim
    ];
  };
}
