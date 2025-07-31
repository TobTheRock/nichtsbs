{ pkgs, ... }:

{
  imports = [ ./kitty ./fish ./shikane ./git ./spicetify ./ssh ./thunar ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    ausweisapp
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
    # pdf utils
    pdftk
    img2pdf
    signal-desktop
    system-config-printer
    tmux
    unzip
    zip
    # Media
    imv
    mpv
    # Office 
  ];

}
