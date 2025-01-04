# dit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ./modules/amd.nix
    ./modules/audio.nix
    ./modules/auto-upgrade.nix
    ./modules/boot.nix
    ./modules/bluetooth.nix
    ./modules/console.nix
    ./modules/fonts.nix
    ./modules/lanzaboote.nix
    ./modules/locale.nix
    ./modules/home-manager.nix
    ./modules/networking.nix
    ./modules/nix.nix
    ./modules/utils.nix
    ./modules/steam.nix
    # ./modules/teamviewer.nix
    ./modules/thunar.nix
    ./modules/tuigreet.nix
    ./modules/xorg.nix
    ./modules/yubikey.nix

    ./themes/stylix/nichts.nix

    ./users.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;
  system.stateVersion = "24.05";
}
