{ config, ... }:
let 
  username = config.var.git.username;
  email = config.var.git.email;
in {
  programs.git = {
    enable = true;
    userName = username;
    userEmail = email;
    ignores = [
      ".playground"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.editor = "vim";
      pull.rebase = true;
    };
  };
}
