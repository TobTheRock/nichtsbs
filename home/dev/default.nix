{ config, inputs, pkgs, ... }: {
  imports = [ ./lazygit inputs.nvim.homeModules.nvim ./claude ];

  nvim.configDirectory = config.var.configDirectory;

  home.packages = with pkgs; [ vscode python314 gh ];
}
