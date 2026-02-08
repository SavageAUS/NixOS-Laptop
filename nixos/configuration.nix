{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.graphics = {
      enable = true;
      enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
  };

  hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
          offload = {
              enable = true;
              enableOffloadCmd = true;
          };
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
      };
  };


  systemd.user.services.hyprpolkitagent = {
      description = "hyprpolkitagent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
      };
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Adelaide";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

    programs = {
        hyprland = {
	        enable = true;
	        xwayland.enable = true;
	        };
        dms-shell = {
            enable = true;
            systemd = {
                enable = true;
                restartIfChanged = true;
            };
            enableSystemMonitoring = true;     # System monitoring widgets (dgop)
            enableVPN = false;                  # VPN management widget
            enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
            enableAudioWavelength = true;      # Audio visualizer (cava)
            enableCalendarEvents = true;       # Calendar integration (khal)
        };
        firefox = {
            enable = true;
        };
        localsend = {
            enable = true;
            openFirewall = true;
        };
        fish = {
            enable = true;
        };
    };
    documentation.man.generateCaches = false;

    virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "en-us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shane = {
      isNormalUser = true;
      description = "Shane Scott";
      shell = pkgs.fish;
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "docker" ];
      packages = with pkgs; [
      
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;

  xdg.menus.enable = true;
  xdg.mime.enable = true;
  

  services.flatpak = {
      enable = true;
  };
  xdg.portal = {
      enable = true;
  };
  services.udisks2 = {
      enable = true;
  };
  services.gvfs = {
      enable = true;
  };
  services.displayManager.ly = {
      enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    bibata-cursors
    blueman
    brightnessctl
    btop
    cava
    cmatrix
    davinci-resolve
    dnsmasq
    fastfetch
    ffmpeg
    flatpak
    gcc
    gimp
    git
    jellyfin-media-player
    jellyfin-tui
    jq
    libvirt
    localsend
    lshw
    mesa-demos
    mesa.opencl
    neovim
    networkmanager
    networkmanagerapplet
    obs-studio
    papirus-icon-theme
    pciutils
    playerctl
    putty
    qemu
    quickshell
    tree-sitter
    udiskie
    vesktop
    vim
    vlc
    wget
    xdg-user-dirs

    #Hyprland
    cliphist
    grim
    hyprcursor
    hypridle
    hyprlock
    hyprpolkitagent
    hyprviz
    rofi
    slurp
    swaynotificationcenter
    swayosd
    swww
    waybar
    waypaper
    wl-clip-persist
    wl-clipboard
    wlogout
    xdg-desktop-portal-hyprland

    #Gnome Packages
    file-roller
    gnome-boxes
    gnome-photos
    gnome-text-editor
    gparted
    nautilus
    
    #Kde Applications
    #kdePackages.ark
    #kdePackages.breeze
    #kdePackages.dolphin
    #kdePackages.dolphin-plugins
    #kdePackages.ffmpegthumbs
    #kdePackages.kate
    #kdePackages.kdegraphics-thumbnailers
    #kdePackages.kio
    #kdePackages.kio-admin
    #kdePackages.kio-extras
    #kdePackages.kio-fuse
    #kdePackages.plasma-integration
    #kdePackages.kservice
    #kdePackages.plasma-workspace
    #kdePackages.qt6ct
    #kdePackages.qtsvg
    #qt6.qt5compat
    #qt6.qtbase
    #qt6.qtdeclarative
    #qt6.qtmultimedia
    #qt6.qtwayland
    #shared-mime-info


    #Unfree Software
    discord
    microsoft-edge
    ];

    fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    font-awesome
    ];

    # This fixes the unpopulated MIME menus
    environment.etc."/xdg/menus/plasma-applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11"; # Did you read the comment?

}
