{ config, lib, pkgs, colors, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      env = { "TERM" = "xterm-256color"; };

      window = {
        padding = {
          x = 10;
          y = 10;
        };

        opacity = 0.9;

        decorations = "buttonless";
      };

      font = {
        size = 12.0;

        normal.family = "SauceCodePro Nerd Font";
        bold.family = "SauceCodePro Nerd Font";
        italic.family = "SauceCodePro Nerd Font";
      };

      bell = {
        animation = "Ease";
        duration = 10;
        color = "#${colors.color1}";
      };

      cursor = {
        style = "Beam";
        blinking = "On";

      };
      mouse.hide_when_typing = true;

      terminal.shell = "fish";

      colors = {
        primary = {
          background = "#${colors.background}";
          foreground = "#${colors.foreground}";
        };
      };
    };
  };
}
