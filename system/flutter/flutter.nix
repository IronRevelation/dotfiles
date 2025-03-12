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
    unstable.flutter
    ninja
    pkg-config
    jdk17
    android-tools
    nodejs_23
    (pkgs.androidenv.emulateApp {
      name = "sdk_gphone64_x86_64";
      platformVersion = "33";
      abiVersion = "x86_64"; # armeabi-v7a, mips, x86_64
      systemImageType = "google_apis_playstore";
    })
    (pkgs.writeShellScriptBin "flutter-watch" (builtins.readFile ./flutter-watch.sh))
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

  nixpkgs.config = {
    android_sdk.accept_license = true;
    allowUnfree = true;
  };

  system.userActivationScripts = {
    stdio = {
      text = ''
        rm -f ~/Android/Sdk/platform-tools/adb
        ln -s /run/current-system/sw/bin/adb ~/Android/Sdk/platform-tools/adb
        rm -f ~/Flutter
        ln -s  ${pkgs.unstable.flutter} ~/Flutter
      '';
      deps = [ ];
    };
  };
}
