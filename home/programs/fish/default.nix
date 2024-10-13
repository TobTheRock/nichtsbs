{ pkgs, ... }: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        {
          name = "fzf-fish";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "plugin-git";
          inherit (pkgs.fishPlugins.plugin-git) src;
        }
        {
          name = "grc";
          inherit (pkgs.fishPlugins.grc) src;
        }
        {
          name = "z";
          inherit (pkgs.fishPlugins.z) src;
        }
      ];
    };
  };
}
