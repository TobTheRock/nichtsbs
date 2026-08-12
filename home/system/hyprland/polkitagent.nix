{ inputs, pkgs, ... }: {
  home.packages =
    [ inputs.hyprpolkitagent.packages."${pkgs.stdenv.hostPlatform.system}".hyprpolkitagent ];

  wayland.windowManager.hyprland.extraConfig = ''
    hl.on("hyprland.start", function()
      hl.exec_cmd("systemctl --user start hyprpolkitagent")
    end)
  '';
}
