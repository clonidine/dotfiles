{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMo1dnyX/XPyCf4+YXy7a5zvCOcVTocrv1EB6q3Q5PSD";
  email = "user@example.invalid";
  hook = pkgs.replaceVars ./hooks/prepare-commit-msg {
    git = "${pkgs.git}/bin/git";
    ollama = "${pkgs.ollama}/bin/ollama";
    grep = "${pkgs.gnugrep}/bin/grep";
    sed = "${pkgs.gnused}/bin/sed";
    head = "${pkgs.coreutils}/bin/head";
    cut = "${pkgs.coreutils}/bin/cut";
  };

  hooksDir = pkgs.runCommand "git-hooks" { } ''
    mkdir -p "$out"
    install -m755 ${hook} "$out/prepare-commit-msg"
  '';
in
{
  home.file.".ssh/allowed_signers".text = ''
    ${email} ${publicKey}
  '';

  home.file.".ssh/id_ed25519.pub".text = publicKey;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "clonidine";
        email = "user@example.invalid";
        signingkey = "~/.ssh/id_ed25519.pub";
      };

      core.hooksPath = toString hooksDir;

      gpg.format = "ssh";

      "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen";

      "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";

      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}
