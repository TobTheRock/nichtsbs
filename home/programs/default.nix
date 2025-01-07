{ pkgs, ... }: {
  imports = [ ./kitty ./fish ./shikane ./git ./spicetify ./ssh ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    calibre
    discord
    htop
    pavucontrol
    pmutils
    neofetch
    protonmail-desktop
    rclone
    onlyoffice-bin
    unzip
    zip
  ];

}
