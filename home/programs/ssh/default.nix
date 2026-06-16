{ ... }:
{
  programs.ssh = {
   enable = true;
   enableDefaultConfig = false;
   settings."*".addKeysToAgent = "yes";
 #  extraConfig = ''
 #    IdentityAgent none
 #    IdentitiesOnly yes
 #  '';
  };
}
