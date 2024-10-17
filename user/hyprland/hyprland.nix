{ config, lib, pkgs, ... }:
{
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
  
  programs.hyprlock.enable = true;
  
  services.hyprpaper = {
    enable = true;
    settings.wallpaper = [
      "DP-3,~/.dotfiles/wallpapers/mountains.png"
      "HDMI-A-4,~/.dotfiles/wallpapers/mountains.png"
    ];
    settings.preload = [
      "~/.dotfiles/wallpapers/mountains.png"
    ];
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";       # avoid starting multiple hyprlock instances.
        ignore_dbus_inhibit = false;
        after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
      };
    
      listener = [
        {
          timeout = 300;                                 # 5min
          on-timeout = "pidof hyprlock || hyprlock";            # lock screen when timeout has passed
        }
        {
          timeout = 330;                                 # 5.5min
          on-timeout = "hyprctl dispatch dpms off";        # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on";          # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 600;                               # 12 min
          on-timeout = "systemctl suspend";                # suspend pc
        }
      ];
    };
  };
}
