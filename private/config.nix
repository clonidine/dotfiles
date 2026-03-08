let
  defaults = import ./default.nix;
  local = if builtins.pathExists ./local.nix then import ./local.nix else { };
in
{
  git = defaults.git // (local.git or { });

  agenix =
    defaults.agenix
    // (local.agenix or { })
    // {
      hostRecipients =
        defaults.agenix.hostRecipients
        // ((local.agenix or { }).hostRecipients or { });
    };

  networking = defaults.networking // (local.networking or { });
}
