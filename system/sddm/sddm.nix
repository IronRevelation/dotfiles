{ config, lib, pkgs, qtbase, qtsvg, qtgraphicaleffects, qtquickcontrols2, wrapQtAppsHook, stdenvNoCC, fetchFromGitHub, ... }: 

let 
  theme = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "tokyo-night-sddm";
    version = "1.0";
    dontBuild = true;
    
    src = pkgs.fetchFromGitHub {
      owner = "rototrash";
      repo = "tokyo-night-sddm";
      rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
      sha256 = "sha256-JRVVzyefqR2L3UrEK2iWyhUKfPMUNUnfRZmwdz05wL0=";
    };

    nativeBuildInputs = [ pkgs.libsForQt5.wrapQtAppsHook ];
    
    propagatedUserEnvPkgs = with pkgs.libsForQt5; [
      pkgs.qt5.qtbase
      pkgs.qt5.qtsvg
      pkgs.qt5.qtgraphicaleffects
      pkgs.qt5.qtquickcontrols2
    ];

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/tokyo-night-sddm
    '';
  };
in {
  environment.systemPackages = [ theme ];
  services.displayManager.sddm.theme = "tokyo-night-sddm";
}

