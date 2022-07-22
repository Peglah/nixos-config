# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  fileSystems."/mnt/Backup" = {
    device = "//192.168.41.4/Backup";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.utf8";
    LC_IDENTIFICATION = "sv_SE.utf8";
    LC_MEASUREMENT = "sv_SE.utf8";
    LC_MONETARY = "sv_SE.utf8";
    LC_NAME = "sv_SE.utf8";
    LC_NUMERIC = "sv_SE.utf8";
    LC_PAPER = "sv_SE.utf8";
    LC_TELEPHONE = "sv_SE.utf8";
    LC_TIME = "sv_SE.utf8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Setting up Xorg system-wide but without a Display Manager
  services.xserver.displayManager.startx.enable = true;

  # Enable the DWM Window Manager.
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = [
          # focusonclick
          ./dwm/dwm-focusonclick-20200110-61bb8b2.diff
          # hide_vacant_tags
          ./dwm/dwm-hide_vacant_tags-6.3.diff
          # gridmode
          ./dwm/dwm-gridmode-20170909-ceac8c9.diff
          # useless gap
          ./dwm/dwm-uselessgap-20211119-58414bee958f2.diff
        ];
        configFile = super.writeText "config.h" (builtins.readFile ./dwm/dwm-config.h);
        postPatch = oldAttrs.postPatch or "" + "\necho 'Using own config file...'\n cp ${configFile} config.def.h";
      });
    })
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  sound.mediaKeys.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peglah = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #dmenu
  (dmenu.overrideAttrs (oldAttrs: rec {
    patches = [
      # border
      ./dmenu/dmenu-border-20201112-1a13d04.diff
      # center
      ./dmenu/dmenu-center-20200111-8cd37e1.diff
      # grid
      ./dmenu/dmenu-grid-4.9.diff
    ];
    configFile = writeText "config.def.h" (builtins.readFile ./dmenu/dmenu-config.h);
    postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
  }))

#  st
  (st.overrideAttrs (oldAttrs: rec {
   patches = [
     # anysize
     ./st/st-anysize-0.8.4.diff
     # csi_22_23
     ./st/st-csi_22_23-0.8.5.diff
     # gruvbox
     ./st/st-gruvbox-dark-0.8.5.diff
   ];
    configFile = writeText "config.def.h" (builtins.readFile ./st/st-config.h);
    postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
 }))

  #slstatus
  (slstatus.overrideAttrs (oldAttrs: rec {
    configFile = writeText "config.def.h" (builtins.readFile ./slstatus/slstatus-config.h);
    preBuild = "${oldAttrs.preBuild}\n cp ${configFile} config.def.h";
  }))

  afetch
  bat
  btop
  dos2unix
  feh
  ffmpegthumbnailer
  firefox
  gcc
  git
  highlight
  mosh
  mplayer
  neovim
  qutebrowser
  ranger
  streamlink
  sumneko-lua-language-server
  tdesktop
  ueberzug
  unclutter-xfixes
  unzip
  ];

  fonts.fonts = with pkgs; [
  (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
