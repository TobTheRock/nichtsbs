{ pkgs
, mcp-servers-nix
, enableAIFeatures ? true  # Set to false to disable MCP servers
}:

let
  # rust-analyzer MCP server for Rust code analysis
  rust-analyzer-mcp = pkgs.rustPlatform.buildRustPackage rec {
    pname = "rust-analyzer-mcp";
    version = "0.4.0";

    src = pkgs.fetchFromGitHub {
      owner = "zeenix";
      repo = "rust-analyzer-mcp";
      rev = "v${version}";
      hash = "sha256-8cRCJj/wZDWUwfQT8bME9n0wSfBNyOi2LMJk8ZkMCvg=";
    };

    cargoHash = "sha256-jTc/aO1WtPm/m/Zu7d6y36+6xh1t0b/BZCLddQYYV+g=";

    nativeBuildInputs = [ pkgs.pkg-config ];
    buildInputs = [ pkgs.openssl ];

    meta = {
      description = "MCP server providing rust-analyzer integration";
      homepage = "https://github.com/zeenix/rust-analyzer-mcp";
      mainProgram = "rust-analyzer-mcp";
    };
  };

  # MCP servers for AI-assisted development (Claude Code, Cursor, etc.)
  mcpServers = if enableAIFeatures then
    (with mcp-servers-nix.packages.${pkgs.system}; [
      mcp-server-filesystem  # File operations
      mcp-server-git         # Git operations
      mcp-server-sequential-thinking  # Enhanced reasoning
    ]) ++ [ rust-analyzer-mcp ]  # Rust code analysis
  else [ ];
in

pkgs.mkShell {
  name = "rust-dev";

  buildInputs = with pkgs; [
    # Rust toolchain with stable, nightly, and wasm target using Fenix
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ])
    (fenix.targets.wasm32-unknown-unknown.latest.rust-std)

    # Cargo tools
    wasm-pack
    cargo-nextest

    # Debugger
    vscode-extensions.vadimcn.vscode-lldb
    lldb

    # Common dev dependencies
    pkg-config
    openssl

    # MCP servers for AI-assisted development (Claude Code, etc.)
  ] ++ mcpServers;

  shellHook = ''
    echo "🦀 Rust development environment"
    echo "rustc: $(rustc --version)"
    echo "cargo: $(cargo --version)"
    ${if enableAIFeatures then ''
    echo ""
    echo "🤖 AI Features: MCP servers available"
    echo "   - mcp-server-filesystem"
    echo "   - mcp-server-git"
    echo "   - mcp-server-sequential-thinking"
    echo "   - rust-analyzer-mcp (Rust code analysis)"
    '' else ""}
    export PATH="${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH"
  '';
}
