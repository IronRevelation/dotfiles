{ config, lib, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      width=600;
      height=300;
      location="center";
      show="drun";
      prompt="Search...";
      filter_rate=100;
      allow_markup=true;
      no_actions=true;
      halign="fill";
      orientation="vertical";
      content_halign="fill";
      insensitive=true;
      allow_images=true;
      image_size=40;
      gtk_dark=true;
      dynamic_lines=true; 
      term="alacritty";
    };
  };
  
  xdg.configFile."wofi/style.css".source = ./style/v1-style-dark.css;
}
