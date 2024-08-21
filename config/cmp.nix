let
  keys = {
    "<C-Space>" = "cmp.mapping.complete()";
    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
    "<C-e>" = "cmp.mapping.close()";
    "<C-f>" = "cmp.mapping.scroll_docs(4)";
    "<CR>" = "cmp.mapping.confirm({ select = true })";
    "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
    "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
  };
in {
  plugins = {
    luasnip = {
      enable = true;
      fromVscode = [{}];
    };
    friendly-snippets.enable = true;
    lspkind = {
      enable = true;
      # mode = "symbol";
      preset = "codicons";
      symbolMap = {
        Text = "󰉿";
        Method = "󰆧";
        Function = "󰊕";
        Constructor = "";
        Field = "󰜢";
        Variable = "󰀫";
        Class = "󰠱";
        Interface = "";
        Module = "";
        Property = "󰜢";
        Unit = "󰑭";
        Value = "󰎠";
        Enum = "";
        Keyword = "󰌋";
        Snippet = "";
        Color = "󰏘";
        File = "󰈙";
        Reference = "󰈇";
        Folder = "󰉋";
        EnumMember = "";
        Constant = "󰏿";
        Struct = "󰙅";
        Event = "";
        Operator = "󰆕";
        TypeParameter = "";
      };
    };
    cmp = {
      enable = true;
      cmdline = {
        "/".mapping = keys;
        "/".sources = [{name = "buffer";}];
        "?".mapping = keys;
        "?".sources = [{name = "buffer";}];
        ":".mapping = keys;
        ":".sources = [
          {name = "path";}
          {
            name = "cmdline";
            option = {ignore_cmds = ["Man" "!"];};
          }
        ];
      };
      filetype = {
        gitcommit.sources = [
          {name = "cmp_git";}
          {name = "buffer";}
        ];
      };
      settings = {
        experimental.ghost_text = true;
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "path";}
        ];
        mapping = {
          "<CR>" =
            /*
            lua
            */
            ''
              cmp.mapping (function (fallback)
                if cmp.visible () then
                  if require("luasnip").expandable() then
                    require("luasnip").expand()
                  else
                    cmp.confirm({
                      select = true,
                    })
                  end
                else
                  fallback()
                end
              end)
            '';

          "<Tab>" =
            /*
            lua
            */
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif require("luasnip").locally_jumpable(1) then
                  require("luasnip").jump(1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';

          "<S-Tab>" =
            /*
            lua
            */
            ''
              cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif require("luasnip").locally_jumpable(-1) then
                  require("luasnip").jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" })
            '';
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.abort()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
        };
      };
    };
  };
  keymaps = [
    {
      mode = "i";
      key = "<C-K>";
      action = "<cmd>lua function() require(\"luasnip\".expand() end<cr>";
    }
    {
      mode = ["i" "s"];
      key = "<C-L>";
      action = "<cmd>lua function() require(\"luasnip\".jump(1) end<cr>";
    }
    {
      mode = ["i" "s"];
      key = "<C-J>";
      action = "<cmd>lua function() require(\"luasnip\".jump(-1) end<cr>";
    }
    {
      mode = ["i" "s"];
      key = "<C-E>";
      action = "<cmd>lua function() if ls.choice_active() then ls.change_choice(1) end end<cr>";
    }
  ];
}
