{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "peglah";
  home.homeDirectory = "/home/peglah";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/peglah/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    bash = {
      enable = true;
      initExtra = ''
	hyfetch
	set -o vi
      '';
      shellAliases = {
        cat = "bat";
        cls = "clear && hyfetch";
        diff = "diff --color=auto";
        grep = "grep --color=auto";
        ip = "ip -color=auto";
        ls = "exa --icons --group-directories-first";
        v = "fd --type f --hidden --exclude .git --color=always | fzf-tmux -p 80%,50% --ansi | nvim";
        vim = "nvim";
        wt = "wtwitch";
      };
    };

    hyfetch = {
      enable = true;
      settings = {
        preset = "rainbow";
	mode = "rgb";
	color_align = {
	  mode = "horizontal";
	};
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    tmux = {
      baseIndex = 1;
      clock24 = true;
      enable = true;
      keyMode = "vi";
      mouse = false;
      newSession = true;
      prefix = "C-a";
      sensibleOnTop = true;
      terminal = "screen-256color";
      extraConfig = ''
        source-file ${./config/tmux/tmux.conf}
        source-file ${./config/tmux/gruvbox.tmux}
        source-file ${./config/tmux/tmux.nvim.tmux}
      '';
    };

    wezterm = {
      enable = true;
      extraConfig = ''
        return {
  	  color_scheme = "GruvboxDark",
  	  font = wezterm.font("FiraCode Nerd Font Mono Med", { weight = "Bold" }),
	}
      '';
    }; 
  };
  
  xdg.configFile = {
    nvim = {
      source =
        config.lib.file.mkOutOfStoreSymlink
          "${config.home.homeDirectory}/.config/home-manager/config/nvim";
      recursive = true;
    };
  };
}
