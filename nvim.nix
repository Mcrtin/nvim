{
  imports = [
    ./generalKeybinds.nix
    ./session.nix
    ./alpha.nix
    ./cmp.nix
    ./treesitter.nix
    ./keyhints.nix
    ./explorers.nix
    ./bufferline.nix
    ./lsp.nix
    ./debug.nix
    ./colorscheme.nix
    ./telescope.nix
    ./git.nix
  ];

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
  clipboard.providers.wl-copy.enable = true;

  diagnostics.update_in_insert = false;

  plugins = {
    comment.enable = true;
    sleuth.enable = true;
    surround.enable = true;
    indent-blankline.enable = true;
    intellitab.enable = true;
    lastplace.enable = true;
    hex.enable = true;
    telescope.enable = true;
    nvim-colorizer.enable = true; # color colorcodes
    nvim-autopairs.enable = true;

    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };

    auto-save = {
      enable = true;
      settings = {
        enabled = true;
        execution_message.enabled = false;
        condition =
          # lua
          ''
            function(buf)
                local m = vim.api.nvim_get_mode().mode

                if
                    m == 'i' then
                    return false
                end

                local fn = vim.fn
                local utils = require("auto-save.utils.data")
                if
                  fn.getbufvar(buf, "&modifiable") == 1 and
                  utils.not_in(fn.getbufvar(buf, "&filetype"), {"TelescopePrompt"}) then
                return true;
                end
                return false -- can't save
              end
          '';
      };
    };

    nvim-ufo = {
      enable = true;
      providerSelector =
        # lua
        ''
          function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
        '';
    };

    notify = {
      enable = true;
      timeout = 1000;
      render = "minimal";
    };

    trouble = {
      enable = true;
      settings.autoclose = true;
    };

    flash = {
      enable = true;
      settings.modes.char.enabled = false;
    };

    noice = {
      enable = true;
      notify.enabled = true;
      lsp = {
        override = {
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
          "cmp.entry.get_documentation" = true;
        };
        progress.enabled = false;
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
      underCursor = false;
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

    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<C-h>";
        navFile = {
          "1" = "<leader>hj";
          "2" = "<leader>hk";
          "3" = "<leader>hl";
          "4" = "<leader>hm";
        };
      };
    };

    project-nvim = {
      enable = true;
      enableTelescope = true;
    };

    toggleterm = {
      enable = true;
      settings = {
        size = ''
          function(term)
            if term.direction == "horizontal" then
              return 15
                elseif term.direction == "vertical" then
              return vim.o.columns * 0.4
            end
          end
        '';
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
    #Trouble
    {
      key = "<leader>xq";
      action = "<cmd>TodoTrouble toggle<cr>";
      options.silent = true;
    }

    # AutoSave
    {
      key = "<leader>a";
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

    # Trouble
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
      mode = ["n" "x" "o"];
      action = "<cmd>lua require(\"flash\").jump()<cr>";
    }
    {
      key = "<leader>S";
      mode = ["n" "x" "o"];
      action = "<cmd>lua require(\"flash\").treesitter()<cr>";
    }
    {
      key = "<leader>r";
      mode = "o";
      action = "<cmd>lua require(\"flash\").remote()<cr>";
    }
    {
      key = "<leader>R";
      mode = ["x" "o"];
      action = "<cmd>lua require(\"flash\").treesitter_search()<cr>";
    }
    {
      key = "<c-s>";
      mode = "c";
      action = "<cmd>lua require(\"flash\").toggle()<cr>";
    }
  ];
}
