{ pkgs, config, ... }:
let
  bild = pkgs.writeShellScriptBin "bild" ''
        # Bild -  switch monitor mode with hyprland
    #!/bin/bash

    # Get a list of connected monitors (excluding primary monitor)
    monitors=$(hyprctl monitors | grep -oP '^\S+' | grep -v 'eDP-1')

    # Primary monitor (e.g., built-in laptop screen)
    primary_monitor="eDP-1"

    # Get the current state of the monitor configuration (extend, mirror, etc.)
    current_state=$(hyprctl monitors | grep -A 5 "$primary_monitor" | grep -oP 'mode: \S+' | cut -d' ' -f2)

    # Show options in a wofi menu
    selected_option=$(echo -e "Extend\nMirror\nCycle" | wofi --show dmenu --prompt "Select display mode:" --height 300 --width 300 --color-bg "#282828" --color-fg "#ebdbb2" --color-selected "#83a598" --color-selected-bg "#3c3836")

    # Function to set displays to extend mode
    extend() {
        hyprctl monitor $primary_monitor pos 0 0
        for monitor in $monitors; do
            hyprctl monitor $monitor pos 1920 0  # Adjust positioning based on your screen layout
        done
        wofi --show dmenu --text "Displays are now in Extend Mode"
    }

    # Function to set displays to mirror mode
    mirror() {
        hyprctl monitor $primary_monitor pos 0 0
        for monitor in $monitors; do
            hyprctl monitor $monitor pos 0 0
        done
        wofi --show dmenu --text "Displays are now in Mirror Mode"
    }

    # Function to cycle through displays (turn off all except primary)
    cycle() {
        for monitor in $monitors; do
            hyprctl monitor $monitor off
        done
        hyprctl monitor $primary_monitor on
        wofi --show dmenu --text "Displays are now in Cycle Mode"
    }

    # Handle selected option
    case "$selected_option" in
        "Extend")
            extend
            ;;
        "Mirror")
            mirror
            ;;
        "Cycle")
            cycle
            ;;
        *)
            # In case of invalid option or escape
            exit 1
            ;;
    esac

  '';
in { home.packages = [ bild ]; }
