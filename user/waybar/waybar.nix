{ config, lib, ... }:
{
  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar = {
      layer = "top";
      height = 20; 
      spacing = 8;
      output = [
        "DP-3"
        "HDMI-A-4"
      ];
      
      modules-left = [
        "hyprland/workspaces"
      ];

      modules-center = [
        "clock" "custom/power_btn"
      ];

      modules-right = [
        "temperature" "cpu" "memory" "disk" "pulseaudio" "pulseaudio#microphone""tray" 
      ]; 

      "hyprland/workspaces" = {
        "disable-scroll" = true;
        "all-outputs" = false;
        "on-click" = "activate";
      };

      "clock" = {
        "format" = "{:%H:%M}";
        "tooltip" = true;
        "tooltip-format" = "{:%A, %B %e %Y}";
      };

      "tray" = {
        "icon-size" = 18;
        "spacing" = 12;
      };

      "temperature" = {
        "thermal-zone" = 1;
        "format" = " {temperatureC}°C";
        "critical-threshold" = 70;
        "format-critical" = " {temperatureC}°C";
        "on-click" = "missioncenter";
      };

      "cpu" = {
        "interval" = 10;
        "format" = " {usage}%";
        "max-length" = 10;
        "on-click" = "missioncenter";
      };

      "disk" = {
        "interval" = 30;
        "format" = "󰋊 {percentage_used}%";
        "path" = "/";
        "tooltip" = true;
	"tooltip-format" = "HDD - {used} used out of {total} on {path} ({percentage_used}%)";
        "on-click" = "missioncenter";
      };

      "memory" = {
        "interval" = 30;
        "format" = " {}%";
        "max-length" = 10;
        "tooltip" = true;
        "tooltip-format" = "Memory - {used:0.1f}GB used";
        "on-click" = "missioncenter";
      };
      
      "pulseaudio" = {
        "format" = "{icon}  {volume}%";
        "format-muted" = " ";
        "on-click" = "~/.dotfiles/user/waybar/volume --toggle";
        "on-click-right" = "pavucontrol";
        "on-scroll-up" = "~/.dotfiles/user/waybar/volume --inc";
        "on-scroll-down" = "~/.dotfiles/user/waybar/volume --dec";
        "scroll-step" = 5;
        "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
        };
      };

      "pulseaudio#microphone" = {
        "format" = "{format_source}";
        "format-source" = " {volume}%";
        "format-source-muted" = "";
        "on-click" = "~/.dotfiles/user/waybar/volume --toggle-mic";
        "on-click-right" = "pavucontrol";
        "on-scroll-up" = "~/.dotfiles/user/waybar/volume --mic-inc";
        "on-scroll-down" = "~/.dotfiles/user/waybar/volume --mic-dec";
        "scroll-step" = 5;
      };
     
      "custom/power_btn" = {
        "format" = " ";
        "on-click" = "sh -c '(sleep 0.5s; wlogout --protocol layer-shell)' & disown";
        "tooltip" = false;
      };
    };
  };
  
  programs.waybar.style = 
  ''
    * {
      border: none;
      border-radius: 0;
      font-family: "JetBrainsMono Nerd Font";
      font-weight: bold;
      font-size: 16px;
      min-height: 0;
    }

    #tray {
      padding-right: 16px;
      padding-left: 16px;
    }
  '';
  
  
}
