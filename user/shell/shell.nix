{
  config,
  pkgs,
  lib,
  ...
}:
{
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
    sessionVariables = {
      ZVM_VI_INSERT_ESCAPE_BINDKEY = "jk";
    };
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
  };

  programs.fish = {
    enable = true;
    generateCompletions = true;

    functions = {
      fish_greeting = "";
      fish_user_key_bindings = "fish_vi_key_bindings";
    };

    shellAliases = {
      "ls" = "eza";
      "cat" = "bat";
      "cd" = "z";
      "vim" = "nvim";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$character"
      ];
    };
  };
}
