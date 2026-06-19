{ pkgs, inputs, ... }: {
  programs.claude-code = {
    enable = true;

    # Declarative ~/.claude/settings.json.
    #
    # Two flavours of plugin live here:
    #   * Imperative install + pinned enablement — the marketplace was added
    #     interactively (`/plugin marketplace add ...`) and the plugins
    #     self-update; only their enablement is pinned below so the active set
    #     stays reproducible. These are the *-official / superpowers / thedotmack
    #     entries.
    #   * Fully declarative — the marketplace is fetched and registered via the
    #     `marketplaces` option below, so both the source and the enablement are
    #     pinned in nix. ponytail (ponytail@ponytail) is wired this way.
    settings = {
      model = "opus";
      alwaysThinkingEnabled = true;
      enabledPlugins = {
        "rust-analyzer-lsp@claude-plugins-official" = true;
        "gopls-lsp@claude-plugins-official" = true;
        "typescript-lsp@claude-plugins-official" = true;
        "superpowers@superpowers-marketplace" = true;
        "claude-mem@thedotmack" = true;
        # DietrichGebert/ponytail — registered declaratively via `marketplaces`.
        "ponytail@ponytail" = true;
      };
    };

    # Declaratively registered plugin marketplaces (fetched into the nix store
    # and written to ~/.claude/plugins/known_marketplaces.json). The attribute
    # name is the marketplace name, so it must match the `@<marketplace>` suffix
    # used in `enabledPlugins` above.
    marketplaces.ponytail = pkgs.fetchFromGitHub {
      owner = "DietrichGebert";
      repo = "ponytail";
      rev = "0403c4dd50ee6d0db2c3ec70b2be6655f9cb65a9";
      sha256 = "sha256-YoFsjwAoQ4RDqT3dxrlLY2q4jALZPCydvvzKDi7OUwU=";
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
