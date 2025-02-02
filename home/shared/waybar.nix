{ osConfig, customUtils, sysOptions, ... }:

let
  waybarStyling = customUtils.import.css ./waybar.css;

  # TODO: This resolves to null??? Possibly because of osConfig.hardware?
  bluetooth = if osConfig?hardware?bluetooth?enable then "bluetooth" else "";
  battery = if sysOptions.has_battery then "battery" else "";
in {
  programs.waybar = {
    enable = true;

    style = "${waybarStyling}";

    settings = [{
      position = "top";
      layer = "top";

      mod = "dock";

      height = 27;

      margin-left = 10;
      margin-right = 10;
      margin-top = 5;
      margin-bottom = 0;
      exclusive = true;
      passthrough = false;
      gtk-layer-shell = true;
      reload_style_on_change = true;

      modules-left = [ "group/power" "tray" "hyprland/workspaces" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [ "group/hardware" "network" "clock" bluetooth battery ];

      "group/power" = {
        orientation = "horizontal";
        drawer = {
          transition-duration = 500;
          children-class = "other-btns";
          transition-left-to-right = true;
        };
        modules = [
          "custom/power"
          "custom/quit"
          "custom/lock"
          "custom/reboot"
        ];
      };

      "custom/quit" = {
          format = "󰗼";
          tooltip = true;
          on-click = "hyprctl dispatch exit";
          tooltip-format = "Logout";
      };
      "custom/lock" = {
          "format" = "󰍁";
          "tooltip" = true;
          "on-click" = "hyprlock";
          tooltip-format = "Lock";
      };
      "custom/reboot" = {
          format = "󰜉";
          tooltip = true;
          on-click = "reboot";
          tooltip-format = "Reboot";
      };
      "custom/power" = {
          format = "";
          tooltip = true;
          on-click = "shutdown now";
          tooltip-format = "Shut down";
      };

      tray = {

      };

      "hyprland/workspaces" = { 
        format = "{name}";
      };

      "hyprland/window" = {
        format = "{title}";
        icon = true;
        icon-size = 15;
      };

      "group/hardware" = {
        orientation = "horizontal";
        modules = [
          "disk"
          "memory"
          "cpu"
        ];
      };

      cpu = {
        interval = 10;

        format = "<span color='#ffffff'></span> {icon}";
        format-icons = ["" "󰪞" "󰪟" "󰪠" "󰪡" "󰪢" "󰪣" "󰪤" "󰪥"];
      };

      disk = {
        format = " {percentage_used}% used";
        tooltip-format = "{used} used out of {total} ({free} free)";

        states = {
          "critical" = 90;
          "warning" = 70;
        };
      };

      memory = {
        format = " {used:0.1f}GiB";
        tooltip-format = "RAM: {used:0.1f}GiB of {total:0.1f}GiB used.\nSWAP: {swapUsed:0.1f}GiB of {swapTotal:0.1f}GiB used.";
        tooltip = true;
        states = {
          "critical" = 80;
          "warning" = 60;
        };
      };

      network = {
        format-ethernet = "󰈁 Connected";
        format-disconnected = "󰤮 Offline";
        format-wifi = "{icon} {essid}";

        tooltip-format-ethernet = "Gw: {gwaddr} | {ipaddr} | Up: {bandwidthUpBytes} Down: {bandwidthDownBytes}";
        tooltip-format-wifi = "{signaldBm} dBm | {ipaddr} | Up: {bandwidthUpBytes} Down: {bandwidthDownBytes}";

        format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];

        #TODO: on_click = "ADD COMMAND TO OPEN NETWORK MANAGER";
      };

      clock = {
        format = "{:%H:%M %d/%m/%Y}";
        tooltip-format = "{:%A | Week: %U}";
      };

      battery = {
        interval = 20;

        format = "{icon}";
        format-good = "{icon} {capacity}%";
        format-warning = "{icon} {capacity}%";
        format-critical = "{icon} {time}";
        
        format-charging = "󱐋 {capacity}%";
        format-charging-good = "󱐋 {capacity}%";
        format-charging-warning = "󱐋 {capacity}%";
        format-charging-critical = "󱐋 {capacity}%";

        format-time = "{H}:{M}";

        states = {
          good = 99;
          warning = 40;
          critical = 20;
        };

        format-icons = [ "󰂃" "󰁽" "󰁿" "󰂁" "󱟢"];
      };

    }];
  };
}
