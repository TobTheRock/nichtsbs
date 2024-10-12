{ ... }:
{
  programs.ssh = {
   enable = true;
   addKeysToAgent = "yes";
 #  extraConfig = ''
 #    IdentityAgent none
 #    IdentitiesOnly yes
 #  '';
  };
}
