# Mime allows us to configure the default applications for each file type
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/markdown" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
      "text/x-shellscript" = "nvim.desktop";
      "text/x-python" = "nvim.desktop";
      "text/x-go" = "nvim.desktop";
      "text/css" = "nvim.desktop";
      "text/javascript" = "nvim.desktop";
      "text/x-c" = "nvim.desktop";
      "text/x-c++" = "nvim.desktop";
      "text/x-java" = "nvim.desktop";
      "text/x-rust" = "nvim.desktop";
      "text/x-yaml" = "nvim.desktop";
      "text/x-toml" = "nvim.desktop";
      "text/x-dockerfile" = "nvim.desktop";
      "text/x-xml" = "nvim.desktop";
      "text/x-php" = "nvim.desktop";
      "image/png" = "imv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/jpg" = "imv.desktop";
      "image/webp" = "imv.desktop";
      "image/gif" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/pdf" = "okularApplication_pdf.desktop";

      "x-scheme-handler/chrome" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "onlyoffice-desktopeditors.desktop";
    };
  };
}
