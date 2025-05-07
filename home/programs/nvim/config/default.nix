{self, ...}: {

  # Import all your configuration modules here
  imports = [ 
    ./bufferline.nix
    ./options.nix
  ];
  
  globals = {
    mapleader = " ";
    maplocalleader = " ";
    have_nerd_font = true;
  };
}
