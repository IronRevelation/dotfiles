{ config, pkgs, ... }:
{

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."nvim/lua".source = ./nvim/lua;

  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      # Language server packages (executables)
      nil
      sumneko-lua-language-server
      stylua
      hyprls
      rustfmt
      #vale
      clippy
      nodePackages.cspell
      clang-tools
    ];
  };
}
