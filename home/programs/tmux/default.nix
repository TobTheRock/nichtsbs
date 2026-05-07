{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    keyMode = "vi";
    clock24 = true;
    historyLimit = 50000;
    terminal = "tmux-256color";
    mouse = true;
    prefix = "C-Space";
    baseIndex = 1;
    escapeTime = 0;
    sensibleOnTop = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
    ];

    extraConfig = ''
      # True color support
      set -ag terminal-overrides ",xterm-256color:RGB"

      # Renumber windows on close
      set -g renumber-windows on

      # Splits in current directory (nvim-style: v = vertical, s = horizontal)
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Pane resize with HJKL (like nvim C-w +/-/</>)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Window navigation
      bind -r Tab next-window
      bind -r BTab previous-window

      # New window in current directory
      bind c new-window -c "#{pane_current_path}"

      # Close pane without confirmation (like nvim :q)
      bind x kill-pane

      # Copy mode (nvim visual mode style)
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel

      # Quick session switching
      bind Space last-window

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded"
    '';
  };
}
