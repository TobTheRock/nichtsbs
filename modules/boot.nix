{ ... }: {
  boot = {
    loader =  {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    initrd = {
      systemd.enable = true;
      luks.devices = {
        root = {
          device = "/dev/nvme0n1p2";
          preLVM = true;
          crypttabExtraOpts = [ "fido2-device=auto" "token-timeout=3" ];
        };
      };
    };
  };
}
