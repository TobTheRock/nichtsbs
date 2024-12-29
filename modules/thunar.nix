{ pkgs, ... }: {
  programs = with pkgs.xfce; {
    thunar = {
      enable = true;
      plugins = [ thunar-archive-plugin thunar-volman ];
    };
    xfconf.enable = true;
  };
  services = {
    tumbler.enable = true;
    gvfs.enable = true;
  };
}
