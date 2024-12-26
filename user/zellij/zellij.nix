{ config, pkg, ... }:
{
  programs.zellij.enable = true;

  xdg.configFile."zellij".source = ./Zellij;
}
