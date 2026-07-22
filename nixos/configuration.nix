{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in

{
  imports = [
      ./hardware-configuration.nix
      ./hjem.nix
    ];

  # Environment variables
  environment.variables = {
    # Theming
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QS_ICON_THEME = "Chicago95";
    XCURSOR_THEME = "macOS-White";
    GTK_ICON_THEME = "Chicago95";
    XDG_ICON_THEME = "Chicago95";
    GDK_FONT_SCALE = "1";

    # Apps
    MOZ_USE_XINPUT2 = "1";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    # Hardware
    SDL_VIDEODRIVER = "wayland";
    WLR_RENDERER = "vulkan";
    WLR_DRM_NO_ATOMIC = "1";
    WLR_DRM_DEVICES = "/dev/dri/card2:/dev/dri/card1";
    SYNCOBJ_ENABLE = "1";

    # Nixos
    NIX_DIR = "/etc/nixos";
    NIX_CONF = "/etc/nixos/configuration.nix";
    NIX_FLAKE = "/etc/nixos/flake.nix";
    HJEM_FILE = "/etc/nixos/hjem.nix";
    NIXOS_OZONE_WL = "1";
    NIX_BUILD_SHELL = "zsh";
    CACHIX_AUTH_TOKEN = "sudo cat /run/secrets/cachix-key";

    # Home env
    HOME = "/home/lptlv";
    EDITOR = "flow";
    TERM = "foot";

    XDG_RUNTIME_DIR = "/run/user/1000";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_SCREENSHOTS_DIR = "$HOME/Pictures/Screenshots";
    XDG_DATA_DIRS = lib.mkDefault "/nix/store/i5l50mng77lc91g031sl2rivn4yab5ql-desktops/share:/home/lptlv/.nix-profile/share:/nix/profile/share:/home/lptlv/.local/state/nix/profile/share:/etc/profiles/per-user/lptlv/share:/nix/var/nix/profiles/default/share:/run/current-system/sw/share:/home/lptlv/.local/share:/home/lptlv/.icons";
    XDG_DCIM_DIR = "$HOME/Pictures";

    PATH = "/run/wrappers/bin:$HOME/.nix-profile/bin:/nix/profile/bin:$HOME/.local/state/nix/profile/bin:/etc/profiles/per-user/lptlv/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$HOME/.spicetify:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/Scripts";
    RUST_SRC_PATH = "$HOME/.cargo/bin";
  };

  # Services
  services = {
    udisks2.enable = true; # disk mount utils
    fwupd.enable = true; # Firmware updates
    printing.enable = true; # Printing stuff

    # iDescriptor deps
    avahi.enable = true;
    usbmuxd.enable = true;
  };

  # Installed Programs
  programs = {
    # Graphical Session
      # WM
      mango.enable = true;

      # Desktop Suite
      foot = {
        enable = true;
	enableZshIntegration = true;
	xdg.serverAutostart = true;
      };

      noctalia = {
        enable = true;
        systemd.enable = true;
        recommendedServices.enable = true;
      };

      # Display Manager
      noctalia-greeter.enable = true;

    # Applications
    idescriptor.enable = true; # iPhone tooling
    thunderbird.enable = true; # email client

    virt-manager.enable = true;
    steam.enable = true;

    # Spotify
    spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
       adblockify
       hidePodcasts
       shuffle
       bookmark
      ];
      theme = spicePkgs.themes.comfy;
      colorScheme = "Comfy"; # Use "Comfy" for Noctalia
    };

    # NixOS Apps and programs
    nix-index.enable = true;
    nix-index-database.comma.enable = true; # , pfetch and such
  };

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Derivations
    (pkgs.callPackage ./snappy-mango.nix {})

    # Flake inputs
    inputs.msnap.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Programs
    flow-control
    floorp-bin
    vesktop
    onlyoffice-desktopeditors
    qbittorrent-enhanced
    vlc
    prismlauncher
    lutris

    # Utils
    fzf # zsh plugin dep
    lsd # alternative ls
    libnotify

    # Themes
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    chicago95
    apple-cursor

    # File managing
    gnome-commander
    xarchiver
    qimgv

    # Various
    wineWow64Packages.stagingFull
    egl-wayland
    wofi # wlr portal selector

    # Noctalia plugins deps
    git # Source plugins
    evtest # Bongocat
    mpvpaper # Animated BG
    gpu-screen-recorder # i mean...

    # Overrides
      # override-name...

  ];

  # Fonts
  fonts.packages = with pkgs; [
    anakron
  ];

  # Nixpkgs settings & overlays
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
      #  "electron-40.10.5"
      ];
    };
    overlays = [
     /* (final: _prev: {
        pnpm_10_29_2 = final.pnpm_10;
      }) */
    ];
  };

  # Nix settings, utilities & QoL
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
    };
    extraOptions = ''
      keep-derivations = true
    '';
    optimise = {
      automatic = true;
      dates = "21:10";
    };
  };

  system = {
    stateVersion = "25.11";
    autoUpgrade = {
      enable = true;
      flags = [
        "--print-build-logs"
      ];
      dates = "19:20";
      allowReboot = false;
    };
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep-since 1d --keep 2 --no-gcroots";
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      xz
      bzip2
      zstd
      ncurses
      readline
      glib
      wayland
      alsa-lib
      pulseaudio
      udev
      mesa
      libGL
      vulkan-loader
      gtk3
      cairo
      pango
      atk
      gdk-pixbuf
      libpng
      libjpeg
      libtiff
      libwebp
      dbus
    ];
  };

  # Userspace
  time.timeZone = "Europe/Rome";
  users.users.lptlv = {
    isNormalUser = true;
    linger = true;
    description = "Lorenzo La Pietra";
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
    shell = pkgs.zsh;
  };

    # XDG desktop portal
    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        wlr = {
          enable = true;
          settings = {
            screencast = {
	      max_fps = 30;
	      chooser_type = "dmenu";
	      chooser_cmd = "${pkgs.wofi}/bin/wofi --show dmenu";
	    };
          };
        };
        extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr ];
        config = {
          common.default = [ "wlr" ];
        };
      };
      mime = {
	enable = true;
	defaultApplications = {
	  # Documents
	  "text/*" = "onlyoffice.desktop";
	  "application/pdf" = "onlyoffice.desktop";
	  "application/msword" = "onlyoffice.desktop";
	  "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice.desktop";
	  "application/vnd.ms-excel" = "onlyoffice.desktop";
	  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice.desktop";
	  "application/vnd.ms-powerpoint" = "onlyoffice.desktop";
	  "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice.desktop";

	  # File Managing
	  "inode/directory" = "org.gnome.gnome-commander.desktop";
	  "application/zip" = "xarchiver.desktop";
	  "application/x-tar" = "xarchiver.desktop";
	  "application/gzip" = "xarchiver.desktop";
	  "application/x-7z-compressed" = "xarchiver.desktop";
	  "application/vnd.rar" = "xarchiver.desktop";

	  # Media
	  "image/*" = "qimgv.desktop";
	  "video/*" = "vlc.desktop";
	  "audio/*" = "vlc.desktop";

	  # Mail
	  "x-scheme-handler/mailto" = "thunderbird.desktop";
	  "message/rfc822" = "thunderbird.desktop";

	  # Browser
	  "x-scheme-handler/http" = "floorp.desktop";
	  "x-scheme-handler/https" = "floorp.desktop";

	  # Misc
	  "application/x-shellscript" = "foot.desktop"; # .sh
	  "application/x-executable" = "foot.desktop"; # exe files
	  "x-scheme-handler/discord" = "vesktop.desktop"; # Discord client
	  "x-scheme-handler/steam" = "steam.desktop"; # Steam links
	  "x-scheme-handler/spotify" = "spotify.desktop"; # Spotify links
	};
      };
    };
    # Localization
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
	LC_ADDRESS = "it_IT.UTF-8";
	LC_IDENTIFICATION = "it_IT.UTF-8";
	LC_MEASUREMENT = "it_IT.UTF-8";
	LC_MONETARY = "it_IT.UTF-8";
	LC_NAME = "it_IT.UTF-8";
	LC_NUMERIC = "it_IT.UTF-8";
	LC_PAPER = "it_IT.UTF-8";
	LC_TELEPHONE = "it_IT.UTF-8";
	LC_TIME = "it_IT.UTF-8";
      };
    };
    # Zsh and omz setup
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 500;
      histFile = "$HOME/.zsh_history";
      setOptions = [
        "AUTO_CD"
      ];

      shellAliases = {
        nixcfg = "flow /etc/nixos/configuration.nix && sudo nixos-rebuild switch";
        nixflake = "flow /etc/nixos/flake.nix && sudo nixos-rebuild switch";
        nixclean = "sudo journalctl --vacuum-time=1d && sudo rm -rf /tmp/* && nh clean all && nix-store --optimise";
        nixsnap = "nh os info";
        nixsnaprm = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 1d && nixos-rebuild list-generations";
        nixup = "nh os build -u";
        nixupfl = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild boot && rb";
        nixupsys = "cd /etc/nixos && sudo nix-channel --update && sudo nixos-rebuild boot && rb";
        rebuild = "sudo nixos-rebuild switch";
        nixhash = "nix-prefetch-url";
        nixse = "nh search";
	tree = ", nix-tree";

	nsops = ", sops /etc/nixos/secrets/secrets.yaml";

        ".." = "builtin cd ..";
        ll = "lsd -l";
        ls = "lsd -al";

        ".zshrc" ="flow ~/.zshrc";
        sflow = "sudo -e flow";

        fetch = "clear && , pfetch";
        rb = "reboot";
        kvmdef = "sudo virsh net-start default";
        icalendar = "sudo cat /run/secrets/calendar-key";

        scr = "rm -rf /home/lptlv/Pictures/Screenshots/*";
        scv = "rm -rf /home/lptlv/Videos/Screencasts/*";
      };

      promptInit = ''
        . "$HOME/.cargo/env"
        test -s $HOME/.alias && . $HOME/.alias || true
        export ZSH="$HOME/.oh-my-zsh"
        #export FZF_BASE="$HOME/.oh-my-zsh/plugins/fzf"
        #export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
        export PF_INFO='ascii title os de pkgs shell font kernel palette'
        export PF_COL1='4'
        export PF_COL3='5'
        export PF_SEP=':'
      '';

      shellInit = ''
      # Loads
      autoload -Uz add-zsh-hook
      '';

      ohMyZsh = {
        enable = true;
        theme = "dst";
        custom = "$HOME/.oh-my-zsh/custom/";
        plugins = [
	  "fzf"
	  "sudo"
	  "z"
	  "nix-shell"
	  "foot"
	];
      };
    };

  # Kernel, Parameters, Bootloader, Encryption
  boot = {
    kernelPackages = pkgs.linuxPackages; # Kernel version
    kernelParams = [
      # Wifi Card
      "rtw89_8852ae.fwlps=0"
      "rtw89_8852ae.ips=0"
      "rtw89_8852ae.ant_sel=2"

      # Nvidia Card
      "nvidia-drm.modeset=1"
      "nvidia_drm.fbdev=1"
      "nvidia_uvm=1"
      "egl-wayland"

      # System
      "nosimplefb=1"
      "psi=1"
      "mem_sleep_default=deep"
      "mitigations=auto"
      "systemd.show_status=1"
    ];

    # Bootloader
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 0;
      limine = {
        enable = true;
        secureBoot.enable = true;
      };
    };

    # Encryption
    initrd = {
      availableKernelModules = ["tpm_tis" "nvidia-drm" "rtw89_8852ae"];
      systemd = {
        enable = true;
        tpm2.enable = true;
        emergencyAccess = true;
      };
      luks.devices = {
        luksroot = {
          device = "f2c56ac7-3d2c-46a0-b5a4-12a0316cf9c2";
	  allowDiscards = true;
	  crypttabExtraOpts = ["tpm2-device=auto"];
        };
      };
    };
  };

  # Security, Keyring & Secrets, Polkit
  security = {
    sudo = {
      enable = true;
      extraRules = [{
	commands = [
	  { command = "${pkgs.systemd}/bin/systemctl suspend";
            options = [ "NOPASSWD" ]; }
	  { command = "${pkgs.systemd}/bin/reboot";
            options = [ "NOPASSWD" ]; }
	  { command = "${pkgs.systemd}/bin/poweroff";
            options = [ "NOPASSWD" ]; }
	  { command = "/home/lptlv/Scripts/syscleanup";
	    options = [ "NOPASSWD" ]; }
	];
	groups = [ "Wheel" ];
      }];
    };
    polkit = {
      enable = true;
      extraConfig = ''
       polkit.addRule(function (action, subject) {
         if (
           subject.isInGroup("users") &&
              [
                "org.freedesktop.login1.reboot",
                "org.freedesktop.login1.reboot-multiple-sessions",
                "org.freedesktop.login1.power-off",
                "org.freedesktop.login1.power-off-multiple-sessions",
              ].indexOf(action.id) !== -1
            ) {
                return polkit.Result.YES;
              }
       });
      '';
    };
  };

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/lptlv/.config/sops/age/keys.txt";
    };

    secrets = {
      calendar-key = { };
      cachix-key = { };
    };
  };

  # Virtualisation and containers
  users.groups.libvirtd.members = ["lptlv"];
  virtualisation = {
    spiceUSBRedirection.enable = true;
    containers.enable = true;
    libvirtd = {
      enable = true;
      qemu.swtpm.enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # X server settings (for XWayland)
  services.xserver = {
    # Hardware
    # Keyboard
    xkb = {
      layout = "it";
      variant = "";
    };

    # Nvidia drivers
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];

    # Software
    # Display Manager
    displayManager.sessionCommands = ''
      export SSH_AUTH_SOCK
    '';
  };

  # Hardware configuration
  # Audio configuration
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Networking
  networking = {
    hostName = "nixos";
    firewall = {
      trustedInterfaces = [ "virbr0" ];
    };

    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
        scanRandMacAddress = false;
      };
    };
  };

  # Keyboard
  console.keyMap = "it";
  services.udev.extraHwdb = ''
    evdev:input:b0011v0001p0001*
      KEYBOARD_KEY_4A=reserved
  ''; # Busted '-' key on Victus laptop. Temporary fix

  services.logind.settings = {
    Login.HandlePowerKey = "ignore";
    Login.InhibitDelayMaxSec = 10;
  }; # Power key for session management

  # nvidia
  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = [ pkgs.mesa ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta; # Driver version
      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        amdgpuBusId = "PCI:6:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text = ''
    {
      "rules": [{
          "pattern": {
              "feature": "procname",
              "matches": "mango"
          },
          "profile": "Limit Free Buffer Pool On Wayland Compositors"
      }],
      "profiles": [{
          "name": "Limit Free Buffer Pool On Wayland Compositors",
          "settings": [{
              "key": "GLVidHeapReuseRatio",
              "value": 0
                }]
      }]
    } '';
}
