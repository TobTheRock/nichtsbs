{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod,RETURN, exec, ${pkgs.kitty}/bin/kitty" # Kitty
      "$mod,E, exec, ${pkgs.xfce.thunar}/bin/thunar" # Thunar
      "$mod,B, exec, ${pkgs.firefox}/bin/firefox" # Firefox
      #    "$mod,K, exec, ${pkgs.bitwarden}/bin/bitwarden" # Bitwarden
      "$mod,L, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock
      "$shiftMod,PRINT, exec, screenshot region" # Screenshot region
      "ALT,PRINT, exec, screenshot region swappy" # Screenshot region then edit

      "$shiftMod,S, exec, ${pkgs.firefox}/bin/firefox -search $(wofi --show dmenu -L 1 -p ' Search on internet')" # Search on internet with wofi
      "$shiftMod,C, exec, clipboard" # Clipboard picker with wofi
      "$shiftMod,E, exec, ${pkgs.wofi-emoji}/bin/wofi-emoji" # Emoji picker with wofi
      # "$mod,F2, exec, night-shift" # Toggle night shift
      "$mod,F3, exec, night-shift" # Toggle night shift
    ] ++ (builtins.concatLists (builtins.genList (i:
      let ws = i + 1;
      in [
        "$mod,code:1${toString i}, workspace, ${toString ws}"
        "$mod SHIFT,code:1${toString i}, movetoworkspace, ${toString ws}"
      ]) 9));

    bindm = [
      "$mod,mouse:272, movewindow" # Move Window (mouse)
      "$mod,R, resizewindow" # Resize Window (mouse)
    ];

    bindl = [
      # ",switch:Lid Switch, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock when closing Lid
    ];

    bindle = [
      ",XF86AudioMute, exec, sound-toggle" # Toggle Mute
      ",XF86AudioRaiseVolume, exec, sound-up" # Sound Up
      ",XF86AudioLowerVolume, exec, sound-down" # Sound Down
      ",XF86MonBrightnessUp, exec, brightness-up" # Brightness Up
      ",XF86MonBrightnessDown, exec, brightness-down" # Brightness Down
      ",XF86AudioMicMute, exec, mic-toggle"
    ];

  };
}
