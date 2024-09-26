{pkgs, ...}: {
  plugins.oil = {
    enable = false;
    settings = {
      deleteToTrash = true;
      float = {
        padding = 2;
        maxWidth = 0; # ''math.ceil(vim.o.lines * 0.8 - 4)'';
        maxHeight = 0; # ''math.ceil(vim.o.columns * 0.8)'';
        winOptions.winblend = 0;
      };
    };
  };

  plugins.yazi = {
    enable = true;
    settings = {
      open_for_directories = true;
      use_ya_for_events_reading = true;
      use_yazi_client_id_flag = true;
    };
  };

  plugins.nvim-tree = {
    enable = true;
    git = {
      enable = true;
      ignore = false;
    };

    renderer.indentWidth = 1;
    diagnostics.enable = true;
    view.float.enable = true;
    updateFocusedFile.enable = true;
  };

  extraPlugins = with pkgs.vimUtils; [
    (buildVimPlugin {
      pname = "sidebar.nvim";
      version = "2024-02-07";
      src = pkgs.fetchFromGitHub {
        owner = "sidebar-nvim";
        repo = "sidebar.nvim";
        rev = "5695712eef6288fff667343c4ae77c54911bdb1b";
        sha256 = "1p12189367x0x26cys9wxipzwr3i0bmz4lb0s79ki0a49d6zja2c";
      };
    })
  ];
  extraConfigLua = ''
    local sidebar = require("sidebar-nvim")
    sidebar.setup({
      disable_default_keybindings = 0,
      bindings = nil,
      open = false,
      side = "left",
      initial_width = 32,
      hide_statusline = false,
      update_interval = 1000,
      sections = { "git", "containers" },
      section_separator = {"", "-----", ""},
      section_title_separator = {""},
      containers = {
          attach_shell = "/bin/sh", show_all = true, interval = 5000,
      },
      datetime = { format = "%a %b %d, %H:%M", clocks = { { name = "local" } } },
      todos = { ignored_paths = {} },
      ["git"] = {
          icon = "", -- 
      },
    })
    cmd = {
      "SidebarNvimToggle",
      "SidebarNvimOpen",
      "SidebarNvimFocus",
      "SidebarNvimUpdate",
    }
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>SidebarNvimToggle<CR>";
      options = {
        desc = "Toggle Explorer";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>o";
      action = "<cmd>Yazi<CR>";
      options = {
        desc = "Open parent directory";
        silent = true;
      };
    }
    {
      key = "<leader>cw";
      action = "<cmd>Yazi cwd<cr>";
      options.desc = "Open the file manager in nvim's working directory";
    }
    {
      key = "<c-up>";
      action = "<cmd>Yazi toggle<cr>";
      options.desc = "Resume the last yazi session";
    }
    {
      mode = "n";
      key = "<C-n>";
      action = "<cmd>lua require('nvim-tree.api').tree.toggle()<CR>";
      options.desc = "Toggle Tree";
    }
  ];
}
