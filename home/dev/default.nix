{ pkgs, ... }: {
  imports = [ ./lazygit ./nvim ./rust ./claude ];

  home.packages = with pkgs; [ vscode python314 ];
}
