{ pkgs, ... }: {
  imports = [ ./lazygit ./nvim ./rust ];

  home.packages = with pkgs; [ vscode python314 ];
}
