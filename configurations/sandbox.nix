{ lib, pkgs, ... }:

{
  system.stateVersion = "25.11";

  users.users.sevinf = {
    group = "sevinf";
    isNormalUser = true;
  };

  users.groups.sevinf = { };

  services.lima.enable = true;
  services.openssh.enable = true;

  security = {
    sudo.wheelNeedsPassword = false;
  };


  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/boot" = {
    device = lib.mkForce "/dev/vda1"; # /dev/disk/by-label/ESP
    fsType = "vfat";
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" ];
  };
}
