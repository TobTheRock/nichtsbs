{ config, inputs, ... }: {
  imports = [ ./modules/variables-config.nix ];

  config.var = {
    hostname = "awesom-o";
    username = "tobi";
    homeDirectory = "/home/" + config.var.username;
    configDirectory = inputs.self.outPath;

    keyboardLayout = "us,de";
    keyboardToggle = "grp:alt_shift_toggle";

    location = "Dresden";
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

    theme = import ./themes/var/nichts.nix;
    wolke = {
      remoteName = "proton";
      rootDir = config.var.homeDirectory;
      syncDirs = [ "Documents" ];
      mountDirs = [ "Pictures" "Music" ];
    };
  };
}
