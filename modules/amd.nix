{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ]; 
  hardware.opengl = {
    enable = true;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}

