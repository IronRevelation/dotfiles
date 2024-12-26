{ config, lib, ... }: {

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    icons = "auto";
    extraOptions = [ "-a" "--color=always" ];
  };

}
