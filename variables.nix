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

    # SOPS
    # Sops is a tool to store secrets in git repositories encrypted with GPG.
    # change the sops configuration if you want to enable that:
    sops = true;

    # Enable tailscale
    tailscale = true;

    # USBGuard
    # If usbguard enabled: set yours pref USB devices (change {id} to your trusted USB device), use `lsusb` command (from usbutils package) to get list 
    # of all connected USB devices including integrated devices like camera, bluetooth, wifi, etc. with their IDs or just disable `usbguard`
    # allow id {id} # device 1...
    usbguard = false;
    usbguardRules = "";

    theme = import ./themes/nixy.nix; # select your theme here
  };
}
