{
  plugins.telescope = {
    enable = true;

    extensions = {
      fzf-native = {
        enable = true;
      };
    };
    keymaps = {
      "<leader><space>" = {
        action = "find_files";
        options.desc = "Find project files";
      };
      "<leader>/" = {
        action = "live_grep";
        options.desc = "Grep (root dir)";
      };
      "<leader>:" = {
        action = "command_history";
        options.desc = "Command History";
      };
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Find project files";
      };
      "<leader>fr" = {
        action = "oldfiles";
        options.desc = "Recent";
      };
      "<leader>fb" = {
        action = "buffers";
        options.desc = "Buffers";
      };
      "<leader>gf" = {
        action = "git_files";
        options.desc = "Search git files";
      };
      "<leader>gc" = {
        action = "git_commits";
        options.desc = "Commits";
      };
      "<leader>gs" = {
        action = "git_status";
        options.desc = "Status";
      };
      "<leader>fa" = {
        action = "autocommands";
        options.desc = "Auto Commands";
      };
      "<leader>fz" = {
        action = "current_buffer_fuzzy_find";
        options.desc = "Search Buffer";
      };
      "<leader>fc" = {
        action = "command_history";
        options.desc = "Command History";
      };
      "<leader>fC" = {
        action = "commands";
        options.desc = "Commands";
      };
      "<leader>fD" = {
        action = "diagnostics";
        options.desc = "Workspace diagnostics";
      };
      "<leader>fh" = {
        action = "help_tags";
        options.desc = "Help pages";
      };
      "<leader>fH" = {
        action = "highlights";
        options.desc = "Search Highlight Groups";
      };
      "<leader>fk" = {
        action = "keymaps";
        options.desc = "Keymaps";
      };
      "<leader>fM" = {
        action = "man_pages";
        options.desc = "Man pages";
      };
      "<leader>fm" = {
        action = "marks";
        options.desc = "Jump to Mark";
      };
      "<leader>fo" = {
        action = "vim_options";
        options.desc = "Options";
      };
      "<leader>fR" = {
        action = "resume";
        options.desc = "Resume";
      };
      "<leader>fp" = {
        action = "projects";
        options.desc = "Projects";
      };
    };
  };
}
