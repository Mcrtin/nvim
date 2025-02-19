{pkgs, ...}: {
  plugins = {
    inc-rename.enable = true;

    parinfer-rust.enable = true;
    rustaceanvim = {
      enable = true;
      settings = {
        tools.enable_clippy = true;
        server.default_settings = {
          inlayHints.lifetimeElisionHints.enable = "always";
        };
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
      settings.browser = "xdg-open";
    };

    openscad.enable = true;

    lspsaga = {
      enable = true;
      lightbulb.virtualText = false;
      symbolInWinbar.enable = false;
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
          key = "<leader>cr";
          action = ":IncRename ";
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
      typos_lsp = {
        enable = true;
        extraOptions = {
          init_options.diagnosticSeverity = "Hint";
        };
      };
      ts_ls.enable = true; # TS/JS
      cssls.enable = true; # CSS
      html.enable = true; # HTML
      pyright.enable = true; # Python
      marksman.enable = true; # Markdown
      nil_ls.enable = true;
      nixd = {
        enable = true;
        settings = {
          formatting.command = ["alejandra"];
          nixpkgs.expr = "import <nixpkgs> {}";
          options = {
            nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.$${builtins.getEnv \"USER\"}.options";
            # home_manager.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).homeConfigurations.\"martin@nixos\".options";
            nvim.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).packages.${pkgs.system}.full.options";
          };
        };
      };
      bashls.enable = true; # Bash
      zls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
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
    # for render-markdown
    python312Packages.pylatexenc

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
    shfmt

    #linter
    selene
    python312Packages.flake8
    eslint_d
    python312Packages.demjson3
    checkstyle
  ];
  extraConfigLua = ''    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    	callback = function()
    		require("lint").try_lint()
    	end,
    })'';
  plugins.lint = {
    enable = true;
    lintersByFt = {
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
      format_on_save =
        # Lua
        ''
          function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end
            return { timeout_ms = 500, lsp_format = "fallback" }
          end
        '';
      formatters_by_ft = {
        html = ["prettierd"];
        css = ["prettierd"];
        javascript = ["prettierd"];
        java = ["google-java-format"];
        python = ["black"];
        sh = ["shfmt"];
        "*" = ["injected"];
      };
      notify_on_error = true;
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
      key = "<leader>ll";
      action = "<cmd>lua require('lsp_lines').toggle()<CR>";
      options.desc = "Toggle lsp lines";
    }

    {
      mode = "n";
      key = "<leader>cf";
      action = "<cmd>lua vim.b.disable_autoformat = not vim.b.disable_autoformat; if not vim.b.disable_autoformat then require('conform').format() end<cr>";
      options = {
        silent = true;
        desc = "Toggle autoformat for buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>cF";
      action = "<cmd>lua vim.g.disable_autoformat = not vim.g.disable_autoformat; if not vim.g.disable_autoformat then require('conform').format() end<cr>";
      options = {
        silent = true;
        desc = "Toggle autoformat globally";
      };
    }
  ];
}
