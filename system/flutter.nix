{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    android-studio
    clang
    cmake
    flutter
    ninja
    pkg-config
    jdk17
    android-tools
  ];

  programs = {
    adb.enable = true;
  };

  users.users.mattia = {
    extraGroups = [ "adbusers" ];
  };

  #android = {
  #  android-studio.enable = true;
  #  emulator.enable = true;
  #  ndk.enable = true;
  #  buildTools.version = [ "34.0.0" ];
  #};

  #environment.sessionVariables = { JAVA_HOME = "${pkgs.android-studio}/jbr"; };

  system.userActivationScripts = {
    stdio = {
      text = ''
        rm -f ~/Android/Sdk/platform-tools/adb
        ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
        rm -f ~/Flutter
        ln -s  ${pkgs.flutter} ~/Flutter
      '';
      deps = [ ];
    };
  };
}
