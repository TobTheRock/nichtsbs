{ config, pkgs, ... }: 

{
  imports = [
    ./variables.nix
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

  programs.git = {
    enable = true;

    userName = "Tobias Waurick";
    userEmail = "tobtherock@proton.me";
    extraConfig = {
      core.editor = "vim";
      pull.rebase = true;
    };
  };
  

  
  programs.ssh = {
   enable = true;
   addKeysToAgent = "yes";
 #  extraConfig = ''
 #    IdentityAgent none
 #    IdentitiesOnly yes
 #  '';
  };
 
  programs.kitty.enable = true;

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

