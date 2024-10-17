{ config, lib, ... }:
{

  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "lock";
        "action" = "hyprlock";
        "text" = "Lock";
      }

      {
        "label" = "hibernate";
        "action" = "systemctl hibernate";
        "text" = "Hibernate";
      }

      {
        "label" = "logout";
        "action" = "hyprctl dispatch exit 0";
        "text" = "Logout";
      }

      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
      }

      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
      }

      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
      }
    ];

    style = ''
      window {
	background-color: rgba(0, 0, 0, 0);
      }
      button {
        color: #FFFFFF;
        font-family: "JetBrainsMono Nerd Font";
	background-color: #1A1B26;

        border-radius: 0px;
	border-style: none;
	border-width: 0px;
	
        background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
     }

     button:focus, button:active, button:hover {
	background-color: #7AA2F7;
	outline-style: solid;
     }

     #lock, #logout, #suspend, #hibernate, #shutdown, #reboot {
       opacity: 0.9;
     }
     #lock {
      background-image: image(url("~/.dotfiles/user/wlogout/assets/lock.svg"));
     }

    #logout {
      background-image: image(url("~/.dotfiles/user/wlogout/assets/logout.svg"));
    }

    #suspend {
      background-image: image(url("~/.dotfiles/user/wlogout/assets/suspend.svg"));
    }

    #hibernate {
      background-image: image(url("~/.dotfiles/user/wlogout/assets/hibernate.svg"));
    }

    #shutdown {
      background-image: image(url("~/.dotfiles/user/wlogout/assets/shutdown.svg"));
    }

    #reboot {
     background-image: image(url("~/.dotfiles/user/wlogout/assets/reboot.svg"));
    }
         '';
  };

}
