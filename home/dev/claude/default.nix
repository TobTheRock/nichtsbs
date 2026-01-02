{ pkgs, ... }: {
  home.packages = with pkgs; [
    claude-code
    # claude-mem dependencies
    bun
    uv
    sqlite
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

  # Global Claude Code instructions
  home.file.".claude/CLAUDE.md".text = ''
    # Coding standards

    - Always follow clean code guidelines
    - Always follow TDD. Write a test before implementation or bug fixing to prove your point.
      - When implementing try to define the API first, preferrably by putting it to use first.
  '';
}
