{ pkgs, ... }: {
  # Binds are raw Lua: hl.bind takes dispatcher *expressions* (hl.dsp.*), which
  # the settings renderer would emit as quoted strings.
  wayland.windowManager.hyprland.extraConfig = ''
    local mod = "SUPER"
    local shiftMod = "SUPER + SHIFT"

    hl.bind(mod .. " + RETURN", hl.dsp.exec_cmd("${pkgs.kitty}/bin/kitty"))
    hl.bind(mod .. " + E", hl.dsp.exec_cmd("${pkgs.thunar}/bin/thunar"))
    hl.bind(mod .. " + B", hl.dsp.exec_cmd("${pkgs.firefox}/bin/firefox"))
    hl.bind(shiftMod .. " + B", hl.dsp.exec_cmd("${pkgs.firefox}/bin/firefox --private-window"))
    hl.bind(mod .. " + L", hl.dsp.exec_cmd("${pkgs.hyprlock}/bin/hyprlock"))
    hl.bind(mod .. " + M", hl.dsp.exec_cmd("${pkgs.protonmail-desktop}/bin/proton-mail"))
    hl.bind(mod .. " + X", hl.dsp.exec_cmd("powermenu"))
    hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd("menu"))
    hl.bind(shiftMod .. " + SPACE", hl.dsp.exec_cmd("hyprfocus-toggle"))
    hl.bind(shiftMod .. " + R", hl.dsp.exec_cmd("hypranel-reload && hyprctl reload"))

    hl.bind(mod .. " + Q", hl.dsp.window.close())
    hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
    hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

    hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
    hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
    hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
    hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))
    hl.bind(shiftMod .. " + up", hl.dsp.focus({ monitor = "-1" }))
    hl.bind(shiftMod .. " + down", hl.dsp.focus({ monitor = "+1" }))
    hl.bind(shiftMod .. " + left", hl.dsp.layout("addmaster"))
    hl.bind(shiftMod .. " + right", hl.dsp.layout("removemaster"))

    hl.bind(mod .. " + PRINT", hl.dsp.exec_cmd("screenshot window"))
    hl.bind("PRINT", hl.dsp.exec_cmd("screenshot monitor"))
    hl.bind(shiftMod .. " + PRINT", hl.dsp.exec_cmd("screenshot region"))
    hl.bind("ALT + PRINT", hl.dsp.exec_cmd("screenshot region swappy"))

    hl.bind(shiftMod .. " + S", hl.dsp.exec_cmd("${pkgs.firefox}/bin/firefox -search $(wofi --show dmenu -L 1 -p ' Search on internet')"))
    hl.bind(shiftMod .. " + C", hl.dsp.exec_cmd("clipboard"))
    hl.bind(shiftMod .. " + E", hl.dsp.exec_cmd("${pkgs.wofi-emoji}/bin/wofi-emoji"))
    hl.bind(mod .. " + F3", hl.dsp.exec_cmd("night-shift"))

    -- Workspaces 1-9 on code:10 .. code:18
    for i = 0, 8 do
      local key = "code:1" .. i
      hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i + 1 }))
      hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i + 1 }))
    end

    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mod .. " + R", hl.dsp.window.resize(), { mouse = true })

    hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("schlaf"), { locked = true })

    hl.bind("XF86AudioMute", hl.dsp.exec_cmd("sound-toggle"), { locked = true, repeating = true })
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("sound-up"), { locked = true, repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("sound-down"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness-up"), { locked = true, repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness-down"), { locked = true, repeating = true })
    hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("mic-toggle"), { locked = true, repeating = true })
  '';
}
