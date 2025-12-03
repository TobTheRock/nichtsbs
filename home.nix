{ config, ... }: {
  imports = [
    ./variables.nix

    ./home/dev
    ./home/programs
    ./home/scripts
    ./home/system

  ];

  stylix.enableReleaseChecks = false;

  home = {
    inherit (config.var) username;
    inherit (config.var) homeDirectory;
    #sessionVariables.NIXOS_OZONE_WL = "1";
    # used by the hyprland module (default profile pic path)
    file.".face.icon" = { source = ./profile_picture.png; };
  };

  home.stateVersion = "24.05";
}
