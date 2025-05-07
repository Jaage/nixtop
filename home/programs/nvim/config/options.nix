{self, ...}: {

  globals = {
    mapleader = " ";
    maplocalleader = " ";
    have_nerd_font = true;
  };

  opts = {
    number = true;
    mouse = "a";
    showmode = false;
    clipboard = "unnamedplus";
    breakindent = true;
    undofile = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    updatetime = 250;
    timeoutlen = 100;
    splitright = true;
    splitbelow = true;
    list = true;
    listchars = { tab = "» "; trail = "·"; nbsp = "␣" ; };
    # Preview substitutions live, as you type!
    inccommand = "split";
    # Show which line your cursor is on
    cursorline = true;
    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;
    # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
    # instead raise a dialog asking if you wish to save the current file(s)
    # See `:help 'confirm'`
    confirm = true;
  };
}
