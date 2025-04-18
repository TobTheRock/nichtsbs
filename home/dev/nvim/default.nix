{ inputs, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/cmp.nix
    ./plugins/dashboard.nix
    ./plugins/git.nix
    ./plugins/lsp.nix
    ./plugins/markdown.nix
    ./plugins/tree.nix
    ./plugins/ui.nix
    ./plugins/utils.nix
    ./plugins/dap.nix
    ./plugins/snacks.nix
    ./plugins/telescope.nix
    ./plugins/test.nix

    ./autocmds.nix
    ./options.nix
    ./keymaps.nix
  ];

  programs.nixvim.enable = true;
}
