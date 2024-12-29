{ pkgs, ... }: {
  imports = [ ./kitty ./fish ./git ./spicetify ./ssh ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    calibre
    discord
    htop
    neofetch
    protonmail-desktop
    rclone
    unzip
    zip
    onlyoffice-bin
  ];

}
