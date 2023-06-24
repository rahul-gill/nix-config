# Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [ 
		./hardware-configuration.nix
		./home-manager.nix
	];

	system.stateVersion = "23.05";

	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Networking.
	networking.hostName = "nixos";
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Asia/Kolkata";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_IN";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_IN";
		LC_IDENTIFICATION = "en_IN";
		LC_MEASUREMENT = "en_IN";
		LC_MONETARY = "en_IN";
		LC_NAME = "en_IN";
		LC_NUMERIC = "en_IN";
		LC_PAPER = "en_IN";
		LC_TELEPHONE = "en_IN";
		LC_TIME = "en_IN";
	};

	# Enable the X11 windowing system.
	services.xserver.enable = true;

	# Enable the KDE Plasma Desktop Environment.
	services.xserver.displayManager.sddm.enable = true;
	services.xserver.desktopManager.plasma5.enable = true;
	environment.plasma5.excludePackages = with pkgs.libsForQt5; [
		elisa
		oxygen
		khelpcenter
	];

	# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "";
	};

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
	};

	users.defaultUserShell = pkgs.zsh;
	environment.shells = with pkgs; [ zsh ];
	nixpkgs.config.allowUnfree = true;


	# Something else


	virtualisation.docker.enable = true;

	users.users.ashenone = {
		isNormalUser = true;
		description = "ashen-one";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [ ];
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		promptInit = "";

	};
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
	};


	environment.systemPackages = with pkgs; [
		home-manager
		neovim 
		curl 
		zsh
		zsh-powerlevel10k
		htop
		neofetch
		git
		firefox
		vlc
		vscodium
		alacritty
		jetbrains.idea-ultimate
	];
}

