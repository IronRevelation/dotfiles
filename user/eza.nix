{ config, lib, ... }:
{

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = true;
    extraOptions = [
      "-a"
      "--color=always"
    ];
  };

}
