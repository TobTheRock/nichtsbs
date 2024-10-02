
{ config, lib, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tobi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; 
    packages = with pkgs; [
      firefox
      tree
      yubikey-manager
    ];
    hashedPassword = "$6$A/5vZdMwoPw1rtSY$omVBSFuRKoHbI8nDtzUl6rKU3yY4wXzKVkFnNdP46BmahP2AhQk4sGUpe3hAO2dfbK/GfcrdgtASxdPFAXO3P0";
  };
  users.users.root.hashedPassword = "!";
  users.mutableUsers = false;
}
