{
  plugins.which-key = {
    enable = true;
    settings = {
      event = "VimEnter";
      delay = 0;
      # Document existing key chains
      spec = [
        { __unkeyed-1 = "<leader>s"; group = "[S]earch"; }
        { __unkeyed-1 = "<leader>t"; group = "[T]oggle"; }
        { __unkeyed-1 = "<leader>h"; group = "Git [H]unk"; mode = [ "n" "v" ]; }
      ];
    };
  };
}
