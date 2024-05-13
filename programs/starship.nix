{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$all";
      right_format = "$git_branch$git_commit$git_state$git_status";

      character = {
        success_symbol = "[ I ](black bg:green) [❯](green)";
        error_symbol = "[ I ](black bg:green) [❯](red)";
        vimcmd_symbol = "[ N ](black bg:blue) [❯](green)";
      };
      git_branch = { format = "[$symbol$branch(:$remote_branch)]($style) "; };
      package = { disabled = true; };
      cmd_duration = { disabled = true; };
      nodejs = { format = "[$symbol($version )]($style)"; };
      rust = { format = "[$symbol($version )]($style)"; };
      nix_shell = { format = "$symbol"; };
    };

  };
}
