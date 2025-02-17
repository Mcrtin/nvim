{
  plugins.yazi = {
    enable = true;
    settings = {
      open_for_directories = true;
      use_ya_for_events_reading = true;
      use_yazi_client_id_flag = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>o";
      action = "<cmd>Yazi<CR>";
      options.desc = "Open parent directory";
    }
    {
      key = "<leader><C-o>";
      action = "<cmd>Yazi cwd<cr>";
      options.desc = "Open the file manager in nvim's working directory";
    }
    {
      key = "<leader>O";
      action = "<cmd>Yazi toggle<cr>";
      options.desc = "Resume the last yazi session";
    }
  ];
}
