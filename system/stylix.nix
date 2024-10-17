{ config, lib, pkgs, ... }:
{
  stylix.enable = true; 
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix.image = /home/mattia/.dotfiles/wallpapers/mountains.png;
  stylix.polarity = "dark";
  stylix.fonts = {
    monospace = {
      package = pkgs.nerdfonts;
      name = "JetBrainsMono Nerd Font";
    };
  };
}
