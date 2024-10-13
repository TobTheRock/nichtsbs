{ pkgs, ... }: {
  imports = [ ./kitty ./fish ./git ./nvim ./spicetify ./ssh ./thunar ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };

  home.packages = with pkgs; [ protonmail-desktop htop neofetch ];

}
