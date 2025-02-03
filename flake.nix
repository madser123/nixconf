{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/release-24.11"; };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Cursor
    hyprcursor-phinger.url = "github:jappie3/hyprcursor-phinger";

    # Color scheme
    catppuccin.url = "github:catppuccin/nix";

    # Spotify themes
    spicetify.url = "github:the-argus/spicetify-nix";
  };

  outputs = { self, nixpkgs, catppuccin, spicetify, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      wallpapers = "${self}/media/wallpaper";
      style = import ./style.nix { };
      customUtils = import ./custom_utils.nix {
        lib = nixpkgs.lib;
        style = style;
      };

      default_modules = [
        catppuccin.nixosModules.catppuccin
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          catppuccin = {
            enable = true;
            flavor = "mocha";
          };
        }
      ];

      default_hm_modules = [
        catppuccin.homeManagerModules.catppuccin
        spicetify.homeManagerModule
        {
          catppuccin = {
            enable = true;
            flavor = "mocha";
          };
        }
      ];

      system_options =
        { # TODO: How can we make this better, so that we don't have to *merge* it into specialArgs every time we run the flake?
          work = {
            has_battery = true;
            wallpaper = "1920x1080";
            cursorSize = 18;
            backlight_device = "amdgpu_bl1";
          };
          desktop = {
            has_battery = false;
            wallpaper = "3440x1440";
            cursorSize = 24;
            backlight_device = "TODO";
          };
        };

      args = {
        inherit inputs outputs self wallpapers style customUtils spicetify;
      };
    in {
      nixosConfigurations = {
        work = nixpkgs.lib.nixosSystem {
          specialArgs = args // { sysOptions = system_options.work; };
          modules = default_modules ++ [
            ./config/work
            {
              home-manager = {
                extraSpecialArgs = args // {
                  sysOptions = system_options.work;
                };
                users.maj.imports = default_hm_modules ++ [ ./home/work.nix ];
              };
            }
          ];
        };

        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = args { sysOptions = system_options.desktop; };
          modules = default_modules ++ [
            ./config/desktop
            {
              home-manager = {
                extraSpecialArgs = args // {
                  sysOptions = system_options.desktop;
                };
                users.maj.imports = default_hm_modules
                  ++ [ ./home/desktop.nix ];
              };
            }
          ];
        };
      };
    };
}
