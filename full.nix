{
  imports = [
    ./alpha.nix
    ./nvim.nix
  ];

  plugins = {
    fidget.enable = false;

    wakatime.enable = true; # https://wakatime.com/settings/api-key
    # presence.enable = true; # Discord
  };
}
