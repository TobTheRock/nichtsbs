{ config, ... }:
let 
  username = config.var.git.username;
  email = config.var.git.email;
in {
  programs.git = {
    enable = true;
    ignores = [
      ".claude"
      ".vscode"
      ".playground"
    ];
    settings = {
      user.name = username;
      user.email = email;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core.editor = "vim";
      pull.rebase = true;
    };
  };
}
