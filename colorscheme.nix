{
  colorschemes.onedark = {
    enable = false;
    # settings.style = "warm";
  };

  colorschemes = {
    gruvbox.enable = true;
    kanagawa.enable = false;
    tokyonight.enable = false;
    monokai-pro = {
      enable = false;
      settings = {
        terminal_colors = false;
        devicons = true;
      };
    };

    catppuccin = {
      enable = false;
      settings = {
        flavour = "mocha"; # "latte", "mocha", "frappe", "macchiato" or raw lua code
        integrations = {
          cmp = true;
          noice = true;
          neotree = true;
          harpoon = true;
          gitsigns = true;
          which_key = true;
          illuminate = {
            enabled = true;
          };
          treesitter = true;
          treesitter_context = true;
          telescope.enabled = true;
          indent_blankline.enabled = true;
          mini.enabled = true;
          native_lsp = {
            enabled = false;
            inlay_hints = {
              background = true;
            };
            underlines = {
              errors = ["underline"];
              hints = ["underline"];
              information = ["underline"];
              warnings = ["underline"];
            };
          };
        };
      };
    };
  };
}
