{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  #xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;

  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # BACKGROUND
      background {
          monitor =
          path = ~/.dotfiles/wallpapers/mountains.png
          blur_passes = 2
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
      }

      # GENERAL
      general {
          no_fade_in = false
          no_fade_out = false
          grace = 0
          disable_loading_bar = false
      }


      # Day
      label {
          monitor =
          text = cmd[update:1000] echo -e "$(date +"%A")"
          color = rgba(216, 222, 233, 0.70)
          font_size = 90
          font_family = SF Pro Display Bold
          position = 0, 350
          halign = center
          valign = center
      }

      # Date-Month
      label {
          monitor =
          text = cmd[update:1000] echo -e "$(date +"%d %B")"
          color = rgba(216, 222, 233, 0.70)
          font_size = 40
          font_family = SF Pro Display Bold
          position = 0, 250
          halign = center
          valign = center
      }

      # Time
      label {
          monitor =
          text = cmd[update:1000] echo "<span>$(date +"- %I:%M -")</span>"
          color = rgba(216, 222, 233, 0.70)
          font_size = 20
          font_family = SF Pro Display Bold
          position = 0, 190
          halign = center
          valign = center
      }

      # USER-BOX
      shape {
          monitor =
          size = 300, 60
          color = rgba(255, 255, 255, .1)
          rounding = -1
          border_size = 0
          border_color = rgba(255, 255, 255, 0)
          rotate = 0
          xray = false # if true, make a "hole" in the background (rectangle of specified size, no rotation)

          position = 0, -130
          halign = center
          valign = center
      }

      # USER
      label {
          monitor =
          text =     $USER
          color = rgba(216, 222, 233, 0.80)
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          font_size = 18
          font_family = SF Pro Display Bold
          position = 0, -130
          halign = center
          valign = center
      }

      # INPUT FIELD
      input-field {
          monitor =
          size = 300, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(255, 255, 255, 0)
          inner_color = rgba(255, 255, 255, 0.1)
          font_color = rgb(200, 200, 200)
          fade_on_empty = false
          font_family = SF Pro Display Bold
          placeholder_text = <i><span foreground="##ffffff99">🔒 Enter Pass</span></i>
          hide_input = false
          position = 0, -210
          halign = center
          valign = center
      }

      # Power
      label {
          monitor =
          text = 󰐥  󰜉  󰤄
          color = rgba(255, 255, 255, 0.6)
          font_size = 50
          position = 0, 100
          halign = center
          valign = bottom
      }
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings.wallpaper = [
      "DP-3, ~/.dotfiles/wallpapers/ultrawide.png"
      "HDMI-A-4, ~/.dotfiles/wallpapers/mountains.png"
    ];
    settings.preload = [
      "~/.dotfiles/wallpapers/mountains.png"
      "~/.dotfiles/wallpapers/ultrawide.png"
    ];
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        ignore_dbus_inhibit = false;
        after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
      };

      listener = [
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = 600; # 12 min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };
}
