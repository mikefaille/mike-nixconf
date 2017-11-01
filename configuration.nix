{ config, pkgs, lib, ... }:

{
  imports = [ 

<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel.nix>
<nixos/modules/installer/cd-dvd/channel.nix> 
      ./emacs-setup.nix
];

  # Use the systemd-boot efi boot loader.

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = ["wl" "kvm-intel" "tun" "virtio"  ];
  # boot.extraModulePackages = [ pkgs.linuxPackages.sysdig ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  boot.extraModprobeConfig = ''
    options snd_hda_intel index=0 model=intel-mac-auto id=PCH
    options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
    options snd_hda_intel model=mbp101
    options hid_apple fnmode=2
  '';

  boot.kernelModules = [ "applesmc" ];
  boot.kernelParams = [
    # https://help.ubuntu.com/community/AppleKeyboard
    # https://wiki.archlinux.org/index.php/Apple_Keyboarditrix_receiver
    "options libata.force=noncq"
    #options resume=/dev/sda5
    "hid_apple.fnmode=1"
    "hid_apple.iso_layout=0"
    "hid_apple.swap_opt_cmd=1"
  ];

  boot.tmpOnTmpfs = true;
  boot.kernelPackages = pkgs.linuxPackages_4_13;
  # In conflict with latest kernel
  # boot.kernelPackages = pkgs.linux_grsec_server_latest;

  require =
    [
      ./golang-dev.nix
      ./desktop.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.enableB43Firmware = true;
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
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
    };
    systemPackages = with pkgs; [
      # bashInteractive
      patchelf
      file
      nix-repl
      wget
      # git # Remplaceable par gitfull
     # (import ./vim.nix)
      # chromium
      libreoffice
      vim
      libinput
      apparmor-pam
      apparmor-parser
      apparmor-profiles
      apparmor-utils
      steam
      simple-scan
      gimp
      icedtea_web
      #spotify
      psmisc #killall
      autoconf
      gcc6
      gdb
      wireshark-gtk
      gnumake
      # bazel44
      nasm
      mpv
      vlc
      openjdk
      visualvm
      (texlive.combine {
        inherit (texlive) scheme-medium  wallpaper  environ wrapfig capt-of
        collection-latexextra
        collection-latexrecommended

        collection-langfrench

        # template ÉTS
        multibib

        glossaries-extra


        # more packages to be found at
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/tools/typesetting/tex/texlive-new/pkgs.nix if needed
                 ;})
      aspell
      aspellDicts.en
      aspellDicts.fr
      nodejs
      nix-prefetch-git

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
#      python2Full
#      python35

 #     python35Packages.virtualenv
 #     python35Packages.libvirt
 #     python27Packages.libvirt
#      python27Packages.pip
#      python35Packages.pip
#      python35Packages.docker_compose
#      pythonPackages.markupsafe
#      libyaml
      # cacert
      evince

      go2nix
      mercurial
      kubernetes
      tree
      terminator

      idea.pycharm-community
      # idea.idea-eap
      ansible2
      virtmanager # Don't install virtinst because virt-manager provide updated cli alternatives
      #######################
      minikube
      # docker-machine
      # docker-machine-kvm
      ####openshift ansible reqs
      ebtables
      # dnsmasq
      cdrkit
      testdisk
      zsh


      # lint for bash
      shellcheck

      transmission_gtk
      # terminix

      pandoc

      imagemagick
      firefox
      libguestfs
      # openssl
      #vagrant
      cloud-init
      libvirt
      screen
      rsync
      iftop
      packer
      axel
      asciinema
      google-chrome
      libproxy
      gnome3.gconf
      xdg-user-dirs
      davmail
      # redsocks
      gtk-recordmydesktop
      ffmpeg
      simplescreenrecorder
      cntlm # also configured using service
      proxychains
      # sqldeveloper # proprietary from oracle
      pythonPackages.ipython
      freemind
      # protobuf3_0
      popfile

      pidgin-with-plugins

      # pkgs.desktops.gnome-3.3.20.core.empathy
      # empathy
      # thunderbird

      # trying some yaml linter
      pythonPackages.yapf
      pythonPackages.yamllint
      pythonPackages.pyaml

      # Powefull opensource soft doc search
      zeal

      containerd
      virt-viewer
      # ruby

      gnome3.pomodoro
      # empathy
      # ruby dev
      bundix
      # bundler
      # rake
      # ruby.libvirt
      cloc
      pdftk


      maven
      gradle

      proxychains
      openconnect
      pwgen
      dmidecode
      nodePackages.gulp
      openssl
      lsof
      pythonPackages.dopy
      nss
      nfs-utils
      # dring
      inkscape
      scribus
      #cmdline calculator
      bc
      nethogs
      ntopng
      openssl
      subversionClient

      dos2unix

      gnome3.cheese


      bridge-utils
      fasd
      calibre
      docker
      sshpass

      slack
        corkscrew
        languagetool
        gnucash

      xorg.xkbprint # print graphical description of keyboard
      sysdig
      # pp-aterm

      paprefs
      pavucontrol


      weechat
      ledger
      haskellPackages.hledger
      # haskellPackages.hledger-ui
      # haskellPackages.hledger-web
      # strategoxt # pretty print nix store pp-aterm
      atom
      guile
      lsh # require by vagant openshift-ansible for sftp-server
      qpdfview
      adobe-reader

      docbook5
#      libxslt
#      docbook_xml_xslt
      fop


      bedup
      duperemove
      # firefox-bin
      midori
      dia
      # buck
      ant
      plantuml
      ack

      graphviz

      # kubernetes
      unzipNLS
      eclipses.eclipse-platform
      gitAndTools.gitFull
      pciutils # lspci

      rfkill # manage wifi up/down
      # rustBeta.rustc
      rustracer
      cargo
      # ring
      # # ring-gtk
      # lrc
      pkgconfig
      clang
      platformio
            # platformioPackages
      pypi2nix
 #     php70Packages.composer
 #     php
      libmysql # mysql client
      ruby
      mosquitto
      python35Packages.paho-mqtt
      arduino
      #skype
      google-cloud-sdk
      ncdu
      filezilla
      # lxd
      # lxc
      expect
      s3cmd
      freerdp
      gnupg
      meld
      # onlykey-agent
      ltrace


      stow
      neovim
      lttng-tools
      babeltrace
      lttng-ust
      # systemtap
      tcpdump
      libpcap


    ];



  };



  # list services that you want to enable:
  services = {
    hardware.pommed.enable = true;
    # telepathy.enable = true;
    # emacs = {
    #   enable = true;
    #   defaultEditor = true;
    nfs.server.enable = true;
    physlock = {
      enable = true;
      lockOn.suspend = true;
      lockOn.hibernate = true;
      disableSysRq = true;
    };
    dnsmasq.enable = true;
    # vagrant landrush :
    dnsmasq.extraConfig = ''
      server=/vagrant.f8/127.0.0.1#10053
    '';
    privoxy.enable = true;
    redis.enable = false;
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = [ pkgs.brgenml1lpr pkgs.splix pkgs.hplip pkgs.gutenprint pkgs.postscript-lexmark ];
     
    avahi.enable = true;
    avahi.nssmdns = true;
    acpid.enable = true;

    # Output journald log on tty12
    journald.console = "/dev/tty12";

    # dbus.enable = true;

    # gnome3.gvfs.enable = true;


  };


  # KSM
  hardware.enableKSM = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };


  #Enable support for SANE scanners.
  hardware.sane.enable = true;



  # bluetooth

  hardware.bluetooth.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.extraUsers.guest = {
  #   isNormalUser = true;
  #   uid = 1000;
  # };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.09";

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
    # docker.extraOptions = "--bridge br0";
  };




  users.extraGroups.docker.gid = lib.mkForce config.ids.gids.docker;
  users.extraUsers.michael =
  { isNormalUser = true;
    home = "/home/michael";
    description = "Nickname for root";
    extraGroups = [ "wheel" "networkmanager" "vboxusers" "kvm" "libvirt" "rkt" "libvirtd" "adm" "users" "docker" "dialout"];

    # openssh.authorizedKeys.keys = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
  };
  # users.defaultUserShell = pkgs.bashInteractive;
  ## Some try to debug bash subshell.
  # programs.bash.promptInit = "PS1=\"# \"";

  programs.bash.enableCompletion = true;
  programs.zsh.enableCompletion = true;

  lib.fetchers.proxyImpureEnvVars = [
    # We borrow these environment variables from the caller to allow
    # easy proxy configuration.  This is impure, but a fixed-output
    # derivation like fetchurl is allowed to do so since its result is
    # by definition pure.
    "http_proxy" "https_proxy" "ftp_proxy" "all_proxy" "no_proxy"
  ];


  services.udev.extraRules = ''
  # Copyright 2014-present PlatformIO <contact@platformio.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# UDEV Rules for PlatformIO supported boards, http://platformio.org/boards
#
# The latest version of this file may be found at:
# 	https://github.com/platformio/platformio-core/blob/develop/scripts/99-platformio-udev.rules
#
# This file must be placed at:
# 	/etc/udev/rules.d/99-platformio-udev.rules    (preferred location)
#   	or
# 	/lib/udev/rules.d/99-platformio-udev.rules    (req'd on some broken systems)
#
# To install, type this command in a terminal:
# 	sudo cp 99-platformio-udev.rules /etc/udev/rules.d/99-platformio-udev.rules
#
# Restart "udev" management tool:
#	sudo service udev restart
#		or
# 	sudo udevadm control --reload-rules
#	sudo udevadm trigger
#
# After this file is installed, physically unplug and reconnect your board.

# CP210X USB UART
SUBSYSTEMS=="usb", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE:="0666"

# FT232R USB UART
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE:="0666"

# Prolific Technology, Inc. PL2303 Serial Port
SUBSYSTEMS=="usb", ATTRS{idVendor}=="067b", ATTRS{idProduct}=="2303", MODE:="0666"

# QinHeng Electronics HL-340 USB-Serial adapter
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", MODE:="0666"

# Arduino boards
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="[08][02]*", MODE:="0666"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="2a03", ATTRS{idProduct}=="[08][02]*", MODE:="0666"

# Arduino SAM-BA
ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE:="0666"

# Digistump boards
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16d0", ATTRS{idProduct}=="0753", MODE:="0666", ENV{ID_MM_DEVICE_IGNORE}="1"

# STM32 discovery boards, with onboard st/linkv2
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374?", MODE:="0666"

# USBtiny
SUBSYSTEMS=="usb", ATTRS{idProduct}=="0c9f", ATTRS{idVendor}=="1781", MODE="0666"

# Teensy boards
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{ID_MM_DEVICE_IGNORE}="1"
ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", ENV{MTP_NO_PROBE}="1"
SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", MODE:="0666"
KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789]?", MODE:="0666"

#TI Stellaris Launchpad
SUBSYSTEMS=="usb", ATTRS{idVendor}=="1cbe", ATTRS{idProduct}=="00fd", MODE="0666"

#TI MSP430 Launchpad
SUBSYSTEMS=="usb", ATTRS{idVendor}=="0451", ATTRS{idProduct}=="f432", MODE="0666"

# CMSIS-DAP compatible adapters
ATTRS{product}=="*CMSIS-DAP*", MODE="664", GROUP="plugdev"
  '';

}
