{ ... }: {
  imports = [ ./kitty ./fish ./git ./nvim ./spicetify ./ssh ./thunar ];

  programs = {
    fzf.enable = true;
    home-manager.enable = true;
  };
}
