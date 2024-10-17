{ config, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
  };
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = [
    pkgs.kitty
    pkgs.waybar
  ];

}
