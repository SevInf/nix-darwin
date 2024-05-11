{ config, pkgs, ... }: 

{
    home = {
        username = "sevinf";
        homeDirectory = "/Users/sevinf";
        stateVersion = "23.11";

        sessionVariables = {
            EDITOR = "nvim";
            LSCOLORS = "Gxfxcxdxbxegedabagacad";
            LS_COLORS = "di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43";
            CLICOLORS = "1";
        };

        shellAliases = {
            ls = "ls -G";
        };
    };


    programs = {
        home-manager = { enable = true; };

        zsh = {
            enable = true;
            initExtra = ''
                autoload -U colors
                zstyle ':completion:*' menu select
            '';
            syntaxHighlighting = { enable = true; };
            historySubstringSearch = { enable = true; };
        };

        zoxide = { enable = true; };
        direnv = { enable = true; };

        starship = {
            enable = true;
            settings = {
                format = "$all";
                right_format = "$git_branch$git_commit$git_state$git_status";
                git_branch = {
                    format = "[$symbol$branch(:$remote_branch)]($style) ";
                };
                package = {
                    disabled = true;
                };
                cmd_duration = {
                    disabled = true;
                };
                nodejs = {
                    format = "[$symbol($version )]($style)";
                };
                rust = {
                    format = "[$symbol($version )]($style)";
                };
                nix_shell = {
                    format = "$symbol";
                };
            };

        };

        tmux = {
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
                {
                    plugin = resurrect;
                }
                {
                    plugin = better-mouse-mode;
                }
            ];
        };

        git = {
            enable = true;
            userName = "Serhii Tatarintsev";
            userEmail = "sergey@tatarintsev.me";
            difftastic.enable = true;
            aliases = {
                amend = "commit -a --amend --no-edit";
                log-mine = "!sh -c 'git log --author \"$(git config --get user.name)\"'";
            };

            extraConfig = {
                push = {
                    default = "simple";
                    autoSetupRemote = true;
                };
                color.ui = true;
                merge.conflictstyle = "zdiff3";
                branch.autosetuprebase = "always";
                init.defaultBranch = "main";
                rerere.enabled = true;
                pull.rebase = true;
                diff.algorithm = "histogram";
            };
            ignores = [
                ".DS_Store"
                ".AppleDouble"
                ".LSOverride"
                "Icon"
                "._*"
                ".Spotlight-V100"
                ".Trashes"
                ".*.s[a-w][a-z]"
                "*.un~"
                "Session.vim"
                ".netrwhist"
                "*~"
                ".idea"
                ".lvimrc"
                "*.code-workspace"
            ];
        };
    };
}