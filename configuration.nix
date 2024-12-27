{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    fzf
    gh
    python3
    rustup
    htop
    wget
    jq
    tmux
    fd
    bat
    eza
    ripgrep
    nixpkgs-fmt
    nil
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.settings.experimental-features = "nix-command flakes";

  programs.zsh.enable = true;

  system.configurationRevision =
    inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  fonts.packages = [ pkgs.fira-code pkgs.fira-code-nerdfont ];

  environment = { shells = [ pkgs.zsh ]; };

  homebrew = {
    enable = true;
    casks = [
      "vivaldi"
      "visual-studio-code"
      "whatsapp"
      "1password"
      "slack"
      "ghostty"
    ];

    masApps = {
      "Telegram" = 747648890;
      "The Unarchiver" = 425424353;
      "Xcode" = 497799835;
      "DaisyDisk" = 411643860;
    };
  };

  system.defaults = {
    dock = {
      orientation = "left";
      show-recents = false;
      persistent-apps = [
        "/System/Applications/Calendar.app"
        "/System/Applications/Mail.app"
        "/Applications/Vivaldi.app"
        "/Applications/Telegram.app"
        "/Applications/WhatsApp.app"
        "/Applications/Ghostty.app"
        "/System/Applications/Music.app"
        "/System/Applications/Reminders.app"
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
    };

    screencapture = { type = "png"; };

    trackpad = { TrackpadRightClick = true; };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      NSAutomaticSpellingCorrectionEnabled = false;
    };

    CustomSystemPreferences = {
      NSGlobalDomain = {
        TISRomanSwitchState = 1;
      };
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  users.users.sevinf = {
    name = "sevinf";
    home = "/Users/sevinf";
    description = "Serhii Tatarintsev";
    shell = pkgs.zsh;
  };

}
