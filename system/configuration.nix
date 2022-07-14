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

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;

  # Setting up Xorg system-wide but without a Display Manager
  services.xserver.displayManager.startx.enable = true;

  # Enable the DWM Window Manager.
  services.xserver.windowManager.dwm.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        patches = [
          # fibonacci
#          (super.fetchpatch {
#            url = "https://dwm.suckless.org/patches/fibonacci/dwm-fibonacci-20200418-c82db69.diff";
#            sha256 = "12y4kknly5irwd6yhqj1zfr3h06hixi2p7ybjymhhhy0ixr7c49d";
#          })
          # focusonclick
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/focusonclick/dwm-focusonclick-20200110-61bb8b2.diff";
            sha256 = "1fi3xsk790cdl037ysr8vyrnqb7d0a0zqmvslh0jcambmh88d98b";
          })
          # hide_vacant_tags
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/hide_vacant_tags/dwm-hide_vacant_tags-6.3.diff";
            sha256 = "0c8cf5lm95bbxcirf9hhzkwmc5a690albnxcrg363av32rf2yaa1";
          })
          # gridmode
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/gridmode/dwm-gridmode-20170909-ceac8c9.diff";
            sha256 = "180kdpj6ci5r7hxmv2k5hjp3miykdjaxiyazp4i3l8v8rjzl48w3";
          })
          # three-column
#          (super.fetchpatch {
#            url = "https://dwm.suckless.org/patches/three-column/tcl.c";
#            sha256 = "1v2d4cd942xl3fcv8jll0lmi7vq1fhk75dgv711ia6543161hbzr";
#          })
          # useless gap
          (super.fetchpatch {
            url = "https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-20211119-58414bee958f2.diff";
            sha256 = "0xpmxw11ppdhrcr2yp0nsvfnsl4hivxkdmk7l5ygwf0zmrspmjw0";
          })
        ];
        configFile = super.writeText "config.h" (builtins.readFile ./dwm-config.h);
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

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peglah = {
    isNormalUser = true;
    description = "Martin";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  (dmenu.overrideAttrs (oldAttrs: rec {
    patches = [
      # border
      (fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/border/dmenu-border-20201112-1a13d04.diff";
        sha256 = "1ghckggwgasw9p87x900gk9v3682d6is74q2rd0vcpsmrvpiv606";
      })
      # center
      (fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-20200111-8cd37e1.diff";
        sha256 = "0x7jc1m0138p7vfa955jmfhhyc317y0wbl8cxasr6cfpq8nq1qsg";
      })
      # grid
      (fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/grid/dmenu-grid-4.9.diff";
        sha256 = "1d537263rl685z7107p1i9c4lr832b3axg59sym9la3h3n68h3fp";
      })
      # gruvbox
      (fetchpatch {
        url = "https://tools.suckless.org/dmenu/patches/gruvbox/dmenu-gruvbox-20210329-9ae8ea5.diff";
        sha256 = "1fblgsxh86rgbl25n1qbkz5gfndvkv20hyzfiy068n5hih2mvmp6";
      })
    ];
  }))

  (st.overrideAttrs (oldAttrs: rec {
    patches = [
      # anysize
      (fetchpatch {
        url = "https://st.suckless.org/patches/anysize/st-anysize-0.8.4.diff";
        sha256 = "1w3fjj6i0f8bii5c6gszl5lji3hq8fkqrcpxgxkcd33qks8zfl9q";
      })
      # csi_22_23
      (fetchpatch {
        url = "https://st.suckless.org/patches/csi_22_23/st-csi_22_23-0.8.5.diff";
        sha256 = "0w0zfymq5xy0b6cb8dnqvlzfax43l5dfdy806v40ganwfxwbxh09";
      })
      # gruvbox
      (fetchpatch {
        url = "https://st.suckless.org/patches/gruvbox/st-gruvbox-dark-0.8.5.diff";
        sha256 = "0jvn0i0fl0w3c8dcmwyh9w19g3hsi22cqmyqly5zjzjwjhc8qnjv";
      })
    ];
  }))

#  slstatus
  (slstatus.overrideAttrs (oldAttrs: rec {
    configFile = writeText "config.h" (builtins.readFile ./slstatus-config.h);
    preBuild = "${oldAttrs.preBuild}\n cp ${configFile} config.def.h";
  }))

  neovim
  git
  feh
  mosh
  afetch
  ranger
  mplayer
  btop
  bat
  highlight
  ffmpegthumbnailer
  dos2unix
  gcc
  unzip
  sumneko-lua-language-server
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
