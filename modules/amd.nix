{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" "amdvlk" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
  };
  boot.kernelParams = [ "video=DP-1:2560x1440@144" "video=DP-2:2560x1440@144" ];
}
