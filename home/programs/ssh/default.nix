{ ... }:
{
  programs.ssh = {
   enable = true;
   enableDefaultConfig = false;
   matchBlocks."*".addKeysToAgent = "yes";
 #  extraConfig = ''
 #    IdentityAgent none
 #    IdentitiesOnly yes
 #  '';
  };
}
