# Nichts BS

Basiert auf [Nixy](https://github.com/anotherhadi/nixy) 

## Anwenden

**NixOS (awesom-o)** — das ganze System:

```sh
sudo nixos-rebuild switch --flake .#awesom-o   # oder: nixy rebuild
```

## Aufgeteilte Repos

| Repo | Inhalt |
|---|---|
| `nichtsbs` (hier) | NixOS-System, Desktop, Dotfiles |
| [`nvim`](https://github.com/TobTheRock/nvim) | die nixvim-Konfiguration + Farbpalette, von beiden Maschinen geteilt |
| [`mac`](https://github.com/TobTheRock/mac) | macOS, standalone home-manager |

`nvim` wird hier als Flake-Input eingebunden (`inputs.nvim.homeModules.nvim`),
die Palette kommt über `inputs.nvim.lib.base16` — eine Quelle für beide
Maschinen. Neovim-Änderungen gehören ins `nvim`-Repo, danach:

```sh
nix flake update nvim && nixy rebuild
```
