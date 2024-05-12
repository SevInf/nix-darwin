{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";

    extraConfig = ''
      set -g status off
      set -g status-bg white
      bind | split-window -h
      bind - split-window -v
      bind < rotate-window
      bind > rotate-window -D
    '';

    plugins = with pkgs.tmuxPlugins; [
      { plugin = resurrect; }
      {
        plugin = yank;
        extraConfig = ''
          set -g @yank_action 'copy-pipe'
        '';
      }
    ];
  };
}
