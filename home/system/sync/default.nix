{ pkgs, config, ... }: {
  systemd.user.services.wolke-sync = {
    Unit = {
      Description = "Synchronize files with the wolke script";
      Wants = [ "network-online.target" ];
      After = [ "network-online.target" ];
    };
    Service = { ExecStart = "/etc/profiles/per-user/tobi/bin/wolke sync"; };
  };
  systemd.user.timers.wolke-sync = {
    Install.WantedBy = [ "timers.target" ];
    Timer = {
      OnCalendar = "hourly";
      Persistent = true;
      Unit = "wolke-sync.service";
    };
  };
  home.packages = with pkgs; [ rclone ];
}
