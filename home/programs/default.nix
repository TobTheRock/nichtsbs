{ pkgs, ... }: {
  imports = [ ./kitty ./fish ./shikane ./git ./spicetify ./ssh ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    brave
    calibre
    digikam
    discord
    firefox
    htop
    pavucontrol
    pmutils
    neofetch
    protonmail-desktop
    rclone
    kdePackages.okular
    onlyoffice-bin
    system-config-printer
    unzip
    zip
  ];

}
