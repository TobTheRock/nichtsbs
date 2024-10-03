{ pkgs, ...}:

{
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # u2f PAM (e.g. Yubikey to sudo)
  security.pam.services = {
    greetd.u2fAuth = true;
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };


  environment.systemPackages = with pkgs; [ 
    libfido2
    pam_u2f
    yubikey-manager
  ];
}
