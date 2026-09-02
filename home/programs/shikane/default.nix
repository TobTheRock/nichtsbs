{ pkgs, config, ... }:
let
  shikaneConfig =
    "${config.var.configDirectory}/home/programs/shikane/config.toml";

  # ponytail: one-shot per hotplug instead of a daemon. shikane 1.1.1's head
  # store desyncs when Hyprland recreates the output manager ("Cannot find
  # head in store"), so a long-lived daemon keeps re-applying the profile of
  # the topology it first saw. A fresh process always matches correctly.
  applyDisplays = pkgs.writeShellScript "shikane-apply-displays" ''
    apply() { ${pkgs.shikane}/bin/shikane --oneshot -c ${shikaneConfig} || true; }

    apply
    ${pkgs.socat}/bin/socat -u \
      "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - \
      | while read -r event; do
        case "$event" in
          monitoradded*|monitorremoved*)
            sleep 1 # let the hotplug flood settle
            apply
            ;;
        esac
      done
  '';
in {
  home.packages = with pkgs; [ shikane wdisplays ];

  systemd.user.services.shikane = {
    Unit = {
      Description = "shikane display helper";
      After = [ "graphical-session.target" ];
      Wants = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${applyDisplays}";
      Restart = "always";
      RestartSec = 5;
    };
  };

  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("systemctl --user restart shikane")
    end)
  '';
}
