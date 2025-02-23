{
  config,
  lib,
  pkgs,
  ...
}:
{

  gtk = {
    enable = true;
    theme = {
      package = lib.mkDefault pkgs.tokyonight-gtk-theme;
      name = lib.mkDefault "tokyonight";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
  xdg.configFile."Kvantum/Sweet-Ambar-Blue".source = ./Sweet-Ambar-Blue;
  xdg.configFile."qt5ct/qt5ct.conf".source = ./qt6ct.conf;
  xdg.configFile."qt6ct/qt6ct.conf".source = ./qt6ct.conf;

  xdg.dataFile."icons/Bibata-Modern-Ice".source = ./Bibata-Modern-Ice;
}
