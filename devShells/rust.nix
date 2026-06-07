{ pkgs }:

pkgs.mkShell {
  name = "rust-dev";

  buildInputs = with pkgs; [
    # Rust toolchain with latest stable and wasm target using Fenix
    (fenix.stable.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rust-std"
      "rustc"
      "rustfmt"
      "rust-analyzer"
    ])
    (fenix.targets.wasm32-unknown-unknown.stable.rust-std)

    # Cargo tools
    wasm-pack
    cargo-nextest

    # Debugger
    vscode-extensions.vadimcn.vscode-lldb
    lldb

    # Common dev dependencies
    pkg-config
    openssl
  ];

  shellHook = ''
    export PATH="${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH"
    export SHELL="${pkgs.fish}/bin/fish"

    # Rust debugging: set source path and library path for std lib
    export RUST_SRC_PATH="${pkgs.fenix.stable.rust-src}/lib/rustlib/src/rust/library"
    # Add the toolchain's lib directory (contains libstd for debugging)
    RUST_TOOLCHAIN="${pkgs.fenix.stable.withComponents ["rustc" "rust-std"]}"
    export LD_LIBRARY_PATH="$RUST_TOOLCHAIN/lib:$LD_LIBRARY_PATH"

    # Switch to fish shell while preserving the nix environment
    # Only do this if we're not already in fish (prevents infinite loop)
    if [ -z "$IN_NIX_SHELL_FISH" ]; then
      export IN_NIX_SHELL_FISH=1
      echo "🦀 Rust development environment"
      echo "rustc: $(rustc --version)"
      echo "cargo: $(cargo --version)"
      exec ${pkgs.fish}/bin/fish
    fi
  '';
}
