{
  config,
  pkgs,
  ...
}: {
  # Username and home directory
  home.username = "jerome";
  home.homeDirectory = "/home/jerome";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fastfetch
    # eza
    fzf
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    killall
    # Test copy paste in neovim
    wl-clipboard

    # Productivity
    glow

    # Monitoring
    btop
    iotop
    iftop

    # System tools
    sysstat
    ethtool
    pciutils
    usbutils

    # Application
    bottles

    # Developpement
    #elixir_1_18
    elixir
    elixir-ls
    erlang

    # Claude Code
    claude-code

    # Qobuz
    qbz

    # Shell
    #fish
  ];

  # Claude Cowork
  #programs.claude-desktop = {
  #  enable = true;
  #  fhs = true;
  #};

  # Terminal configuration
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    installVimSyntax = true;
    settings = {
      window-decoration = true;
      font-size = 11;
    };
  };

  # Basic configuration of git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Jérôme Lerouge";
      user.email = "jerome.lerouge@gmail.com";
      init.defaultBranch = "main";
    };
  };

  # Basic configuration of fish
  programs.fish = {
    enable = true;
    shellAliases = {
      "lla" = "eza -lah --no-quotes --time-style long-iso";
      "gc" = "bunx @google/gemini-cli";
    };
  };

  ## Neovvim configuration
  #programs.neovim = {
  #  enable = true;
  #  defaultEditor = true;
  #};

  # Home.sessionVariables pour AVANTE_GEMINI_API_KEY
  home.sessionVariables = {
    AVANTE_GEMINI_API_KEY = "";
  };

  # NVF for the Neovim nixosConfigurations
  programs.nvf = {
    enable = true;
    defaultEditor = true;
    settings.vim = {
      theme = {
        enable = true;
        name = "tokyonight";
        #name = "gruvbox";
        style = "night";
        transparent = true;
      };

      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };

      #assistant = {
      #  #  neocodeium = {
      #  # enable = true;
      #  # keymaps.accept = "ga";
      #  # };
      #  avante-nvim = {
      #    enable = true;
      #    setupOpts = {
      #      provider = "gemini";
      #      providers = {
      #        gemini = {
      #          model = "gemini-2.5-flash";
      #        };
      #      };
      #    };
      #  };
      #};

      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
        lspSignature.enable = true;
        lightbulb.enable = true;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix = {
          #enable = config.hmModules.dev.nix.enable;
          enable = true;
          format.enable = true;
          lsp = {
            enable = true;
            # package = pkgs.nil;
          };
          treesitter.enable = true;
        };

        elixir = {
          enable = true;
          elixir-tools.enable = true;
          format.enable = true;
          lsp.enable = true;
          # lsp.package = pkgs.elixir-ls;
          lsp.servers = ["elixir-ls"];
          treesitter.enable = true;
        };

        markdown = {
          enable = true;
          format.enable = true;
          lsp = {
            enable = true;
          };
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
        nvim-cursorline.enable = true;
      };

      # Source : https://github.com/NotAShelf/nvf/blob/main/configuration.nix
      ui = {
        noice.enable = true;
      };

      autopairs.nvim-autopairs.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      telescope.enable = true;
      treesitter.enable = true;
      statusline.lualine.enable = true;
      utility.motion.leap.enable = true;
      autocomplete.nvim-cmp.enable = true;
    };
  };

  # Basic configuration of bun for bunx & gemini-cli
  programs.bun = {
    enable = true;
  };

  # Basic Configuration of quteBrowser
  programs.qutebrowser = {
    enable = false;
  };

  # Eza Configuration
  programs.eza = {
    enable = true;
    icons = "always";
    git = true;
    enableFishIntegration = true;
  };

  # Configure Gnome
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-left = ["<Super>j"];
      switch-to-workspace-right = ["<Super>k"];
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "ghostty.desktop"
        "firefox.desktop"
      ];
    };
  };

  # SSH agent - gère les clés SSH en session utilisateur
  services.ssh-agent.enable = true;

  # You can update home Manager without chnaging this value.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself
  programs.home-manager.enable = true;

  #  # Let configure packages with theirs owns directories
  #  imports = [
  #    ./packages/fish.nix
  #  ];
}
