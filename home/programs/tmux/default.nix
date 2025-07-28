{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Set tmux package (optional)
    package = pkgs.tmux;

    # Use vi-style keybindings in copy mode
    keyMode = "vi";

    # Optional: Set some useful defaults
    clock24 = true;
    historyLimit = 5000;
    terminal = "screen-256color";

    # tmux 3.2+: enable mouse support
    mouse = true;

    # Set the prefix (optional: C-a or default C-b)
    prefix = "C-b";

    # Keybindings: define tmux commands in structured format
    keyBindings = {
      # Pane navigation like Vim (Control + h/j/k/l)
      "C-h" = "select-pane -L";
      "C-j" = "select-pane -D";
      "C-k" = "select-pane -U";
      "C-l" = "select-pane -R";

      # Splitting panes using s (horizontal) and v (vertical)
      "s" = "split-window -v";
      "v" = "split-window -h";
    };

    # For vi-style copy mode selection and yank
    extraConfig = ''
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      set -sg escape-time 10
    '';
  };
}
