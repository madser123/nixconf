{ style, ... }: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      font-family = style.terminal-font;
      font-size = 10;

      background = "#${style.darker}";
      foreground = "#${style.foreground}";

      cursor-color = "#${style.cursorColor}";
      cursor-style = "bar";
      cursor-style-blink = true;
      cursor-click-to-move = true;

      mouse-hide-while-typing = true;
      mouse-shift-capture = true;

      background-opacity = 0.8;
      #TODO: background-blur-radius = ?;

      command = "fish";
      #initial-command = "fish -l -i -c neofetch";

      class = "Ghostty";

      working-directory = "home";

      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      window-padding-color = "extend";
      window-decoration = false;

      resize-overlay = "never";

      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-trim-trailing-spaces = true;
      clipboard-paste-protection = true;

      confirm-close-surface = false;

      initial-window = true;
    };

    themes = {

    };
  };
}
