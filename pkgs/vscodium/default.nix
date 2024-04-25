{ pkgs, ...}: {
   programs.vscode = {
     enable = true;
     package = pkgs.vscodium;
     userSettings = {
	"files.autoSave" = "onFocusChange";
	"editor.fontSize" = 16;
        "editor.fontFamily" = "'JetBrainsMono Nerd Font'";
	"editor.cursorStyle" = "block";
	"editor.fontLigatures" = true;
	"workbench.colorTheme" = "Catppuccin Mocha";
	"workbench.iconTheme" = "eq-material-theme-icons-darker";
     };
     extensions = with pkgs.vscode-extensions; [
       rust-lang.rust-analyzer
       tamasfe.even-better-toml
       ms-azuretools.vscode-docker
       usernamehw.errorlens
       vscodevim.vim
       catppuccin.catppuccin-vsc
       catppuccin.catppuccin-vsc-icons
       equinusocio.vsc-material-theme-icons
    ];
  };
}
