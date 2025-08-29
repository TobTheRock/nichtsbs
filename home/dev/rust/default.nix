{ pkgs, ... }:

{
  home.packages = with pkgs; [
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
    wasm-pack
    cargo-nextest
    vscode-extensions.vadimcn.vscode-lldb
    lldb
  ];
  home.sessionVariables.PATH =
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH";

}
