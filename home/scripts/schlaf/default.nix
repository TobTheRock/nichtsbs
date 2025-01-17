{ pkgs, ... }:
let
  schlaf = pkgs.writeShellScriptBin "schlaf" ''
    # Schlaf -  execute sleep cycle
    #!/bin/bash
    on_ac_power
    if [ $? -eq 0 ]; then
      echo  "The system is on AC power ignoring."
      exit 0 
    fi

    ${pkgs.hyprlock}/bin/hyprlock
    # TODO sway idle, use systemd suspend then hibernate
  '';
in { home.packages = [ schlaf ]; }
