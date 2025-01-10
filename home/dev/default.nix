{ pkgs, ... }: {
  imports = [ ./rust ./nvim ];

  home.packages = with pkgs; [
    vscode
    python314
  ];
}
