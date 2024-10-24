{ config, ... }: {
  networking = {
    hostName = config.var.hostname;
    networkmanager.enable = true;
    networkmanager.wifi.powersave = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # network diagnostic tool that combines traceroute and ping.
  programs.mtr.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
