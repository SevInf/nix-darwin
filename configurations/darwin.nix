{
  inputs,
  pkgs,
  ...
}:

{

  system = {
    primaryUser = "sevinf";
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 7;
  };

  users.users.sevinf = {
    name = "sevinf";
    home = "/Users/sevinf";
    description = "Serhii Tatarintsev";
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    lima
    mas
    nixpkgs-fmt
    nil
  ];

  # The default Nix build user group ID was changed from 30000 to 350.
  # You are currently managing Nix build users with nix-darwin, but your
  # nixbld group has GID 350, whereas we expected 30000.
  # We do not recommend trying to change the group ID with macOS user
  # management tools without a complete uninstallation and reinstallation
  # of Nix.
  ids.gids.nixbld = 350;

  nix.enable = false;
  homebrew = {
    enable = true;
    casks = [
      "firefox"
      "google-chrome"
      "zed"
      "whatsapp"
      "signal"
      "1password"
      "slack"
      "ghostty"
      "orbstack"
    ];

    masApps = {
      "Telegram" = 747648890;
      "The Unarchiver" = 425424353;
      "Xcode" = 497799835;
      "DaisyDisk" = 411643860;
      "Velja" = 1607635845;
    };
  };

  system.defaults = {
    dock = {
      orientation = "left";
      show-recents = false;
      persistent-apps = [
        "/System/Applications/Calendar.app"
        "/System/Applications/Mail.app"
        "/Applications/Firefox.app"
        "/Applications/Telegram.app"
        "/Applications/Signal.app"
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

    screencapture = {
      type = "png";
    };

    trackpad = {
      TrackpadRightClick = true;
    };

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

  security.pam.services.sudo_local.touchIdAuth = true;

}
