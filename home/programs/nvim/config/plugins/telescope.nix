{
  plugins.telescope = {
    enable = true;
    settings.defaults = {
      set_env.COLORTERM = "truecolor";
    };
    extensions = {
      file-browser.enable = true;
      fzf-native.enable = true;
      live-grep-args.enable = true;
      ui-select = {
        enable = true;
        settings = {
          __unkeyed-1.__raw = ''require("telescope.themes").get_dropdown{}'';
        };
      };
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
      # "<leader>s/" = { mode = "n"; action = live_grep; options = {
      #   grep_open_files = true;
      #   prompt_title = "Live Grep in Open Files";
      #   desc = "[S]earch [/] in Open FIles";
      #   };
      # };
    };
  };

  keymaps = [
   {
      mode = "n";
      key = "<leader>/";
      action.__raw = ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end
      '';
      options.desc = "[/] Fuzzily search in current buffer";
    }
    {
      mode = "n";
      key = "<leader>s/";
      action.__raw = ''
        function()
          require('telescope.builtin').live_grep({
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          })
        end
      '';
      options.desc = "[S]earch [/] in Open Files";
    }
    {
      mode = "n";
      key = "<leader>sn";
      action.__raw = ''
        function() 
          require('telescope.builtin').find_files { cwd = '/etc/nixos/home/programs/nvim/config' }
        end
      '';
      options.desc = "[S]earch [N]eovim files";
    }
  ];
}
