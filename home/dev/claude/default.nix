{ pkgs, inputs, ... }: {
  programs.claude-code = {
    enable = true;

    # Declarative ~/.claude/settings.json. Plugins are still installed
    # imperatively via the marketplace (they self-update), but their
    # enablement is pinned here so the active set is reproducible.
    settings = {
      model = "opus";
      alwaysThinkingEnabled = true;
      enabledPlugins = {
        "rust-analyzer-lsp@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "superpowers@superpowers-marketplace" = true;
        "claude-mem@thedotmack" = true;
      };
    };

    # Global Claude Code instructions (~/.claude/CLAUDE.md)
    context = ''
      # Coding standards

      - Always follow clean code guidelines
      - Always follow TDD. Write a test before implementation or bug fixing to prove your point.
        - When implementing try to define the API first, preferrably by putting it to use first.
      - Always keep the scope of your work commitable, follow one logical change per commit. Do a review before commiting.
      - Always follow Clean Code, DRY, SOLID and KISS principles.
      - Always commit often and frequently, splice the changes of larger workpackages
    '';

    # wshobson/agents -> symlinked into ~/.claude/agents/
    agentsDir = pkgs.fetchFromGitHub {
      owner = "wshobson";
      repo = "agents";
      rev = "main";
      sha256 = "sha256-/yjsbqHocbS36oj3Ny1FB1l2TM7OXDHFYzmGnweFfT4=";
    };
  };

  home.packages = with pkgs; [
    # ACP bridge for agentic.nvim
    claude-agent-acp
    # Claude desktop app (k3d3/claude-desktop-linux-flake)
    inputs.claude-desktop.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
    nodejs
    # claude-mem dependencies
    bun
    uv
    sqlite
  ];
}
