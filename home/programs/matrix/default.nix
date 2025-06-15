{ pkgs, ... }: {
  home.packages = with pkgs; [
    iamb # matrix client
    mautrix-whatsapp
  ];
  systemd.user.services.mautrix-whatsapp = {
    Unit = {
      Description = "Mautrix WhatsApp bridge";
      After = [ "network.target" ];
    };
    Service = {
      ExecStart = "/home/tobi/.local/bin/mautrix-whatsapp";
      Restart = "on-failure";
      WorkingDirectory = "/home/tobi/.config/mautrix-whatsapp";
    };
    Install = { WantedBy = [ "default.target" ]; };
  };
}
