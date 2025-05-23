{ config, lib, pkgs, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.tobi = {
      isNormalUser = true;
      shell = pkgs.fish;
      extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
      packages = with pkgs; [ grc fish tree ];
      hashedPassword =
        "$6$A/5vZdMwoPw1rtSY$omVBSFuRKoHbI8nDtzUl6rKU3yY4wXzKVkFnNdP46BmahP2AhQk4sGUpe3hAO2dfbK/GfcrdgtASxdPFAXO3P0";
    };
    users.root.hashedPassword = "!";
    mutableUsers = false;
  };
}
