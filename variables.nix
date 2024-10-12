{ config, ... }: {
  imports = [ ./modules/variables-config.nix ];

  config.var = {
    hostname = "awesom-o";
    username = "tobi";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = config.var.homeDirectory + "/.config/nixos";

    keyboardLayout = "us";

    location = "Berlin";
    timeZone = "Europe/Berlin";
    defaultLocale = "en_DK.UTF-8";
    extraLocale = "de_DE.UTF-8";

    git = {
      username = "Tobias Waurick";
      email = "tobtherock@proton.me";
    };
    
    # todo actually use belows settings

    autoUpgrade = true;
    autoGarbageCollector = true;

    theme = {
      rounding = 15;
      gaps-in = 10;
      gaps-out = 10 * 2;
      active-opacity = 1;
      inactive-opacity = 0.89;
      blur = true;
      border-size = 3;
      animation-speed = "medium"; # "fast" | "medium" | "slow"
      fetch = "nerdfetch"; # "nerdfetch" | "neofetch" | "pfetch" | "none"

      bar = {
        transparent = true;
        floating = true;
      };
    };
  };

}
