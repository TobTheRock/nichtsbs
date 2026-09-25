{ pkgs, inputs, ... }:
let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/o4/wallhaven-o4dgj4.jpg";
    sha256 = "01ggl0m1n6ar3l9rdc8qmgl6darmfpwhck6njqjczl3f0c3wdj66";
  };
in {
  stylix = {
    enable = true;

    # Edited catppuccin
    base16Scheme = inputs.nichtsverbessert.lib.base16;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      serif = {
        package = inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        desktop = 13;
        popups = 13;
        terminal = 13;
      };
    };

    polarity = "dark";
    image = wallpaper;

    targets.kmscon.enable = false;
  };

}
