{ pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # Hyprland service needed directly in the config 
  # for the home-manager module to work
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  qt.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Essentials
    vim
    wget
    git
    curl
    nixd
    openssl
    home-manager
    wev # Keyboard debugging

    # Display management
    brightnessctl

    # Theming
    magnetic-catppuccin-gtk
    papirus-icon-theme

    # Other
    neofetch
    phinger-cursors
  ];

  services = {
    # OpenSSH
    openssh.enable = true;
  };
}
