{ pkgs }:
with pkgs; [
  # Utilities
  pkgs.dmenu
  pkgs.notmuch
  pkgs.neofetch
  pkgs.xss-lock
  pkgs.fzf
  pkgs.acpi
	pkgs.ripgrep
	pkgs.fd
  pkgs.scrot
  pkgs.zip
  pkgs.htop
	pkgs.sqlite
  #TV
  pkgs.kodi
  # Compositor
  pkgs.picom
  # Media
  pkgs.mpv
  pkgs.pavucontrol
  pkgs.pamixer
  # Finance
  pkgs.ledger
  pkgs.hledger
  # Keyboard
  pkgs.fcitx-configtool
	pkgs.fortune
  # Web Browser
	pkgs.qutebrowser
	pkgs.google-chrome
	pkgs.okular
	pkgs.pcmanfm
	pkgs.ffmpeg
  pkgs.libsndfile
	pkgs.youtube-dl
	pkgs.sxhkd
	pkgs.xdo
	pkgs.wmctrl
	pkgs.nitrogen
	pkgs.rofi
	pkgs.wakatime
  pkgs.dunst
  pkgs.xtitle
  pkgs.tabbed
  pkgs.sxiv
  pkgs.zathura
  pkgs.notmuch
  pkgs.vscode
  pkgs.gimp
  pkgs.lm_sensors
  pkgs.libnotify
  pkgs.libreoffice
  pkgs.google-chrome
  pkgs.exa
  pkgs.trayer
  pkgs.dzen2
  pkgs.noto-fonts
  pkgs.trash-cli
  pkgs.duf
  pkgs.thefuck
  pkgs.gping
  pkgs.gtop
  pkgs.tldr
  pkgs.procs
  pkgs.go-mtpfs
  pkgs.xsel
  pkgs.du-dust
  pkgs.brightnessctl
  # Data Science
  pkgs.kaggle
  pkgs.bat
  pkgs.wget
  pkgs.coreutils
  pkgs.sound-theme-freedesktop
  pkgs.libcanberra_gtk3
  (pkgs.st.override { conf = builtins.readFile /home/arya/.files/Packages/st/config.h; })
  (pkgs.nnn.override { withIcons = true; })
]
