{ config, pkgs, ... }:
let keyboardLayout = config.var.keyboardLayout;
in {
  environment.systemPackages = with pkgs; [ fish ripgrep ];
  programs.fish.enable = true;
  # console.keyMap = keyboardLayout;
  console.keyMap = "us";
}
