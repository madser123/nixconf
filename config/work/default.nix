{ ... }:

{
  imports = [ ../shared ];

  hardware.bluetooth.enable = true;

  wayland.windowManager.hyprland.settings.monitor =
    [ "eDP-1, 1920x1200@60, 0x0, 2" ];
}
