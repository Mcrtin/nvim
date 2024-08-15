{
  plugins = {
    dap = {
      enable = true;
      signs = {
        dapBreakpoint = {
          text = "●";
          texthl = "DapBreakpoint";
        };
        dapBreakpointCondition = {
          text = "●";
          texthl = "DapBreakpointCondition";
        };
        dapLogPoint = {
          text = "◆";
          texthl = "DapLogPoint";
        };
      };
      extensions = {
        dap-ui = {
          enable = true;
          floating.mappings = {
            close = [ "<ESC>" "q" ];
          };
        };
        dap-virtual-text.enable = true;
      };
      configurations = {
        java = [
          {
            type = "java";
            request = "launch";
            name = "Debug (Attach) - Remote";
            hostName = "127.0.0.1";
            port = 5005;
          }
        ];
      };
    };
    neotest = {
      enable = true;
      adapters = {
        java.enable = true;
      };
    };
  };

  keymaps = [
    # Neotest
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>lua require('neotest').run.run(vim.fn.expand '%')<CR>";
      options = {
        desc = "Run File";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tT";
      action = "<cmd>lua require('neotest').run.run(vim.loop.cwd())<CR>";
      options = {
        desc = "Run All Test Files";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tr";
      action = "<cmd>lua require('neotest').run.run()<CR>";
      options = {
        desc = "Run Nearest";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>td";
      action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>";
      options = {
        desc = "Run Nearest with debugger";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = "<cmd>lua require('neotest').summary.toggle()<CR>";
      options = {
        desc = "Toggle Summary";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>to";
      action = "<cmd>lua require('neotest').output.open{ enter = true, auto_close = true }<CR>";
      options = {
        desc = "Show Output";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tO";
      action = "<cmd>Neotest output-panel toggle<CR>";
      options = {
        desc = "Toggle Output Panel";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>tS";
      action = "<cmd>lua require('neotest').run.stop()<CR>";
      options = {
        desc = "Stop";
        silent = true;
      };
    }

    # dap
    {
      mode = "n";
      key = "<leader>dB";
      action = "
        <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
      ";
      options = {
        silent = true;
        desc = "Breakpoint Condition";
      };
    }
    {
      mode = "n";
      key = "<leader>db";
      action = ":DapToggleBreakpoint<cr>";
      options = {
        silent = true;
        desc = "Toggle Breakpoint";
      };
    }
    {
      mode = "n";
      key = "<leader>dc";
      action = ":DapContinue<cr>";
      options = {
        silent = true;
        desc = "Continue";
      };
    }
    {
      mode = "n";
      key = "<leader>da";
      action = "<cmd>lua require('dap').continue({ before = get_args })<cr>";
      options = {
        silent = true;
        desc = "Run with Args";
      };
    }
    {
      mode = "n";
      key = "<leader>dC";
      action = "<cmd>lua require('dap').run_to_cursor()<cr>";
      options = {
        silent = true;
        desc = "Run to cursor";
      };
    }
    {
      mode = "n";
      key = "<leader>dg";
      action = "<cmd>lua require('dap').goto_()<cr>";
      options = {
        silent = true;
        desc = "Go to line (no execute)";
      };
    }
    {
      mode = "n";
      key = "<leader>di";
      action = ":DapStepInto<cr>";
      options = {
        silent = true;
        desc = "Step into";
      };
    }
    {
      mode = "n";
      key = "<leader>dj";
      action = "
        <cmd>lua require('dap').down()<cr>
      ";
      options = {
        silent = true;
        desc = "Down";
      };
    }
    {
      mode = "n";
      key = "<leader>dk";
      action = "<cmd>lua require('dap').up()<cr>";
      options = {
        silent = true;
        desc = "Up";
      };
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = "<cmd>lua require('dap').run_last()<cr>";
      options = {
        silent = true;
        desc = "Run Last";
      };
    }
    {
      mode = "n";
      key = "<leader>do";
      action = ":DapStepOut<cr>";
      options = {
        silent = true;
        desc = "Step Out";
      };
    }
    {
      mode = "n";
      key = "<leader>dO";
      action = ":DapStepOver<cr>";
      options = {
        silent = true;
        desc = "Step Over";
      };
    }
    {
      mode = "n";
      key = "<leader>dp";
      action = "<cmd>lua require('dap').pause()<cr>";
      options = {
        silent = true;
        desc = "Pause";
      };
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = ":DapToggleRepl<cr>";
      options = {
        silent = true;
        desc = "Toggle REPL";
      };
    }
    {
      mode = "n";
      key = "<leader>ds";
      action = "<cmd>lua require('dap').session()<cr>";
      options = {
        silent = true;
        desc = "Session";
      };
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = ":DapTerminate<cr>";
      options = {
        silent = true;
        desc = "Terminate";
      };
    }
    {
      mode = "n";
      key = "<leader>du";
      action = "<cmd>lua require('dapui').toggle()<cr>";
      options = {
        silent = true;
        desc = "Dap UI";
      };
    }
    {
      mode = "n";
      key = "<leader>dw";
      action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
      options = {
        silent = true;
        desc = "Widgets";
      };
    }
    {
      mode = [ "n" "v" ];
      key = "<leader>de";
      action = "<cmd>lua require('dapui').eval()<cr>";
      options = {
        silent = true;
        desc = "Eval";
      };
    }
  ];
}
