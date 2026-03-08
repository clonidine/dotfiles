{ pkgs, lib, ... }:

let
  private = import ../../../private/config.nix;
  publicKey = private.git.publicSigningKey;
  signingEmail = private.git.signingEmail;
  hasGitIdentity = private.git.userName != null && private.git.userEmail != null;
  hasSigningIdentity = signingEmail != null && publicKey != null;
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
  home.file = lib.mkMerge [
    (lib.optionalAttrs hasSigningIdentity {
      ".ssh/allowed_signers".text = ''
        ${signingEmail} ${publicKey}
      '';

      ".ssh/id_ed25519.pub".text = publicKey;
    })
  ];

  programs.git = {
    enable = true;

    settings = lib.mkMerge [
      {
        core.hooksPath = toString hooksDir;
      }
      (lib.optionalAttrs hasGitIdentity {
        user = {
          name = private.git.userName;
          email = private.git.userEmail;
        };
      })
      (lib.optionalAttrs hasSigningIdentity {
        user.signingkey = "~/.ssh/id_ed25519.pub";

        gpg.format = "ssh";

        "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen";

        "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";

        commit.gpgsign = true;
        tag.gpgsign = true;
      })
    ];
  };
}
