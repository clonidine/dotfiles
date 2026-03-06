{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5ipYjy2mBU8zthIVQTVX9wUHw3jutXJGqVxRSg/Gnw";
  email = "lcly@tuta.io";
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
        email = "86500701+clonidine@users.noreply.github.com";
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
