{ config, pkgs, ... }:

{
  systemd.user.services.google-task-alerts = {
    Unit = {
      Description = "Google Task Alerts";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.bash}/bin/bash /home/arya/.emacs.d/scripts/google-tasks.sh";
      ExecStopPost = "${pkgs.libnotify}/bin/notify-send \"Tasks Manager\" \"Service Failed. Is network running? Are tasks well defined?\"";
      Restart = "on-failure";
      
    };
    Install = {
      WantedBy = [ "multi-user.target" ];
    };
  };

  

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    bash.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      nix-direnv.enableFlakes = true;
    };
    vim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        zenburn fugitive
      ];
      extraConfig = ''
    colorscheme zenburn
    set mouse=a
    '';
    };

    emacs = {
      enable = true;
      extraPackages = pkgs.callPackage ./emacs.nix {};

      overrides = self: super: {
        org-google-tasks = self.melpaBuild {
          pname = "org-google-tasks";
          version = "0.0.1";
          src = fetchTarball {
            url = "https://github.com/SidharthArya/org-google-tasks/archive/main.tar.gz";
          };
          recipe = pkgs.writeText "recipe" ''
       (org-google-tasks :fetcher github :repo "SidharthArya/org-google-tasks" :files (:defaults))
       '';
        };

        browse-rules = self.melpaBuild {
          pname = "browse-rules";
          version = "0.0.1";
          src = fetchTarball {
            url = "https://github.com/SidharthArya/browse-rules.el/archive/master.tar.gz";
          };
          recipe = pkgs.writeText "recipe" ''
        (browse-rules :fetcher github :repo "SidharthArya/browse-rules.el" :files (:defaults))
       '';
        };
        helm-org-roam = self.melpaBuild {
          pname = "helm-org-roam";
          version = "0.0.1";
          src = fetchTarball {
            url = "https://github.com/SidharthArya/helm-org-roam/archive/main.tar.gz";
          };
          recipe = pkgs.writeText "recipe" ''
      (helm-org-roam :fetcher github :repo "SidharthArya/helm-org-roam" :files (:defaults))
       '';
        };

        org-roam-server = self.melpaBuild {
          pname = "org-roam-server";
          version = "0.0.1";
          src = fetchTarball {
            url = "https://github.com/SidharthArya/org-roam-server/archive/master.tar.gz";
          };
          recipe = pkgs.writeText "recipe" ''
      (org-roam-server :fetcher github :repo "SidharthArya/org-roam-server" :files (:defaults "index.html" "assets"))
       '';
        };
        
      };
      
    };
    texlive = {
      enable = true;
    };
    password-store = {
      enable = true;
      package = pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-genphrase ]);
    };
    rofi.pass = {
      enable = true;
      stores = ["~/.local/share/password-store"];
    };
    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
      enableCompletion = true;
      shellAliases = {
        hm = "home-manager";
        ls = "exa --icons";
        df = "duf";
      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = ["git" "tmux" "python"];
      };
      initExtra = ''
      source ~/.config/zsh/.p10k.zsh
      source ~/.local/scripts/personal.sh
      eval $(thefuck --alias)
      '';
    };
    tmux = {
      enable = true;
      clock24 = false;
      extraConfig = ''
      set-option -g renumber-windows on
      set -g status-bg black
      set -g status-fg white
      set -g default-terminal "screen-256color"
    '';             
    };

    git = {
      enable = true;
      userName  = "Sidharth Arya";
      userEmail = "sidhartharya10@gmail.com";
      signing = {
        key = "4881651806D31166";
        signByDefault = true;
      };
      extraConfig = {
        commit.gpgsign         = true;
        github.user            = "SidharthArya";
      };
    };
    gh = {
      enable = true;
    };
  };
  
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  };

  home.sessionVariables = {
    TERM = "xterm-256color";
    EDITOR = "vim";
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "arya";
    homeDirectory = "/home/arya";
    packages = pkgs.callPackage ./packages.nix {};
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
