# Personal Rice - Desktop Environment

Collection of scripts to install all programs and configuratios for my  xfce4+awesomeWm setup

## Requirements

~Debian~ Arch linux must be already installed before running this scripts.
A clean installation with `archinstall` should do the work.

## Desktop environment

- Distribution: Arch linux
- Desktop Environment: Xfce4
- Windows Manager: AwesomeWM
- Terminal: Konsole
- Theme: Adwaita-dark 


## Run

```bash
./install.sh
```

## TODO
- [ ] write script to dive default options (pacman)
- [ ] write script to check every command
- [ ] write script to redirect to log files/ make it silent
- [ ] write requirements check for each script (eg yay)
- [ ] write script to compile sass Awaita theme using custom color scheme
- [ ] make an install_theme script to download the icon pack
- [ ] Make this configuration multi distro (arch & debian)
- [ ] change PS1 into `PS1=$(pwd=$(pwd); for i in $(seq 1 $(( $COLUMNS - ${#pwd} )) ); do echo -n \ ; done; printf "$pwd\r>"; )` or something like that
- [X] fix ~/.config/xfce4 issue --> xfce4 configurations doen't get loaded :/ --> solved ? test it!
- [X] fix Adwaita theme
- [X] fix konsole configs, profile is not being loaded 
- [X] add hibernation script (?) --> done ?
- [X] use script.sh template on install_basic.sh
- [X] use script.sh template on install_de_config.sh
- [X] use script.sh template on install_directories.sh
- [X] look for autocompletion feature on bash read command (for install_directories.sh)
- [X] make install_directories.sh interactive
- [X] dive into awesome theming (color scheme)

