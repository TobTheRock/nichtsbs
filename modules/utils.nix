{ pkgs, config, ... }:
let keyboardLayout = config.var.keyboardLayout;
in {
  services = {
    xserver = {
      enable = true;
      xkb.layout = keyboardLayout;
      xkb.variant = "";
    };
    gnome.gnome-keyring.enable = true;
  };

  environment.variables = {
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    EDITOR = "nvim";
  };

  programs.dconf.enable = true;
  services = {
    libinput.enable = true;
    dbus.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    udisks2.enable = true;
  };

  # Faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  # mouse support for console
  #  services.gpm.enable = true;

  environment.systemPackages = with pkgs; [
    systemd
    vim
    tmux
    wget
    fd
    bc
    gcc
    git-ignore
    xdg-utils
    wget
    curl
    libwebp
    fwupd
  ];
}
