{ pkgs
, mcp-servers-nix
, enableAIFeatures ? true  # Set to false to disable MCP servers
}:

let
  # rust-analyzer MCP server for Rust code analysis
  rust-analyzer-mcp = pkgs.rustPlatform.buildRustPackage rec {
    pname = "rust-analyzer-mcp";
    version = "0.2.0";

    src = pkgs.fetchFromGitHub {
      owner = "zeenix";
      repo = "rust-analyzer-mcp";
      rev = "v${version}";
      hash = "sha256-brnzVDPBB3sfM+5wDw74WGqN5ahtuV4OvaGhnQfDqM0=";
    };

    cargoHash = "sha256-7t4bjyCcbxFAO/29re7cjoW1ACieeEaM4+QT5QAwc34=";

    # Tests require files not available in the Nix sandbox
    doCheck = false;

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
      "rust-std"
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
    export PATH="${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH"
    export SHELL="${pkgs.fish}/bin/fish"

    # Rust debugging: set source path and library path for std lib
    export RUST_SRC_PATH="${pkgs.fenix.complete.rust-src}/lib/rustlib/src/rust/library"
    # Add the toolchain's lib directory (contains libstd for debugging)
    RUST_TOOLCHAIN="${pkgs.fenix.complete.withComponents ["rustc" "rust-std"]}"
    export LD_LIBRARY_PATH="$RUST_TOOLCHAIN/lib:$LD_LIBRARY_PATH"

    ${if enableAIFeatures then ''
    # Configure Claude Code MCP servers using CLI
    claude mcp add filesystem -s user -- ${mcp-servers-nix.packages.${pkgs.system}.mcp-server-filesystem}/bin/mcp-server-filesystem . 2>/dev/null || true
    claude mcp add git -s user -- ${mcp-servers-nix.packages.${pkgs.system}.mcp-server-git}/bin/mcp-server-git 2>/dev/null || true
    claude mcp add sequential-thinking -s user -- ${mcp-servers-nix.packages.${pkgs.system}.mcp-server-sequential-thinking}/bin/mcp-server-sequential-thinking 2>/dev/null || true
    claude mcp add rust-analyzer -s user -- ${rust-analyzer-mcp}/bin/rust-analyzer-mcp 2>/dev/null || true
    '' else ""}

    # Switch to fish shell while preserving the nix environment
    # Only do this if we're not already in fish (prevents infinite loop)
    if [ -z "$IN_NIX_SHELL_FISH" ]; then
      export IN_NIX_SHELL_FISH=1
      echo "🦀 Rust development environment"
      echo "rustc: $(rustc --version)"
      echo "cargo: $(cargo --version)"
      ${if enableAIFeatures then ''echo ""; echo "🤖 AI Features: MCP servers available"'' else ""}
      exec ${pkgs.fish}/bin/fish
    fi
  '';
}
