# Standalone home-manager profile for macOS: just the Neovim config.
# Apply with: nix run home-manager -- switch --flake .#tobi@mac
{ config, pkgs, ... }: {
  imports = [ ../modules/variables-config.nix ./dev/nvim ];

  home = {
    username = "tobi";
    homeDirectory = "/Users/tobi";
    stateVersion = "24.05";
  };

  # the nvim dashboard links to the config repo
  var.configDirectory = config.home.homeDirectory + "/Development/nix/nichtsbs";

  # nvim reads its colors from config.lib.stylix.colors, so stylix has to be
  # present here too — but only the palette and font, no desktop targets.
  stylix = {
    enable = true;
    enableReleaseChecks = false;
    polarity = "dark";
    base16Scheme = import ../themes/stylix/base16.nix;
    fonts.monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrains Mono Nerd Font";
    };
  };
}
