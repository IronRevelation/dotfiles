{ lib, pkgs, ... }:

{
  programs.tmux.enable = true;

  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;

  home.packages = [
    (pkgs.writeShellScriptBin "tmux-sessionizer" (builtins.readFile ./tmux-sessionizer.sh))
    (pkgs.writeShellScriptBin "tmux-default" (builtins.readFile ./tmux-default.sh))
  ];
}
