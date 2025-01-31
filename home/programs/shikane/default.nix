{ pkgs, config, ... }:
let
  shikaneConfig =
    "${config.var.configDirectory}/home/programs/shikane/config.toml";
in {
  home.packages = with pkgs; [ shikane wdisplays ];

  systemd.user.services.shikane = {
    Unit = {
      Description = "shikane display helper";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.shikane}/bin/shikane -c ${shikaneConfig}";
      Restart = "always";
      RestartSec = 5;
    };
  };

  wayland.windowManager.hyprland.settings.exec-once =
    [ "systemctl --user start shikane" ];
}
