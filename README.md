# Nichts BS

Basiert auf [Nixy](https://github.com/anotherhadi/nixy) 

## Anwenden

**NixOS (awesom-o)** — das ganze System:

```sh
sudo nixos-rebuild switch --flake .#awesom-o   # oder: nixy rebuild
```

**macOS (Apple Silicon)** — nur die Neovim-Konfiguration, via standalone
home-manager:

```sh
nix run home-manager -- switch --flake .#tobi@mac
```

Geteilt wird dabei `home/dev/nvim` samt Farbpalette (`themes/stylix/base16.nix`);
der Rest des Desktops bleibt NixOS-only.
