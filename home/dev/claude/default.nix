{ pkgs, ... }: {
  home.packages = with pkgs; [
    claude-code
  ];

  home.file.".claude/agents" = {
    source = pkgs.fetchFromGitHub {
      owner = "wshobson";
      repo = "agents";
      rev = "main";
      sha256 = "sha256-/yjsbqHocbS36oj3Ny1FB1l2TM7OXDHFYzmGnweFfT4=";
    };
    recursive = true;
  };
}