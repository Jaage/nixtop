let find_files = "
  function() 
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end";
  current_buf_fzf = "
    function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end";
  live_grep = "
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end";
in
{
  plugins.telescope = {
    enable = true;
    extensions = {
      file-browser.enable = true;
      fzf-native.enable = true;
      live-grep-args.enable = true;
      ui-select.enable = true;
    };

    keymaps = {
      "<leader>sh" = { mode = "n"; action = "help_tags"; options.desc = "[S]earch [H]elp"; };
      "<leader>sk" = { mode = "n"; action = "keymaps"; options.desc = "[S]earch [K]eymaps"; };
      "<leader>sf" = { mode = "n"; action = "find_files"; options.desc = "[S]earch [F]iles"; };
      "<leader>ss" = { mode = "n"; action = "builtin"; options.desc = "[S]earch [S]elect Telescope"; };
      "<leader>sw" = { mode = "n"; action = "grep_string"; options.desc = "[S]earch current [W]ord"; };
      "<leader>sg" = { mode = "n"; action = "live_grep"; options.desc = "[S]earch by [G]rep"; };
      "<leader>sd" = { mode = "n"; action = "diagnostics"; options.desc = "[S]earch [D]iagnostics"; };
      "<leader>sr" = { mode = "n"; action = "resume"; options.desc = "[S]earch [R]esume"; };
      "<leader>s." = { mode = "n"; action = "oldfiles"; options.desc = "[S]earch Recent Files ('.' for repeat)"; };
      "<leader><leader>" = { mode = "n"; action = "buffers"; options.desc = "[ ] Find existing buffers"; };
      # "<leader>/" = { mode = "n"; action = current_buf_fzf; options.desc = "[/] Fuzzily search in current buffer"; };
      # "<leader>s/" = { mode = "n"; action = live_grep; options = {
      #   grep_open_files = true;
      #   prompt_title = "Live Grep in Open Files";
      #   desc = "[S]earch [/] in Open FIles";
      #   };
      # };
      "<leader>sn" = { mode = "n"; action = find_files; options.desc = "[S]earch Neovim files"; };
      "<leader>/" = { mode = "n"; action = "
        function() 
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end
        "; options.desc = "[S]earch [/] in Open Files"; };
    };
  };
}
