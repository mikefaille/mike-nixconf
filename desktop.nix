{ config, pkgs, ... }:

{
  config = {

    fonts = {
      enableFontDir = true;
      enableGhostscriptFonts = true;
      fonts = with pkgs; [
        # corefonts  # Micrsoft free fonts
        inconsolata  # monospaced.
        terminus_font
        hasklig
        ubuntu_font_family  # Ubuntu fonts
        unifont # some international languages
        # google-fonts Warning : It's slow down LibreOffice
        cm_unicode
        xits-math
        dejavu_fonts
        noto-fonts
        noto-fonts-cjk
        emojione
        font-awesome-ttf
        iosevka
      ];
    };

            # Enable the X11 windowing system.
    services.xserver = {
      enable = true;
      layout = "ca"; # check avalable values in this folder /nix/store/*-xkeyboard-config-*/etc/X11/xkb/symbols/macintosh_vndr/
      libinput.enable = true;
      wacom.enable = true;
      # xserver.exportConfiguration = true;
      # powerManagement.enable = true;
      # services.xserver.xkbOptions = "eurosign:e";
      autorun = true;
      # Legacy input sources
      # xserver.synaptics.enable = true;
      # xserver.multitouch.enable = true;
#      desktopManager.gnome3.enable = true;
#      displayManager.lightdm.enable = true;
#      videoDrivers = [ "nvidiaBeta" ];
       videoDrivers = [ 
         "intel"
	 "nvidia"
       ];
    };
    # Configure packages
    nixpkgs = {
      config = {
        
        hardware.enableAllfirmware = true;
        curl = pkgs.curl.override {
          sslSupport = true;

        };
        firefox = {
          icedtea = true;
          enableGoogleTalkPlugin = true;
          #enableAdobeFlash = true;
          enableGnomeExtensions = true;
          pulseaudio = true;
        };
        chromium = {
          icedtea = true;
          enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works
          enablePepperPDF = true;
          pulseSupport = true;
          gnomeSupport = true; # that should permit app to create tray entry
        };
        allowUnfree = true;
        emacs = pkgs.emacs25.override {

          withGTK3 = true;
          withGTK2 = false;
          withXwidgets = true;
        };
        };
      };
    };
}
