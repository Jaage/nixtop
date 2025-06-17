{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  # Flakes
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # Impermanence
  #boot.initrd.systemd.services.rollback = {
  #  description = "Rollback ZFS datasets to a blank snapshot taken immediately after disko formatting.";
  #  wantedBy = [
  #    "initrd.target"
  #  ]; 
  #  after = [
  #    "zfs-import-zroot.service"
  #  ];
  #  before = [ 
  #    "sysroot.mount"
  #  ];
  #  path = with pkgs; [
  #    zfs
  #  ];
  #  unitConfig.DefaultDependencies = "no";
  #  serviceConfig.Type = "oneshot";
  #  script = ''
  #    zfs rollback -r zroot/root@blank && echo "blank rollback complete"
  #  '';
  #};
  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/log/journal/"machine-id
    ];
    files = [
      "etc/group"
      "etc/gshadow"
      "/etc/machine-id"
      "/etc/passwd"
      "/etc/shadow"
      "etc/subgid"
      "etc/subuid"
      "etc/zfs/zpool.cache"
    ];
  };

  networking.hostName = "nixos";
  networking.hostId = enter_an_8_byte_id_here
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  users.users.jjh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    # Create passwd with: sudo mkpasswd -m sha-512 "passwd_here" > /mnt/persist/passwords/user during installation
    hashedPasswordFile = "/persist/passwords/jjh";
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "25.11";
}
