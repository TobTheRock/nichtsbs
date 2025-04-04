{ config, inputs, pkgs, ... }:
let
  username = config.var.username;
  configDir = config.var.configDirectory;
in {
  systemd.services = {
    flake-update = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      unitConfig = {
        Description = "Update flake inputs";
        StartLimitIntervalSec = 300;
        StartLimitBurst = 5;
      };
      requiredBy = [ "nixos-upgrade.service" ];
      serviceConfig = {
        ExecStart =
          "${pkgs.nix}/bin/nix flake update --commit-lock-file --flake ${configDir}";
        Restart = "on-failure";
        RestartSec = "30";
        Type =
          "oneshot"; # Ensure that it finishes before starting nixos-upgrade
        User = username;
      };
      before = [ "nixos-upgrade.service" ];
      path = [ pkgs.nix pkgs.git pkgs.host ];
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "03:00";
    flake = inputs.self.outPath;
    allowReboot = false;
  };

  programs.git.config.safe.directory = [ configDir ];
  programs.git.enable = true;
}
