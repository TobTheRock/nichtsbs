{ config, inputs, pkgs, ... }: {
  imports = [ ./lazygit inputs.nichtsverbessert.homeModules.nvim ./claude ];

  nvim.configDirectory = config.var.configDirectory;

  home.packages = with pkgs; [ vscode python314 gh ];
}
