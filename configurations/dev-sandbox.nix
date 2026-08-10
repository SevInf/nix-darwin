{ pkgs, unstable, lib, ... }:
{
  users.users.sevinf = {
    group = "sevinf";
    uid = 1500;
    isNormalUser = true;
    home = "/home/sevinf";
    shell = pkgs.zsh;
  };
  users.groups.sevinf = { };
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  networking.hostName = "dev-sandbox";
  environment.systemPackages = with pkgs; [
    ghostty.terminfo
    unstable.claude-code
    unstable.pi-coding-agent
  ];

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
    device = lib.mkForce "/dev/vda1"; # /dev/disk/by-label/ESP
    fsType = "vfat";
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
    options = [ "noatime" "nodiratime" "discard" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "26.05";
}
