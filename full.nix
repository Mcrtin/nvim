{
  imports = [
    ./nvim.nix
  ];

  plugins = {
    fidget.enable = true;

    hardtime = {
      enable = true;
      settings.disable_mouse = false;
    };

    wakatime.enable = true; # https://wakatime.com/settings/api-key
    presence-nvim.enable = true; # Discord
  };
}
