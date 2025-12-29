{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
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
        firefox = {
            enable = true;
        };
        localsend = {
            enable = true;
            openFirewall = true;
        };
        zsh = {
            enable = true;
            ohMyZsh = {
                enable = true;
                theme = "agnoster";
                plugins = [ "git" "sudo" ];
            };
        };
        virt-manager = {
            enable = true;
        };
        thunar = {
            enable = true;
        };
    };

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
      extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" "docker" ];
      packages = with pkgs; [
      
    ];
  };
  users.users.shane.shell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;
  

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
    vim
    neovim
    wget
    git
    udiskie
    brightnessctl
    playerctl
    pciutils
    lshw
    jq
    bibata-cursors
    adwaita-icon-theme
    papirus-icon-theme
    gparted
    oh-my-zsh
    gimp
    networkmanager
    networkmanagerapplet
    blueman
    cmatrix
    btop
    xdg-user-dirs
    gcc
    tree-sitter
    cava
    vlc
    quickshell
    mesa-demos
    flatpak
    virt-manager
    libvirt
    qemu
    dnsmasq
    obs-studio
    jellyfin-tui
    jellyfin-media-player
    vscode-fhs
    localsend


    #Hyprland
    waybar
    wofi
    waypaper
    swww
    xdg-desktop-portal-hyprland
    hypridle
    hyprlock
    hyprcursor
    hyprpolkitagent
    grim
    slurp
    hyprviz
    cliphist
    wl-clipboard
    wl-clip-persist
    swaynotificationcenter
    swayosd
    wlogout
    

    #Niri
    fuzzel

    #XFCE
    xfce.thunar

    #Kde Applications
    kdePackages.dolphin
    kdePackages.qt6ct
    kdePackages.kate
    kdePackages.qtsvg
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kservice
    kdePackages.breeze
    kdePackages.ark
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qt5compat
    qt6.qtmultimedia


    #Unfree Software
    discord
    microsoft-edge
    ];

    fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    font-awesome
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
