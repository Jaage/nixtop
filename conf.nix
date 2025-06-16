{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_14;

  # Impermanence
  #boot.initrd.systemd.services.rollback = {
  #description = "Rollback ZFS datasets to a blank snapshot taken immediately after disko formatting.";
  #wantedBy = [
  #  "initrd.target"
  #]; 
  #after = [
  #  "zfs-import-zroot.service"
  #];
  #before = [ 
  #  "sysroot.mount"
  #];
  #path = with pkgs; [
  #  zfs
  #];
  #unitConfig.DefaultDependencies = "no";
  #serviceConfig.Type = "oneshot";
  #script = ''
  #  zfs rollback -r zroot/root@blank && echo "blank rollback complete"
  #'';

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  users.users.jjh = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = "/persist/passwords/jjh";
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "25.11";
}
