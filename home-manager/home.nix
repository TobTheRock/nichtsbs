{ config, pkgs, ... }: 

{
  
  home = {
   username = "tobi";
   homeDirectory = "/home/tobi";
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
  

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}

