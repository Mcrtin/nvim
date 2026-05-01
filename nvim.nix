{
  imports = [
    ./generalKeybinds.nix
    ./session.nix
    ./treesitter.nix
    ./keyhints.nix
    ./explorers.nix
    ./bufferline.nix
    ./lsp.nix
    ./debug.nix
    ./colorscheme.nix
    ./telescope.nix
    ./git.nix
    ./bundles.nix
  ];

  luaLoader.enable = true;
  performance = {
    byteCompileLua = {
      enable = true;
      plugins = true;
    };
    combinePlugins = {
      enable = true;
      standalonePlugins = [
        "snacks.nvim"
        "refactoring.nvim"
        "conform.nvim"
        "mini.nvim"
        "openscad.nvim"
        "onedark.nvim"
        "nvim-treesitter"
        "async.nvim"
        "promise-async"
      ];
    };
  };

  opts = {
    number = true;
    relativenumber = true;
    signcolumn = "yes";

    ignorecase = true;
    smartcase = true;

    tabstop = 4;
    shiftwidth = 4;
    softtabstop = 0;
    expandtab = true;
    smarttab = true;
    showtabline = 4;
    smartindent = true;
    autoindent = true;
    breakindent = true;

    updatetime = 50;
    cursorline = true;
    ruler = true;
    gdefault = true;
    scrolloff = 8;
    swapfile = false;
    backup = false;
    undofile = true;

    foldlevelstart = 99;
    # foldcolumn = "1";
    foldlevel = 99;
    foldenable = true;
  };

  globals.mapleader = " ";
  globals.maplocalleader = ",";
  clipboard.providers.wl-copy.enable = true;

  diagnostic.settings.update_in_insert = false;

  plugins = {
    comment.enable = true;
    sleuth.enable = true;
    nvim-surround.enable = true;
    intellitab.enable = true;
    lastplace.enable = true;
    colorizer.enable = true; # color colorcodes
    nvim-autopairs.enable = true;
    web-devicons.enable = true;
    grug-far.enable = true;
    diffview.enable = true;

    lualine = {
      enable = true;
      settings = {
        options.globalstatus = true;
        sections.lualine_a = [
          "mode"
          {
            __unkeyed-1 = {
              __raw = ''
                function()
                    local reg = vim.fn.reg_recording()
                    if reg == "" then return "" end -- not recording
                    return "recording to " .. reg
                  end'';
            };
          }
        ];
      };
    };

    auto-save = {
      enable = true;
      settings = {
        enabled = true;
        condition =
          # lua
          ''
            function(buf)
                if vim.api.nvim_get_mode().mode == 'i' then
                    return false
                end

                local utils = require("auto-save.utils.data")
                if utils.not_in(vim.fn.getbufvar(buf, "&filetype"), {"TelescopePrompt"}) then
                  return true;
                end
                return false -- can't save
              end
          '';
      };
    };

    nvim-ufo = {
      # TODO: not really needed
      enable = true;
      settings.provider_selector =
        # lua
        ''
          function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
        '';
    };

    notify = {
      enable = true;
      settings = {
        timeout = 1000;
        render = "minimal";
        background_colour = "#000000";
      };
    };

    trouble = {
      enable = true;
      settings.autoclose = true;
    };

    # colorful-menu.enable = true; don't know how to use raw ._.
    blink-cmp = {
      enable = true;
      settings = {
        signature.enabled = true;
        completion = {
          ghost_text.enabled = true;
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 500;
          };
        };
      };
    };

    flash = {
      enable = true;
      settings.modes.char.enabled = false;
    };

    noice = {
      enable = true;
      settings = {
        presets.inc_rename = true;
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
        };
      };
    };

    todo-comments = {
      enable = true;
      keymaps = {
        todoTelescope = {
          key = "<leader>ft";
          options.silent = true;
        };
      };
    };

    undotree = {
      enable = true;
      settings.SetFocusWhenToggle = true;
    };

    illuminate = {
      enable = true;
      settings = {
        underCursor = false;
        largeFileCutoff = 5000;
        filetypesDenylist = [
          "DressingSelect"
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "toggleterm"
          "neo-tree"
          "Spectre"
          "reason"
        ];
      };
    };

    toggleterm = {
      enable = true;
      settings = {
        size = 15;
        open_mapping = "[[<A-i>]]";
        direction = "horizontal"; # 'vertical' | 'horizontal' | 'window' | 'float'
        float_opts = {
          border = "single"; # 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          width = 80;
          height = 20;
        };
        winbar.enabled = true;
      };
    };
  };

  keymaps = [
    # AutoSave
    {
      key = "<leader>ba";
      action = "<cmd>ASToggle<CR>";
      options.desc = "Toggle auto save";
    }

    # undotree
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
      options.desc = "Toggle Undotree";
    }

    #Trouble
    {
      key = "<leader>xq";
      action = "<cmd>TodoTrouble toggle<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>xQ";
      action = "<cmd>TodoQuickFix<cr>";
      options = {
        silent = true;
        desc = "Quickfix List (Trouble)";
      };
    }
    {
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Diagnostics (Trouble)";
    }
    {
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options.desc = "Buffer Diagnostics (Trouble)";
    }
    {
      key = "<leader>cs";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options.desc = "Symbols (Trouble)";
    }
    {
      key = "<leader>cl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options.desc = "LSP Definitions / references / ... (Trouble)";
    }
    {
      key = "<leader>xL";
      action = "<cmd>Trouble loclist toggle<cr>";
      options.desc = "Location List (Trouble)";
    }
    {
      key = "<leader>xQ";
      action = "<cmd>Trouble qflist toggle<cr>";
      options.desc = "Quickfix List (Trouble)";
    }

    # flash
    {
      key = "s";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").jump()<cr>";
    }
    {
      key = "<leader>S";
      mode = [
        "n"
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").treesitter()<cr>";
    }
    {
      key = "<leader>r";
      mode = "o";
      action = "<cmd>lua require(\"flash\").remote()<cr>";
    }
    {
      key = "<leader>R";
      mode = [
        "x"
        "o"
      ];
      action = "<cmd>lua require(\"flash\").treesitter_search()<cr>";
    }
    {
      key = "<c-s>";
      mode = "c";
      action = "<cmd>lua require(\"flash\").toggle()<cr>";
    }
  ];
}
