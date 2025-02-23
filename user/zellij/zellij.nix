{ config, pkg, ... }:
{
  programs.zellij.enable = false;

  xdg.configFile."zellij".source = ./Zellij;
}
