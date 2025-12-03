{ pkgs, ... }:

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
  ];

  shellHook = ''
    echo "🦀 Rust development environment"
    echo "rustc: $(rustc --version)"
    echo "cargo: $(cargo --version)"
    export PATH="${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH"
  '';
}
