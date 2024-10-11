{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ nixpkgs, home-manager, lanzaboote, stylix, ... }: {
    nixosConfigurations = {
      hostname = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            nixpkgs.overlays = [inputs.hyprpanel.overlay ];
            _module.args = { inherit inputs; };
          }
          ./configuration.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          lanzaboote.nixosModules.lanzaboote
          ( { pkgs, lib, ...}: {
            environment.systemPackages = [
              pkgs.sbctl
            ];
            boot.loader.systemd-boot.enable = lib.mkForce  false;
            boot.lanzaboote =  {
              enable = true;
              pkiBundle = "/etc/secureboot/";
            };
          })
        ];
      };
    };
  };
}
