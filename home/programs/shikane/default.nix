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
      # -T debounces output events (ms) so shikane evaluates the settled
      # topology instead of bailing mid-teardown on the hotplug flood.
      ExecStart = "${pkgs.shikane}/bin/shikane -T 500 -c ${shikaneConfig}";
      Restart = "always";
      RestartSec = 5;
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("systemctl --user start shikane")
    end)
  '';
}
