{  pkgs, lib, ... }:
{
    users.users.sevinf = {
      group = "sevinf";
      uid = 1500;
      isNormalUser = true;
      home = "/home/sevinf";
      shell = pkgs.zsh;
    };
    users.groups.sevinf = {};

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
    fileSystems."/boot" = {
        device = lib.mkForce "/dev/vda1";  # /dev/disk/by-label/ESP
        fsType = "vfat";
    };
    fileSystems."/" = {
        device = "/dev/disk/by-label/nixos";
        autoResize = true;
        fsType = "ext4";
        options = [ "noatime" "nodiratime" "discard" ];
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;

    system.stateVersion = "25.11";
}
