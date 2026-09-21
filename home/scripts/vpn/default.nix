# - ## VPN
#-
#- Toggle Proton VPN, connecting to the fastest server.
#-
#- - `vpn` - Connect to the fastest server, or disconnect if already connected.
#- - `vpn-status` - Connection state as JSON, for the hyprpanel bar module.
#-
#- Requires a one-time `protonvpn signin`.
{ pkgs, ... }:
let
  protonvpn = "${pkgs.proton-vpn-cli}/bin/protonvpn";
  connected = "${protonvpn} status | grep -q 'Status: Connected'";

  vpn-status = pkgs.writeShellScriptBin "vpn-status" ''
    if ${connected}; then
      echo '{"alt":"on","text":"Connected"}'
    else
      echo '{"alt":"off","text":"Disconnected"}'
    fi
  '';

  vpn = pkgs.writeShellScriptBin "vpn" ''
    if ${connected}; then
      ${protonvpn} disconnect
      notif "vpn" "󰦞  VPN Disconnected" "Proton VPN is now off."
    else
      ${protonvpn} connect
      notif "vpn" "󰦝  VPN Connected" "Proton VPN is now on (fastest server)."
    fi
  '';

in { home.packages = [ pkgs.proton-vpn-cli vpn vpn-status ]; }
