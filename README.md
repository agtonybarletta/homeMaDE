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
- [X] fix ~/.config/xfce4 issue --> xfce4 configurations doen't get loaded :/ --> solved ? test it!
- [X] fix Adwaita theme
- [X] fix konsole configs, profile is not being loaded 
- [X] add hibernation script (?) --> done ?
- [ ] use script.sh template on install_basic.sh
- [ ] use script.sh template on install_de_config.sh
- [X] use script.sh template on install_directories.sh
- [X] look for autocompletion feature on bash read command (for install_directories.sh)
- [X] make install_directories.sh interactive
- [X] dive into awesome theming (color scheme)
- [ ] write script to compile sass Awaita theme using custom color scheme
- [ ] write requirements check for each script (eg yay)
- [ ] Make this configuration multi distro (arch & debian)
