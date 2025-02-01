{
  imports = [
    ./alpha.nix
    ./nvim.nix
  ];

  plugins = {
    fidget.enable = true;

    wakatime.enable = true; # https://wakatime.com/settings/api-key
    presence-nvim.enable = true; # Discord
  };
}
