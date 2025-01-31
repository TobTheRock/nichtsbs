{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" "amdvlk" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ amdvlk ];
  };
  #  1080p and 30 Hz
  boot.kernelParams = [ "video=DP-1:1920x1080@30" "video=DP-2:1920x1080@30" ];
  # boot.kernelParams = [ "video=DP-1:3840x2160@60" "video=DP-2:3840x2160@60" ];
}
