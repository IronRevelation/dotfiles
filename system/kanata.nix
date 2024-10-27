{ config, ... }: {
  services.kanata = {
    enable = true;
    keyboards = {
      usb = {
        devices = [ "/dev/input/by-id/usb-BY_Tech_Gaming_Keyboard-event-kbd" ];
        config = ''
          (defsrc
           caps
          )

          (defalias
           caps (tap-hold 100 100 esc lctl)
          )

          (deflayer base
           @caps
          )
        '';
      };
    };
  };
}
