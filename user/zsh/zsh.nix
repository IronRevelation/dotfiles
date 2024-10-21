{ config, pkgs, lib, ... }: {
  imports = [ ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    shellAliases = {
      "ls" = "eza";
      "cat" = "bat";
      "cd" = "z";
      "vim" = "nvim";
    };
    syntaxHighlighting.enable = true;
    sessionVariables = { ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk"; };
    plugins = [{
      name = "vi-mode";
      src = pkgs.zsh-vi-mode;
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
    }];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [ "$directory" "$character" ];
    };
  };
}
