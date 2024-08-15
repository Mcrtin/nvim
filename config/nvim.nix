{
  imports = [
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
    lualine = {
      enable = true;
      globalstatus = true;
    };

    presence-nvim.enable = true; # Discord

    firenvim.enable = true; # firefox integration

    image.enable = true;

    auto-save = {
      enable = true;
      settings = {
        enabled = true;
        execution_message.enabled = false;
        condition =
          /*
          lua
          */
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
        /*
        lua
        */
        ''
          function(bufnr, filetype, buftype)
              return {'treesitter', 'indent'}
          end
        '';
    };

    nvim-autopairs = {
      enable = true;
    };

    notify = {
      enable = true;
      timeout = 1000;
      render = "minimal";
    };

    fidget = {
      enable = true;
      progress.display.progressIcon.pattern = "meter";
      notification.window.winblend = 0;
    };

    trouble = {
      enable = true;
      settings.autoclose = true;
    };

    flash = {
      enable = true;
      settings.highlight.backdrop = false;
    };

    comment = {
      enable = true;
    };

    nvim-colorizer.enable = true; # color colorcodes

    gitsigns = {
      enable = true;
      settings.current_line_blame = false;
    };

    sleuth.enable = true;

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

    rainbow-delimiters.enable = true;

    surround.enable = true;

    telescope = {
      enable = true;
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

    indent-blankline.enable = true;
    intellitab.enable = true;

    wakatime.enable = true; # https://wakatime.com/settings/api-key

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
    lastplace.enable = true;

    hardtime = {
      enable = true;
      disableMouse = false;
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<C-e>";
        navFile = {
          "1" = "<leader>hj";
          "2" = "<leader>hk";
          "3" = "<leader>hl";
          "4" = "<leader>hm";
        };
      };
    };
    markdown-preview = {
      enable = true;
      settings = {
        browser = "floorp";
        theme = "dark";
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
    {
      key = "<leader>xq";
      action = "<cmd>TodoTrouble toggle<cr>";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>MarkdownPreview<cr>";
      options = {
        desc = "Markdown Preview";
      };
    }
    # misc
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options = {
        silent = true;
        desc = "Move up when line is highlighted";
      };
    }

    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options = {
        silent = true;
        desc = "Move down when line is highlighted";
      };
    }

    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
      options = {
        silent = true;
        desc = "Allow cursor to stay in the same place after appeding to current line";
      };
    }

    {
      mode = "v";
      key = "<";
      action = "<gv";
      options = {
        silent = true;
        desc = "Indent while remaining in visual mode.";
      };
    }

    {
      mode = "v";
      key = ">";
      action = ">gv";
      options = {
        silent = true;
        desc = "Indent while remaining in visual mode.";
      };
    }

    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options = {
        silent = true;
        desc = "Allow <C-d> and <C-u> to keep the cursor in the middle";
      };
    }

    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options = {
        desc = "Allow C-d and C-u to keep the cursor in the middle";
      };
    }

    # Remap for dealing with word wrap and adding jumps to the jumplist.
    {
      mode = "n";
      key = "j";
      action.__raw = "
        [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']]
      ";
      options = {
        expr = true;
        desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
      };
    }

    {
      mode = "n";
      key = "k";
      action.__raw = "
        [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']]
      ";
      options = {
        expr = true;
        desc = "Remap for dealing with word wrap and adding jumps to the jumplist.";
      };
    }

    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options = {
        desc = "Allow search terms to stay in the middle";
      };
    }

    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options = {
        desc = "Allow search terms to stay in the middle";
      };
    }

    # Paste stuff without saving the deleted word into the buffer
    {
      mode = "x";
      key = "<leader>p";
      action = "\"_dP";
      options = {
        desc = "Deletes to void register and paste over";
      };
    }

    # Copy stuff to system clipboard with <leader> + y or just y to have it just in vim
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = "\"+y";
      options = {
        desc = "Copy to system clipboard";
      };
    }

    {
      mode = ["n" "v"];
      key = "<leader>Y";
      action = "\"+Y";
      options = {
        desc = "Copy to system clipboard";
      };
    }

    # Delete to void register
    {
      mode = ["n" "v"];
      key = "<leader>D";
      action = "\"_d";
      options = {
        desc = "Delete to void register";
      };
    } # ui
    {
      mode = "n";
      key = "<leader>ml";
      action = ":lua ToggleLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>mL";
      action = ":lua ToggleRelativeLineNumber()<cr>";
      options = {
        silent = true;
        desc = "Toggle Relative Line Numbers";
      };
    }

    {
      mode = "n";
      key = "<leader>mw";
      action = ":lua ToggleWrap()<cr>";
      options = {
        silent = true;
        desc = "Toggle Line Wrap";
      };
    }
    # Windows
    {
      mode = "n";
      key = "<leader>ww";
      action = "<C-W>p";
      options = {
        silent = true;
        desc = "Other window";
      };
    }

    {
      mode = "n";
      key = "<leader>wd";
      action = "<C-W>c";
      options = {
        silent = true;
        desc = "Delete window";
      };
    }

    {
      mode = "n";
      key = "<leader>w-";
      action = "<C-W>s";
      options = {
        silent = true;
        desc = "Split window below";
      };
    }

    {
      mode = "n";
      key = "<leader>w|";
      action = "<C-W>v";
      options = {
        silent = true;
        desc = "Split window right";
      };
    } # Tabs
    {
      mode = "n";
      key = "<leader><tab>l";
      action = "<cmd>tablast<cr>";
      options = {
        silent = true;
        desc = "Last tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab>f";
      action = "<cmd>tabfirst<cr>";
      options = {
        silent = true;
        desc = "First Tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab><tab>";
      action = "<cmd>tabnew<cr>";
      options = {
        silent = true;
        desc = "New Tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab>]";
      action = "<cmd>tabnext<cr>";
      options = {
        silent = true;
        desc = "Next Tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab>d";
      action = "<cmd>tabclose<cr>";
      options = {
        silent = true;
        desc = "Close tab";
      };
    }

    {
      mode = "n";
      key = "<leader><tab>[";
      action = "<cmd>tabprevious<cr>";
      options = {
        silent = true;
        desc = "Previous Tab";
      };
    }
    # undotree
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
      options.desc = "Toggle Undotree";
    }
    # gitsigns
    {
      mode = "n";
      key = "<leader>gd";
      action = "<cmd>lua require('gitsigns').diffthis()<CR>";
      options.desc = "Git Diff";
    }
    {
      mode = "n";
      key = "<leader>gr";
      action = "<cmd>lua require('gitsigns').refresh()<CR>";
      options.desc = "Git Refresh";
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>lua require('gitsigns').blame_line()<CR>";
      options.desc = "Git Blame";
    }
    {
      mode = "n";
      key = "<leader>ghv";
      action = "<cmd>lua require('gitsigns').select_hunk()<CR>";
      options.desc = "Git Hunk Visual Select";
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action = "<cmd>lua require('gitsigns').preview_hunk()<CR>";
      options.desc = "Git Hunk Preview";
    }
    {
      mode = "n";
      key = "<leader>ghr";
      action = "<cmd>lua require('gitsigns').reset_hunk()<CR>";
      options.desc = "Git Hunk Reset";
    }
    {
      mode = "n";
      key = "<leader>ghs";
      action = "<cmd>lua require('gitsigns').stage_hunk()<CR>";
      options.desc = "Git Hunk Stage";
    }
    {
      mode = "n";
      key = "<leader>ghu";
      action = "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>";
      options.desc = "Git Hunk Undo Stage";
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

    # AutoSave

    {
      key = "<leader>ta";
      action = "<cmd>ASToggle<CR>";
    }

    # Telescope bindings

    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>fw";
    }
    {
      action = "<cmd>Telescope find_files<CR>";
      key = "<leader>ff";
    }
    {
      action = "<cmd>Telescope git_commits<CR>";
      key = "<leader>fg";
    }
    {
      action = "<cmd>Telescope oldfiles<CR>";
      key = "<leader>fo";
    }
    {
      action = "<cmd>Telescope help_tags<CR>";
      key = "<leader>fh";
    }
    {
      action = "<cmd>Telescope man_pages<CR>";
      key = "<leader>fi";
    }
    {
      action = "<cmd>Telescope marks<CR>";
      key = "<leader>fm";
    }
    {
      action = "<cmd>Telescope lsp_definitions<CR>";
      key = "<leader>fd";
    }

    # Notify bindings

    {
      mode = "n";
      key = "<leader>n";
      action = ''
        <cmd>lua require("notify").dismiss({ silent = true, pending = true })<cr>
      '';
      options = {
        desc = "Dismiss All Notifications";
      };
    }
  ];
}
