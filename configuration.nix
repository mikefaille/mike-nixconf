{ config, pkgs, ... }:

{
  #imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical.nix> ];

  # Use the systemd-boot efi boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = ["fbcon" "kvm-intel" "tun" "virtio"];

  boot.tmpOnTmpfs = true;
  boot.kernelPackages = pkgs.linuxPackages_4_8;
  # In conflict with latest kernel
  # boot.kernelPackages = pkgs.linux_grsec_server_latest;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./emacs-setup.nix
    ];

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.extraHosts =
  ''
     127.0.0.1 wls12c-r2-1.private
     127.0.0.1 nixos
     142.137.247.120 lounge.cedille.club
     192.168.99.100 vagrant.f8

  '';
  # networking.proxy.default = http://127.0.0.1:5000; # "http://127.0.0.1:3128";

  hardware.cpu.intel.updateMicrocode = true;
  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # # Create an Open vSwitch.
  # networking.vswitches = {
  #   "vswitch0" = {
  #     interfaces = [ "enp4s0" ];
  #   };
  # };

  # networking.wlanInterfaces = {

  # "wlan-station0" = {
  #   device = "wlp3s0";
  #   };

  # };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment= {
    variables = {
      GOPATH = "$HOME/go";
    };
    systemPackages = with pkgs; [
      # bashInteractive
      patchelf
      nixUnstable
      file
      nix-repl
      wget
      git
      emacs
      vim
      gocode # for vim/emacs go completion
      chromium
      libreoffice
      linuxPackages.nvidiabl
      libinput
      apparmor-pam
      apparmor-parser
      apparmor-profiles
      apparmor-utils
      steam
      simple-scan
      gimp
      icedtea8_web
      spotify # from nixos unstable
      psmisc #killall
      autoconf
      gcc6
      wireshark-gtk
      gnumake
      nasm
      mpv
      vlc
      openjdk
      (texlive.combine {
        inherit (texlive) scheme-medium type1cm wallpaper tcolorbox environ wrapfig capt-of
        trimspaces;
        # more packages to be found at
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/typesetting/tex/texlive-new/pkgs.nix if needed
        })
      aspell
      aspellDicts.en
      aspellDicts.fr
      nodejs
      nix-prefetch-git
      godep
      bind
      # automake
      # gnum4
      # pkgconfig
      # gettext
      # glib
      # intltool
      # glibc
      # libtool
      # guile
      # gnome.gtk
      # glibcLocales
      # glibcInfo
      python2Full
      python3
      python35Packages.bootstrapped-pip
      python35Packages.virtualenv
      python35Packages.libvirt
      python27Packages.libvirt
      python27Packages.pip
      python35Packages.pip
      python35Packages.docker_compose
      evince
      go
      go2nix
      mercurial
      kubernetes
      tree
      terminator
      # idea                       # editor
      ansible2
      virtmanager # Don't install virtinst because virt-manager provide updated cli alternatives
      #######################
      # minikube
      docker-machine
      docker-machine-driver-kvm
      ####openshift ansible reqs
      ebtables
      dnsmasq
      cdrkit
      testdisk
      zsh
      shellcheck
      transmission_gtk
      # terminix
      dmd
    ];


  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      # corefonts  # Micrsoft free fonts
      inconsolata  # monospaced
      ubuntu_font_family  # Ubuntu fonts
      unifont # some international languages
      # google-fonts Warning : It's slow down LibreOffice
      cm_unicode
      xits-math
      dejavu_fonts
      source-code-pro
      noto-fonts
      noto-fonts-cjk
      emojione
    ];
  };

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = [ pkgs.splix ];

    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.layout = "ca_multi";
    xserver.libinput.enable = true;
    xserver.modules =  with pkgs; [
    	xf86_input_wacom
    	];

    # services.xserver.xkbOptions = "eurosign:e";

    # Legacy input sources
    # xserver.synaptics.enable = true;
    # xserver.multitouch.enable = true;

    xserver.desktopManager.gnome3.enable = true;
    xserver.displayManager.gdm.enable = true;
    xserver.videoDrivers = [ "nvidiaBeta" ];
    acpid.enable = true;

    # Output journald log on tty12
    journald.console = "/dev/tty12";
  };

  # KSM
  hardware.enableKSM = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  #Enable support for SANE scanners.
  hardware.sane.enable = true;

  hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";

  powerManagement.enable = true;
  security.apparmor.enable = true;
  security.apparmor.confineSUIDApplications = true;
  nix.useSandbox = true;
  virtualisation = {
    rkt.enable = true;
    libvirtd.enable = true;
    libvirtd.enableKVM = true;
    virtualbox.host.enable = true;
    vswitch.enable = true;
    docker.enable = true;
    docker.storageDriver = "btrfs";
  };

  # Configure packages
  nixpkgs = {
    config = {
      steam = pkgs.steam.override {
        nativeOnly = true;
        newStdcpp = true;
      };
      firefox = {
        icedtea = true;
        enableGoogleTalkPlugin = true;
        enableAdobeFlash = true;
      };
      chromium = {
        icedtea = true;
        enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works
        enablePepperPDF = true;
        pulseSupport = true;
        gnomeSupport = true; # that should permit app to create tray entry
      };
      allowUnfree = true;

      packageOverrides = pkgs : rec {
        emacs = pkgs.emacs25pre;
      };

    };
  };

  users.extraUsers.michael =
  { isNormalUser = true;
    home = "/home/michael";
    description = "Nickname for root";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "kvm" "libvirt" "rkt" "libvirtd" "adm"];
    shell = "${pkgs.bashInteractive}/bin/bash";
    # openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
  };
  # users.defaultUserShell = pkgs.bashInteractive;
  ## Some try to debug bash subshell.
  # programs.bash.promptInit = "PS1=\"# \"";

  programs.bash.enableCompletion = true;

}
