{
  git = {
    userName = null;
    userEmail = null;
    signingEmail = null;
    publicSigningKey = null;
  };

  agenix = {
    userRecipient =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMo1dnyX/XPyCf4+YXy7a5zvCOcVTocrv1EB6q3Q5PSD user@example.invalid";
    hostRecipients = {
      desktop =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMvDX++PFPyQgxPNSP9RLMnWEIJ9NQepJv7w5S0ovOUT host@example.invalid";
    };
  };

  networking = {
    zerotierJoinNetworks = [ ];
  };
}
