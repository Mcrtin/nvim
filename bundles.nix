{
  plugins.snacks = {
    enable = true;
    settings = {
      indent = {
        enabled = true;
        only_scope = true;
        animate.enabled = false;
      };
      bigfile.enabled = true;
      quickfile.enabled = true;
      words.enabled = true;
    };
  };

  plugins.mini = {
    enable = true;
    modules = {
      icons = {};
      map = {};
      bracketed = {};
      diff = {};
      jump = {};
      operators.exchange.prefix = "gX";

      # basics = {
      #   options = false;
      #   mappings = {
      #     basics = false;
      #     windows = true;
      #   };
      #   autocommands = false;
      # };
    };
  };

  keymaps = [
    {
      mode = ["n" "t"];
      key = "]]";
      action = "function() Snacks.words.jump(vim.v.count1) end";
      options.desc = "Next Reference";
    }
    {
      mode = ["n" "t"];
      key = "[[";
      action = "function() Snacks.words.jump(-vim.v.count1) end";
      options.desc = "Prev Reference";
    }
    {
      mode = ["n"];
      key = "mt";
      action = "lua MiniMap.toggle()<cr>";
      options.desc = "Toggle Minimap";
    }
    {
      mode = ["n"];
      key = "<leader>gD";
      action = "lua MiniDiff.toggle_overlay()";
      options.desc = "Toggle inline diff";
    }
  ];
}
