{ config, lib, ... }: {

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
    extraOptions = [ "-a" "--color=always" ];
  };

}
