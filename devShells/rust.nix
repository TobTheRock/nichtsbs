{ pkgs }:

let
  # Rust stable toolchain + wasm32 target via Fenix.
  # Must combine the *aggregate* completeToolchain, NOT individual components
  # like fenix.stable.rustc: those are wrapped and bake --sysroot to a
  # host-only toolchain, so the wasm32 std never enters rustc's sysroot.
  # completeToolchain's rustc resolves its sysroot to the merged derivation,
  # which does contain wasm32-unknown-unknown/lib.
  rustToolchain = pkgs.fenix.combine [
    pkgs.fenix.stable.completeToolchain
    pkgs.fenix.targets.wasm32-unknown-unknown.stable.rust-std
  ];
in
pkgs.mkShell {
  name = "rust-dev";

  buildInputs = with pkgs; [
    rustToolchain

    # Cargo tools
    wasm-pack
    cargo-nextest

    # Debugger
    vscode-extensions.vadimcn.vscode-lldb
    lldb

    # ring's C fallback must be cross-compiled to wasm; its build script uses
    # $CC_wasm32_unknown_unknown (set below) and clang can target wasm, gcc can't.
    llvmPackages.clang-unwrapped

    # Common dev dependencies
    pkg-config
    openssl
  ];

  shellHook = ''
    export PATH="${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH"
    export SHELL="${pkgs.fish}/bin/fish"

    # Rust debugging: source path + libstd for the debugger. Must point at the
    # SAME combined toolchain as above: a separate host-only toolchain here
    # would make rustc load libstd via LD_LIBRARY_PATH and resolve its sysroot
    # there, hiding the wasm32 target.
    export RUST_SRC_PATH="${rustToolchain}/lib/rustlib/src/rust/library"
    export LD_LIBRARY_PATH="${rustToolchain}/lib:$LD_LIBRARY_PATH"

    # Compile ring's C for wasm with unwrapped clang (the nix wrapper injects
    # host-target flags that fight the wasm target).
    export CC_wasm32_unknown_unknown="${pkgs.llvmPackages.clang-unwrapped}/bin/clang"

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
