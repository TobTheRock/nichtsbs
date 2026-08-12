{ pkgs, ... }:
let
  clipboard-clear = pkgs.writeShellScriptBin "clipboard-clear" ''
    clipman clear --all
  '';

  clipboard = pkgs.writeShellScriptBin "clipboard" ''
    clipman pick --tool=wofi
  '';

in {
  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("${clipboard-clear}/bin/clipboard-clear")
      hl.exec_cmd("wl-paste -t text --watch clipman store")
    end)
  '';
  home.packages = with pkgs; [ clipman clipboard clipboard-clear ];
  services.clipman.enable = true;
}
