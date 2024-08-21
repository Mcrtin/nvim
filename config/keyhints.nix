{
  plugins.which-key = {
    enable = true;
    settings.spec = [
      {
        __unkeyed-1 = "<leader>f";
        desc = "+find";
      }
      {
        __unkeyed-1 = "<leader>s";
        desc = "+session";
      }
      {
        __unkeyed-1 = "<leader>g";
        desc = "+git";
      }
      {
        __unkeyed-1 = "<leader>l";
        desc = "+lsp";
      }
      {
        __unkeyed-1 = "<leader>i";
        desc = "+ui"; # TODO: add keys to ui
      }
      {
        __unkeyed-1 = "<leader>w";
        desc = "+windows";
      }
      {
        __unkeyed-1 = "<leader><Tab>";
        desc = "+tab";
      }
      {
        __unkeyed-1 = "<leader>h";
        desc = "+harpoon";
      }
      {
        __unkeyed-1 = "<leader>b";
        desc = "+buffer";
      }
      {
        __unkeyed-1 = "<leader>d";
        desc = "+debug";
      }
      {
        __unkeyed-1 = "<leader>c";
        desc = "+code";
      }
      {
        __unkeyed-1 = "<leader>t";
        desc = "+test";
      }
    ];
  };
}
