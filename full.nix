{
  imports = [
    ./nvim.nix
  ];

  plugins = {
    fidget = {
      enable = true;
      progress.display.progressIcon.pattern = "meter";
      notification.window.winblend = 0;
    };
    hardtime = {
      enable = true;
      settings.disable_mouse = false;
    };

    wakatime.enable = true; # https://wakatime.com/settings/api-key
    rainbow-delimiters.enable = true;
    presence-nvim.enable = true; # Discord
  };
}
