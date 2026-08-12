{ pkgs, config, inputs, ... }:

let
  border-size = config.var.theme.border-size;
  gaps-in = config.var.theme.gaps-in;
  gaps-out = config.var.theme.gaps-out;
  active-opacity = config.var.theme.active-opacity;
  inactive-opacity = config.var.theme.inactive-opacity;
  rounding = config.var.theme.rounding;
  blur = config.var.theme.blur;
  keyboardLayout = config.var.keyboardLayout;
  keyboardToggle = config.var.keyboardToggle;
in {

  imports =
    [ ./animations.nix ./bindings.nix ./polkitagent.nix ./hyprspace.nix ];

  home.packages = with pkgs; [
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    hyprshot
    hyprpicker
    swappy
    imv
    wf-recorder
    wlr-randr
    wl-clipboard
    brightnessctl
    gnome-themes-extra
    libva
    dconf
    wayland-utils
    wayland-protocols
    direnv
    meson
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    xwayland.enable = true;
    systemd.enable = true;
    package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;

    settings = {
      monitor = [
        {
          output = "eDP-1";
          mode = "highres";
          position = "0x0";
          scale = 1;
        }
        {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
      ];

      # `_args` renders each entry as a two-argument hl.env(name, value) call.
      env = map (pair: { _args = pair; }) [
        [ "XDG_SESSION_TYPE" "wayland" ]
        [ "XDG_CURRENT_DESKTOP" "Hyprland" ]
        [ "XDG_SESSION_DESKTOP" "Hyprland" ]
        [ "MOZ_ENABLE_WAYLAND" "1" ]
        [ "DISABLE_QT5_COMPAT" "0" ]
        [ "NIXOS_OZONE_WL" "1" ] # wayland for chromium
        [ "ELECTRON_OZONE_PLATFORM_HINT" "auto" ]
        [ "QT_AUTO_SCREEN_SCALE_FACTOR" "1" ]
        # Qt takes a semicolon-separated fallback list. The hyprlang config had
        # "QT_QPA_PLATFORM=wayland,xcb", which hyprlang split on the first comma
        # into name="QT_QPA_PLATFORM=wayland" value="xcb" -- i.e. it never worked.
        [ "QT_QPA_PLATFORM" "wayland;xcb" ]
        [ "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1" ]
        [ "__GL_GSYNC_ALLOWED" "0" ]
        [ "__GL_VRR_ALLOWED" "0" ]
        [ "DIRENV_LOG_FORMAT" "" ]
        [ "WLR_NO_HARDWARE_CURSORS" "1" ]
        [ "SDL_VIDEODRIVER" "wayland" ]
        [ "CLUTTER_BACKEND" "wayland" ]
      ];

      # Everything that was a top-level hyprlang section now nests under
      # hl.config{}. Stylix merges its colour settings into this same attrset.
      config = {
        cursor = {
          no_hardware_cursors = true;
          default_monitor = "eDP-1";
        };

        general = {
          resize_on_border = true;
          gaps_in = gaps-in;
          gaps_out = gaps-out;
          border_size = border-size;
          layout = "master";
        };

        decoration = {
          active_opacity = active-opacity;
          inactive_opacity = inactive-opacity;
          rounding = rounding;
          shadow = {
            enabled = true;
            range = 20;
            render_power = 3;
          };
          blur = { enabled = blur; };
        };

        master = {
          new_status = "master";
          allow_small_split = true;
          mfact = 0.5;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          disable_autoreload = true;
          focus_on_activate = true;
        };

        input = {
          kb_layout = keyboardLayout;

          kb_options = "${keyboardToggle}, compose:ralt";
          follow_mouse = 1;
          sensitivity = 0.5;
          repeat_delay = 300;
          repeat_rate = 50;
          numlock_by_default = true;

          touchpad = {
            natural_scroll = true;
            clickfinger_behavior = true;
          };
        };
      };
    };

    # systemd.enable already emits a hyprland.start hook that runs
    # dbus-update-activation-environment, so only hyprpaper is left here.
    extraConfig = ''
      hl.on("hyprland.start", function()
        hl.exec_cmd("systemctl --user enable --now hyprpaper.service")
      end)
    '';
  };
  systemd.user.targets.hyprland-session.Unit.Wants =
    [ "xdg-desktop-autostart.target" ];
}
