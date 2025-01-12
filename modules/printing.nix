{ pkgs, ... }: {

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.pantum-driver ];
  };

}
