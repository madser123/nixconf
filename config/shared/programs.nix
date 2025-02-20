{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

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
    wev # Keyboard debugging

    # C
    gcc

    # Lua
    dap

    # Rust
    rustup
    cargo
    cargo-cache
    cargo-nextest # For rustaceanvim
    bacon

    # Display management
    brightnessctl

    # Theming
    magnetic-catppuccin-gtk
    catppuccin-papirus-folders
    phinger-cursors

    # Other
    neofetch
    gnome.gvfs # fix for swaync mpris widget
  ];

  services = {
    # OpenSSH
    openssh.enable = true;
  };
}
