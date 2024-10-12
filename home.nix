{ config, pkgs, ... }: 
{
  imports = [
    ./variables.nix

    ./home/programs/kitty
    ./home/programs/git
    ./home/programs/nvim
    ./home/programs/spicetify
    ./home/programs/ssh
    ./home/programs/thunar

    ./home/scripts

    ./home/system/hypridle
    ./home/system/hyprland
    ./home/system/hyprlock
    ./home/system/hyprpanel
    ./home/system/hyprpaper
    ./home/system/hyprswitch
  ];
  
  home = {
   inherit (config.var) username;
   inherit (config.var) homeDirectory;
   #sessionVariables.NIXOS_OZONE_WL = "1";
   file."profile_picture.png" = { source = ./profile_picture.png; };
  };
 
  programs.kitty.enable = true;
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

