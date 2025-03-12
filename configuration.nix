# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  tokyo-night-sddm = pkgs.libsForQt5.callPackage ./tokyo-night-sddm/default.nix { };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./system/hyprland/hyprland.nix
    ./system/nvidia/nvidia.nix
    ./system/sddm/sddm.nix
    ./system/stylix.nix
    ./system/flutter/flutter.nix
    ./system/keyd.nix
    #./system/kanata.nix
    #./system/keyboard/keyboard.nix
  ];

  # Bootloader.
  #  boot.loader.systemd-boot.enable = true;
  #  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
  };
  time.hardwareClockInLocalTime = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Configure keymap in X11
  #  services.xserver.xkb = {
  #layout = "custom_us";
  #options = "lv3:ralt_switch";
  #extraLayouts.custom_us = {
  #  languages = [ "eng" ];
  #  description = "US layout with custom accent letters";
  #  symbolsFile = builtins.toFile "custom_us" ''
  #    default
  #    partial alphanumeric_keys
  #    xkb_symbols "custom_us" {
  #        include "us(basic)"
  #
  #        name[Group1]= "US (Custom)";
  #
  #        key <AD11> { [ bracketleft, braceleft, egrave, eacute ] };
  #
  #        key <AC11> { [ semicolon, colon, ograve ] };
  #
  #        key <AC10> { [ apostrophe, quotedbl, agrave ] };
  #
  #        key <AE12> { [ equal, plus, igrave, asciitilde ] };
  #
  #        key <AE11> { [ minus, underscore, grave ] };
  #
  #        key <BKSL> { [ backslash, bar, ugrave ] };
  #    };
  #  '';
  #
  #};
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.tumbler.enable = true;

  # services.open-webui.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mattia = {
    isNormalUser = true;
    description = "mattia";
    extraGroups = [
      "podman"
      "networkmanager"
      "wheel"
      "kvm"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nix.extraOptions = ''
    trusted-users = root mattia
  '';

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  services.udisks2.enable = true;

  services.displayManager.sddm.enable = true;
  services.xserver.enable = true;

  services.gvfs.enable = true;

  systemd.user.services = {
    polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  programs.nix-ld.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    ntfs3g
    mako
    xdg-desktop-portal-gtk
    polkit
    qt5.qtwayland
    qt6.qtwayland
    libnotify
    glib
    git
    wl-clipboard
    cliphist
    networkmanagerapplet
    killall
    wget
    pavucontrol
    pamixer
    gvfs
    ffmpeg
    gnome-keyring
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerdfonts
  ];

  security.pam.services.hyprlock = { };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.hyprland.enableGnomeKeyring = true;

  security.polkit.enable = true;

  programs.ssh.startAgent = true;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = lib.mkDefault "kvantum";
  };

  environment.pathsToLink = [ "/share/zsh" ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

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
  #localsend ports
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
