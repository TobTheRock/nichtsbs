{ pkgs, ... }: {
  imports = [ ./lazygit ./nvim ./claude ];

  home.packages = with pkgs; [ vscode python314 ];
}
