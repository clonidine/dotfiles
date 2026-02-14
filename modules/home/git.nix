{ pkgs, ... }:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA5ipYjy2mBU8zthIVQTVX9wUHw3jutXJGqVxRSg/Gnw";
  email = "lcly@tuta.io";
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
        email = email;
        signingkey = "~/.ssh/id_ed25519.pub";
      };

      gpg.format = "ssh";

      "gpg \"ssh\"".program = "${pkgs.openssh}/bin/ssh-keygen";

      "gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";

      commit.gpgsign = true;
      tag.gpgsign = true;
    };
  };
}
