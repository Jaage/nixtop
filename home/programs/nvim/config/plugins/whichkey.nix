# { nixvim.globals, ... }: {
{
  # options = import ../options.nix;

  plugins.which-key = {
    enable = true;
    settings = {
      event = "VimEnter";
      delay = 0;
      # icons = {
      #   # set icon mappings to true if you have a Nerd Font
      #   mappings = nixvim.globals.have_nerd_font;
      #   # If you are using a Nerd Font: set icons.keys to an empty table which will use the
      #   # default which-key.nvim defined Nerd Font icons, otherwise define a string table
      #   keys = nixvim.globals.have_nerd_font || {
      #     Up = "<Up> ";
      #     Down = "<Down> ";
      #     Left = "<Left> ";
      #     Right = "<Right> ";
      #     C = "<C-…> ";
      #     M = "<M-…> ";
      #     D = "<D-…> ";
      #     S = "<S-…> ";
      #     CR = "<CR> ";
      #     Esc = "<Esc> ";
      #     ScrollWheelDown = "<ScrollWheelDown> ";
      #     ScrollWheelUp = "<ScrollWheelUp> ";
      #     NL = "<NL> ";
      #     BS = "<BS> ";
      #     Space = "<Space> ";
      #     Tab = "<Tab> ";
      #     F1 = "<F1>";
      #     F2 = "<F2>";
      #     F3 = "<F3>";
      #     F4 = "<F4>";
      #     F5 = "<F5>";
      #     F6 = "<F6>";
      #     F7 = "<F7>";
      #     F8 = "<F8>";
      #     F9 = "<F9>";
      #     F10 = "<F10>";
      #     F11 = "<F11>";
      #     F12 = "<F12>";
      #   };
      # };
      # Document existing key chains
      spec = [
        { __unkeyed-1 = "<leader>s"; group = "[S]earch"; }
        { __unkeyed-1 = "<leader>t"; group = "[T]oggle"; }
        { __unkeyed-1 = "<leader>h"; group = "Git [H]unk"; mode = [ "n" "v" ]; }
      ];
    };
  };
}
