{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/cmp.nix
    ./plugins/dashboard.nix
    ./plugins/lsp.nix
    ./plugins/markdown.nix
    ./plugins/tree.nix
    ./plugins/ui.nix
    ./plugins/utils.nix
    ./plugins/dap.nix
    ./plugins/telescope.nix
    ./plugins/test.nix
    ./plugins/zenmode.nix

    ./autocmds.nix
    ./options.nix
    ./keymaps.nix
  ];

  programs.nixvim.enable = true;
}
