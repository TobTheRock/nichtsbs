{ ... }: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 5;
      };
    };
    initrd = {
      systemd = {
        fido2.enable = true;
      };

      kernelModules = [ "amdgpu" ];
      luks.devices = {
        root = {
          device = "/dev/nvme0n1p2";
          preLVM = true;
          crypttabExtraOpts = [ "fido2-device=auto" "token-timeout=3" ];
        };
      };
    };
    #  1080p and 30 Hz
    kernelParams = [ "video=DP-1:1920x1080@30" "video=DP-2:1920x1080@30" ];
    #   4K and 60 Hz
    # kernelParams = [ "video=DP-1:3840x2160@60" "video=DP-2:3840x2160@60" ];
  };
}
