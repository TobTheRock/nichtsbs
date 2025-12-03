{ pkgs, ... }:
let
  # Browsers and Internet tools
  browserPkgs = with pkgs; [ brave firefox rclone ];
  # Messaging & Communication
  messagingPkgs = with pkgs; [ signal-desktop discord protonmail-desktop ];
  # Office & PDF Tools
  officePkgs = with pkgs; [
    ausweisapp
    calibre
    kdePackages.okular
    img2pdf
    pdftk
    onlyoffice-desktopeditors
    system-config-printer
  ];
  # Media tools and image management
  mediaPkgs = with pkgs; [ mpv imv digikam pavucontrol tidal-hifi ];
  # System utilities and CLI tools
  cliPkgs = with pkgs; [ htop neofetch tmux unzip zip pmutils ];
  # Misc apps
  miscPkgs = with pkgs; [ ];

  # Combine everything
  allPackages = browserPkgs ++ messagingPkgs ++ officePkgs ++ mediaPkgs
    ++ cliPkgs ++ miscPkgs;

in {
  imports = [ ./kitty ./fish ./shikane ./git ./ssh ./thunar ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = allPackages;
}
