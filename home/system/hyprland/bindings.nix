{ pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod,RETURN, exec, ${pkgs.kitty}/bin/kitty" # Kitty
      "$mod,E, exec, ${pkgs.xfce.thunar}/bin/thunar" # Thunar
      "$mod,B, exec, ${pkgs.firefox}/bin/firefox" # Firefox
      "$shiftMod,B, exec, ${pkgs.firefox}/bin/firefox --private-window" # Firefox
      #    "$mod,K, exec, ${pkgs.bitwarden}/bin/bitwarden" # Bitwarden
      "$mod,L, exec, ${pkgs.hyprlock}/bin/hyprlock" # Lock
      "$mod,M, exec, ${pkgs.protonmail-desktop}/bin/proton-mail" # Mail
      "$mod,X, exec, powermenu" # Powermenu
      "$mod,SPACE, exec, menu" # Launcher
      "$shiftMod,SPACE, exec, hyprfocus-toggle" # Toggle HyprFocus
      "$shiftMod,R, exec, hypranel-reload && hyprctl reload" # reload

      "$mod,Q, killactive," # Close window
      "$mod,T, togglefloating," # Toggle Floating
      "$mod,F, fullscreen" # Toggle Fullscreen
      "$mod,left, movefocus, l" # Move focus left
      "$mod,right, movefocus, r" # Move focus Right
      "$mod,up, movefocus, u" # Move focus Up
      "$mod,down, movefocus, d" # Move focus Down
      "$shiftMod,up, focusmonitor, -1" # Focus previous monitor
      "$shiftMod,down, focusmonitor, 1" # Focus next monitor
      "$shiftMod,left, layoutmsg, addmaster" # Add to master
      "$shiftMod,right, layoutmsg, removemaster" # Remove from master

      "$mod,PRINT, exec, screenshot window" # Screenshot window
      ",PRINT, exec, screenshot monitor" # Screenshot monitor
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
      ",switch:Lid Switch, exec, schlaf" # Lock when closing Lid
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
