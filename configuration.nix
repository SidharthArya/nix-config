# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.

      ./hardware-configuration.nix
    ];
  nixpkgs.overlays = [ (import ./packages) ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = ["tpm"];
  boot.resumeDevice = "/dev/nvme0n1p3";
  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.adi1090x-plymouth ];
    theme = "lone";
  };  
  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  networking.networkmanager.enable = true;
  networking.hostId = "4b6ac5d4";
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  programs.fuse = {
    userAllowOther = true;
  };
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.zfs.autoScrub.enable = true;
  services.thinkfan = {
	enable = true;
	levels = [
	[0 0 45]
	[3 45 55]
	[7 55 60]
	["level full-speed" 60 2343]];
  };
  
  services.logind.extraConfig = ''
   # don’t shutdown when power button is short-pressed
   HandlePowerKey=hibernate
   ''
  ;
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.enableRedistributableFirmware = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arya = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };
  nix.trustedUsers = ["root" "arya"];
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   #neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   # plymouth
   vim
   zsh-powerlevel10k
   git

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
            ZSH_THEME="powerlevel10k"
        '';
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

