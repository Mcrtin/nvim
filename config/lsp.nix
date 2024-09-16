{pkgs, ...}: {
  plugins = {
    nix.enable = true;

    vimtex = {
      enable = true;
      settings.view_method = "zathura";
    };

    nvim-jdtls = {
      enable = true;
      data = "~/.cache/jdtls/workspace";
      configuration = "~/.cache/jdtls/config";
      settings = {
        java = {
          signatureHelp = true;
          completion = true;
        };
      };
    };

    openscad = {
      enable = true;
      keymaps.enable = true;
    };
    lspsaga = {
      enable = true;
      lightbulb.virtualText = false;
      symbolInWinbar.enable = false;
      outline = {
        autoClose = true;
        closeAfterJump = true;
      };
    };
    lsp-lines.enable = true;
  };

  autoCmd = [
    {
      event = "VimEnter";
      command = "lua require('lsp_lines').toggle()"; # Disables lsp-lines by default - use <leader>ll to enable
    }
  ];

  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
      extra = [
        {
          action = "<CMD>LspStop<Enter>";
          key = "<leader>lx";
        }
        {
          action = "<CMD>LspStart<Enter>";
          key = "<leader>la";
        }
        {
          action = "<CMD>LspRestart<Enter>";
          key = "<leader>le";
        }
        {
          mode = "n";
          action = "<CMD>Lspsaga hover_doc<Enter>";
          key = "K";
        }
        {
          key = "<leader>lc";
          action = "<cmd>Lspsaga code_action<cr>";
          options.desc = "Code Action";
        }
        {
          key = "<leader>lo";
          action = "<cmd>Lspsaga outline<cr>";
          options.desc = "Outline";
        }
        {
          key = "<leader>lr";
          action = "<cmd>Lspsaga rename<cr>";
          options.desc = "Rename";
        }
        {
          key = "<leader>lf";
          action = "<cmd>Lspsaga finder<cr>";
          options.desc = "Lsp Finder";
        }
        {
          key = "<leader>lp";
          action = "<cmd>Lspsaga peek_definition<cr>";
          options.desc = "Preview Definition";
        }
        {
          mode = "n";
          key = "<leader>ld";
          options.desc = "Lsp Goto Definition";
          action = "<cmd>Lspsaga goto_definition<CR>";
        }
        {
          key = "<leader>ls";
          action = "<cmd>Lspsaga signature_help<cr>";
          options.desc = "Signature Help";
        }
        {
          key = "<leader>lw";
          action = "<cmd>Lspsaga show_workspace_diagnostics<cr>";
          options.desc = "Show Workspace Diagnostics";
        }
      ];
    };
    servers = {
      tsserver.enable = true; # TS/JS
      # cssls.enable = true; # CSS
      tailwindcss.enable = true; # TailwindCSS
      # html.enable = true; # HTML
      astro.enable = true; # AstroJS
      phpactor.enable = true; # PHP
      svelte.enable = false; # Svelte
      vuels.enable = false; # Vue
      pyright.enable = true; # Python
      marksman.enable = true; # Markdown
      nil-ls.enable = true; # Nix
      dockerls.enable = true; # Docker
      bashls.enable = true; # Bash
      clangd.enable = true; # C/C++
      csharp-ls.enable = true; # C#
      yamlls.enable = true; # YAML
      texlab.enable = true; #Tex

      lua-ls = {
        # Lua
        enable = true;
        settings.telemetry.enable = false;
      };

      # Rust
      rust-analyzer = {
        enable = true;
        installRustc = true;
        installCargo = true;
      };
    };
  };
  extraPackages = with pkgs; [
    #formatter
    alejandra
    black
    prettierd
    google-java-format
    stylua
    rustfmt
    shfmt

    #linter
    statix
    selene
    python312Packages.flake8
    eslint_d
    python312Packages.demjson3
    checkstyle
  ];

  plugins.lint = {
    enable = true;
    lintersByFt = {
      nix = ["statix"];
      lua = ["selene"];
      python = ["flake8"];
      javascript = ["eslint_d"];
      javascriptreact = ["eslint_d"];
      typescript = ["eslint_d"];
      typescriptreact = ["eslint_d"];
      json = ["jsonlint"];
      java = ["checkstyle"];
    };
  };

  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_by_ft = {
        html = [["prettierd" "prettier"]];
        css = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        java = ["google-java-format"];
        python = ["black"];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [["prettierd" "prettier"]];
        rust = ["rustfmt"];
        sh = ["shfmt"];
      };
      notify_on_error = true;
      format_on_save = {};
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>lua require('lsp_lines').toggle()<CR>";
      options.desc = "Toggle Lines";
    }
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format()<cr>";
      options = {
        silent = true;
        desc = "Format Buffer";
      };
    }
  ];
}
