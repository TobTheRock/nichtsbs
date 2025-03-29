{ config, pkgs, ... }: {
  programs.nixvim = {
    highlightOverride = {
      FloatBorder.fg = "#${config.lib.stylix.colors.base0D}";
    };
    plugins = {
      copilot-vim = {
        enable = true;
        package = pkgs.vimPlugins.copilot-vim;
      };
      # TODO not working currently
      #copilot-lua.enable = true;
      copilot-chat.enable = true;
      flash.enable = true;
      image = {
        enable = true;
        settings.integrations.markdown = {
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
        };
      };
      tmux-navigator.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      friendly-snippets.enable = true;
      todo-comments.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
      };
      harpoon = {
        enable = true;
        enableTelescope = true;
        keymapsSilent = true;
        keymaps = {
          addFile = "<leader>ha";
          toggleQuickMenu = "<leader>hu";
          navNext = "<leader>hl";
          navPrev = "<leader>hh";
          navFile = {
            "1" = "<leader>h1";
            "2" = "<leader>h2";
            "3" = "<leader>h3";
            "4" = "<leader>h4";
          };
        };
      };
      treesitter-context.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          size = 80;
          open_mapping = "[[<leader>`]]";
          direction = "vertical";
        };
      };
      yanky.enable = true;
      spectre.enable = true;
    };
  };
}
