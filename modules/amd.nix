{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" "amdvlk" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
