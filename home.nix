{
  config,
  pkgs,
  inputs,
  ghostty,
  ...
}:

{
  imports = [
    ./user/hyprland/hyprland.nix
    ./user/waybar/waybar.nix
    ./user/mako.nix
    ./user/gammastep.nix
    ./user/wofi/wofi.nix
    ./user/style/style.nix
    ./user/wlogout/wlogout.nix
    ./user/shell/shell.nix
    ./user/eza.nix
    ./user/fzf.nix
    ./user/neovim/neovim.nix
    ./user/zellij/zellij.nix
    ./user/tmux/tmux.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mattia";
  home.homeDirectory = "/home/mattia";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  stylix.targets.hyprpaper.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.neovim.enable = false;
  stylix.targets.zellij.enable = false;
  stylix.targets.qt.enable = false;
  # stylix.targets.hyprland.enable = false;

  programs.alacritty.enable = true;
  programs.bat.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.zoxide.enableFishIntegration = true;

  # programs.neovim.enable = true;
  #programs.kdePackages.dolphin.enable = true;
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    webcord
    hyprpaper
    hyprpicker
    hypridle
    hyprcursor
    unstable.hyprland-qtutils
    grimblast
    hyprshot
    grim
    wayshot
    slurp
    unstable.ferdium
    mission-center
    file-roller
    localsend
    qimgv
    xfce.thunar
    mpv
    onlyoffice-bin
    nextcloud-client
    obsidian
    rustc
    cargo
    jetbrains.rust-rover
    gcc
    gnumake
    statix
    nixfmt-rfc-style
    fd
    #inputs.nixvim.packages.${pkgs.system}.default
    gedit
    youtube-music
    protonvpn-gui
    deluge-gtk
    handbrake
    chromium
    shotwell
    fastfetch
    #davinci-resolve
    ripgrep
    foliate
    cloc
    yt-dlp
    #ghostty.packages.x86_64-linux.default
    kooha
    #zed-editor
    code-cursor
    python3
    distrobox
    unstable.devenv
    direnv
    (callPackage ./user/zen.nix { })
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

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  #services.ollama = {
  #  enable = true;
  #  acceleration = "cuda";
  #};

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

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mattia/etc/profile.d/hm-session-vars.sh
  #

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
  };

}
