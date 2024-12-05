{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wasm-pack
    rustup
    cargo-nextest
    vscode-extensions.vadimcn.vscode-lldb
    lldb
  ];
  home.sessionVariables.PATH =
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/:$PATH";

}
