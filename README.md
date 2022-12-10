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
- [ ] write install.sh logic to exclude/include installation files (default excluded: install_projects.sh, install_directories.sh)
- [ ] write script to compile sass Awaita theme using custom color scheme
- [ ] make an install_theme script to download the icon pack
- [ ] Make this configuration multi distro (arch & debian)
- [ ] change PS1 into `PS1=$(pwd=$(pwd); for i in $(seq 1 $(( $COLUMNS - ${#pwd} )) ); do echo -n \ ; done; printf "$pwd\r>"; )` or something like that

