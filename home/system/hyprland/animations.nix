{ config, ... }:
let
  animationSpeed = config.var.theme.animation-speed;

  animationDuration = if animationSpeed == "slow" then
    4.0
  else if animationSpeed == "medium" then
    2.5
  else
    1.5;
  borderDuration = if animationSpeed == "slow" then
    10.0
  else if animationSpeed == "medium" then
    6.0
  else
    3.0;

  # hl.curve(name, { type = "bezier", points = { {x1, y1}, {x2, y2} } })
  curve = name: x1: y1: x2: y2: {
    _args = [
      name
      {
        type = "bezier";
        points = [ [ x1 y1 ] [ x2 y2 ] ];
      }
    ];
  };

  # hl.animation({ leaf = ..., enabled = true, speed = ..., bezier = ..., style = ... })
  animation = leaf: speed: bezier: style:
    {
      inherit leaf speed bezier;
      enabled = true;
    } // (if style == null then { } else { inherit style; });
in {
  wayland.windowManager.hyprland.settings = {
    config.animations.enabled = true;

    curve = [
      (curve "linear" 0.0 0.0 1.0 1.0)
      (curve "md3_standard" 0.2 0.0 0.0 1.0)
      (curve "md3_decel" 0.05 0.7 0.1 1.0)
      (curve "md3_accel" 0.3 0.0 0.8 0.15)
      (curve "overshot" 0.05 0.9 0.1 1.1)
      (curve "crazyshot" 0.1 1.5 0.76 0.92)
      (curve "hyprnostretch" 0.05 0.9 0.1 1.0)
      (curve "menu_decel" 0.1 1.0 0.0 1.0)
      (curve "menu_accel" 0.38 0.04 1.0 0.07)
      (curve "easeInOutCirc" 0.85 0.0 0.15 1.0)
      (curve "easeOutCirc" 0.0 0.55 0.45 1.0)
      (curve "easeOutExpo" 0.16 1.0 0.3 1.0)
      (curve "softAcDecel" 0.26 0.26 0.15 1.0)
      (curve "md2" 0.4 0.0 0.2 1.0)
    ];

    animation = [
      (animation "windows" animationDuration "md3_decel" "popin 60%")
      (animation "windowsIn" animationDuration "md3_decel" "popin 60%")
      (animation "windowsOut" animationDuration "md3_accel" "popin 60%")
      (animation "border" borderDuration "default" null)
      (animation "fade" animationDuration "md3_decel" null)
      (animation "layersIn" animationDuration "menu_decel" "slide")
      (animation "layersOut" animationDuration "menu_accel" null)
      (animation "fadeLayersIn" animationDuration "menu_decel" null)
      (animation "fadeLayersOut" animationDuration "menu_accel" null)
      (animation "workspaces" animationDuration "menu_decel" "slide")
      (animation "specialWorkspace" animationDuration "md3_decel" "slidevert")
    ];
  };
}
