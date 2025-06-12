# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Flakes and binaries source
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];
    trusted-users = [
      "root"
      "allmight"
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  #  boot.kernelPackages = pkgs.linuxPackages;
  #  chaotic.scx.enable = true;
  #  chaotic.scx.scheduler = "scx_lavd";
  #  boot.kernelParams = [ "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1" ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 0;
    # DXVK_HDR = 1;
    MANGOHUD = "1";
    MANGOHUD_CONFIGFILE = "/home/allmight/.config/MangoHud/MangoHud.conf";
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  # Run
  #  programs.nix-ld = {
  #    enable = true;
  #    libraries = pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
  #  };
  programs.appimage.binfmt = true;

  networking.hostName = "ua"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # Enable the KDE Plasma Desktop Environment
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;
  environment.plasma6.excludePackages = with pkgs.libsForQt5; [
    elisa
    plasma-browser-integration
    oxygen
    kate
  ];

  # Graphics
  hardware.graphics = {
    extraPackages = with pkgs; [
      mangohud
      nvidia-vaapi-driver
    ];
    extraPackages32 = with pkgs; [ mangohud ];
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    #   modesetting.enable = true;
    #    powerManagement.enable = false;
    open = true;
    #    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Logitech
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Security
  security = {
    rtkit.enable = true;
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.allmight = {
    isNormalUser = true;
    extraGroups = [
      "network_manager"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
  };

  # Enable direnv for caching dev environments
  programs.direnv.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
    nixpkgs.config.nvidia.acceptLicense = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Browser
    firefox

    # CLI
    bat
    btop
    eza
    devenv
    fastfetch
    fd
    ffmpeg
    file
    fzf
    git
    gzip
    linuxPackages_latest.perf
    nix-prefetch
    pigz
    protonup-qt
    ripgrep
    smartmontools
    starship
    stow
    unzip
    wget
    winetricks
    wl-clipboard
    zoxide

    # Fonts
    nerd-fonts.proggy-clean-tt
    nerd-fonts.gohufont

    # Formatters
    nixfmt-rfc-style

    # Terminal
    ghostty

    # Programs
    betterdiscordctl
    discord
    heroic
    lutris
    mangohud
    obs-studio
    inputs.nixvim.packages.x86_64-linux.default
    path-of-building
    solaar
    vim
    wowup-cf
  ];

  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  nixpkgs.overlays = [
    (final: prev: {
      discord = prev.discord.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ final.makeWrapper ];
        postInstall =
          (old.postInstall or "")
          + ''
            wrapProgram $out/bin/discord --add-flags '--disable-gpu'
          '';
      });
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
