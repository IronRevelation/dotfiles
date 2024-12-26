{ lib, pkgs, ... }:

{
  programs.tmux.enable = true;

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;

  home.packages = with pkgs; [
    tmux-sessionizer
  ];
}
