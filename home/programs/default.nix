{ pkgs, ... }: {
  imports = [ ./kitty ./fish ./git ./spicetify ./ssh ./thunar ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    discord
    htop
    neofetch
    protonmail-desktop
    rclone
  ];

}
