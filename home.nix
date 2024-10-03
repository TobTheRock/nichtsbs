{ config, pkgs, ... }: 

{
  imports = [
    # ./home/system/hyprland
  ];
  
  home = {
   username = "tobi";
   homeDirectory = "/home/tobi";
   # use wayland with electron apps
   sessionVariables.NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;

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

  wayland.windowManager.hyprland.enable = true;

  home.stateVersion = "24.05";
}

