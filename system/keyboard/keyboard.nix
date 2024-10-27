{ config, ... }: {
  services.xserver.xkb.extraLayouts.custom_accents = {
    description = "Custom accents";
    languages = [ "eng" ];
    symbolsFile = ./custom-accents;
  };

  services.xserver.xkb = {
    layout = "custom_accents,it";
    options = "terminate:ctrl_alt_bksp";
  };

}
