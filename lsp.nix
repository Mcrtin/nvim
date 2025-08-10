{
  pkgs,
  lib,
  ...
}:
{
  plugins = {
    inc-rename.enable = true;
    parinfer-rust.enable = true;
    # rustaceanvim = {
    #   enable = true;
    #   # settings.tools.enable_clippy = true;
    # };

    vimtex = {
      enable = true;
      texlivePackage = pkgs.texlive.combined.scheme-full;
    };

    jdtls = {
      enable = false;
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
        extraOptions.init_options.diagnosticSeverity = "Hint";
      };
      ts_ls.enable = true; # TS/JS
      cssls.enable = true; # CSS
      html.enable = true; # HTML
      pyright.enable = true; # Python
      marksman.enable = true; # Markdown
      nil_ls.enable = true;
      jdtls.enable = true;
      nixd = {
        enable = true;
        settings = {
          formatting.command = [ "nix fmt" ];
          nixpkgs.expr = "import <nixpkgs> {}";
          options = {
            #TODO: make nixos a git repo
            # nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.$${builtins.getEnv \"USER\"}.options";
            # home_manager.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).homeConfigurations.\"martin@nixos\".options";
            nvim.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).packages.${pkgs.system}.full.options";
          };
        };
      };
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        installRustFmt = true;
        settings.check.command = lib.getExe pkgs.clippy;
      };
      bashls.enable = true; # Bash
      zls.enable = true;
      clangd.enable = true;
      cmake.enable = true;
      yamlls.enable = true; # YAML
      lua_ls.enable = true; # Lua
    };
  };

  extraPackages = with pkgs; [
    # for render-markdown
    python312Packages.pylatexenc

    # for vimtex
    biber

    #for bashls
    shfmt
    #for rust
    rustfmt
  ];

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
        html = [ "prettierd" ];
        css = [ "prettierd" ];
        javascript = [ "prettierd" ];
        python = [ "black" ];
        formatters = {
          black.command = lib.getExe pkgs.black;
          prettierd.command = lib.getExe pkgs.prettierd;
          google-java-format.command = lib.getExe pkgs.google-java-format;
        };
      };

      notify_on_error = true;
    };
  };

  keymaps = [
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
