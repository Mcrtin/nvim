{
  autoGroups = {
    alpha_on_empty = { };
  };
  autoCmd = [
    {
      event = "User";
      pattern = "BDeletePre *";
      group = "alpha_on_empty";
      callback = {
        __raw = ''
          function()
          local bufnr = vim.api.nvim_get_current_buf()
          local name = vim.api.nvim_buf_get_name(bufnr)
          if name == "" then
            vim.cmd([[:Alpha | bd#]])
              end
              end
        '';
      };
    }
  ];
  plugins = {
    bufdelete.enable = true;

    alpha = {
      enable = true;
      theme = "dashboard";
    };
  };
}
