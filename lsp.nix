{pkgs, ...}: {
  plugins = {
    nix.enable = true;

    parinfer-rust.enable = true;
    rustaceanvim = {
      enable = true;
      settings = {
        server.default_settings.rust-analyzer.check.command = "clippy";
      };
    };

    vimtex.enable = true;

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

    render-markdown.enable = true;
    markdown-preview = {
      enable = true;
      settings.browser = "firefox";
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
    compiler.enable = true;
    overseer.enable = true;

    # TODO: Add keybinds
    refactoring = {
      enable = true;
      enableTelescope = true;
    };
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
          key = "<leader>ca";
          action = "<cmd>Lspsaga code_action<cr>";
          options.desc = "Code Action";
        }
        {
          key = "<leader>co";
          action = "<cmd>Lspsaga outline<cr>";
          options.desc = "Outline";
        }
        {
          key = "<leader>cr";
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
      ts_ls.enable = true; # TS/JS
      cssls.enable = true; # CSS
      html.enable = true; # HTML
      pyright.enable = true; # Python
      marksman.enable = true; # Markdown
      nil_ls.enable = true; # Nix
      bashls.enable = true; # Bash
      zls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      csharp_ls.enable = true; # C#
      yamlls.enable = true; # YAML
      texlab.enable = true; #Tex

      lua_ls = {
        # Lua
        enable = true;
        settings.telemetry.enable = false;
      };
    };
  };
  extraPackages = with pkgs; [
    # for compiler
    gcc
    binutils
    mono
    openjdk
    dart
    kotlin
    elixir
    nodejs
    typescript
    go
    nasm
    python3
    ruby
    perl
    lua
    swift
    flutter

    # for vimtex
    biber

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
      json = ["jsonlint"];
      java = ["checkstyle"];
    };
  };

  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        html = ["prettierd"];
        css = ["prettierd"];
        javascript = ["prettierd"];
        java = ["google-java-format"];
        python = ["black"];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = ["prettierd"];
        rust = ["rustfmt"];
        sh = ["shfmt"];
      };
      notify_on_error = true;
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };
  keymaps = [
    # compiler
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>CompilerOpen<cr>";
      options.silent = true;
      options.desc = "Open compiler";
    }
    {
      mode = "n";
      key = "<leader>cC";
      action = "<cmd>CompilerStop<cr><cmd>CompilerRedo<cr>";
      options.silent = true;
      options.desc = "Redo last compiler option";
    }
    {
      mode = "n";
      key = "<leader>c<C-c>";
      action = "<cmd>CompilerToggleResults<cr>";
      options.silent = true;
      options.desc = "Toggle compiler results";
    }

    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>MarkdownPreview<cr>";
      options.desc = "Markdown Preview";
    }

    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>lua require('lsp_lines').toggle()<CR>";
      options.desc = "Toggle lsp lines";
    }
    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua require('conform').format()<cr>";
      options = {
        silent = true;
        desc = "Format";
      };
    }
  ];
}
