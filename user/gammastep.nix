{ config, lib, ... }:
{
  services.gammastep = {
    enable = true;
    latitude = 46.0;
    longitude = 11.1;
  };

}
