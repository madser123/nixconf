{ customUtils, ... }:
let wofiStyling = customUtils.import.css ./wofi.css;
in {
  programs.wofi = {
    enable = true;

    settings = {
      key_expand = "End";
      hide_scroll = true;
    };

    style = "${wofiStyling}";

  };
}
