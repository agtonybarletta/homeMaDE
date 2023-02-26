# Personal Rice - Desktop Environment

An homemade set of scripts used to install all programs and configurations needed for my xfce4+awesomeWM Desktop Environment setup.

## Requirements

~Debian~ Arch linux must be already installed before running this scripts.
A clean installation with `archinstall` should do the work.

## Steps
This is the list of steps needed before running this script (Arch linux)

1. setup keyboard layout
	`laodkeys us`

2. check internet connection
	`ip link`
3. update time
	`timedatectl status`
4. partition disk using `fdisk`. Here is an example configuration
	- /dev/nvme0n1p1 -> /boot
	- /dev/nvme0n1p2 -> linux-swap 
	- /dev/nvme0n1p3 -> /
	- /dev/nvme0n1p4 -> /home
	- /dev/sda       -> /mnt/hdd
5. format the /, /home, /boot and linux-swap partition
	```bash
	mkfs.ext4 /dev/nvme0n1p3 
	mkfs.ext4 /dev/nvme0n1p4 
	mkfs.fat -F 32 /dev/nvme0n1p1 
	mkswap /dev/nvme0n1p2 
	```

6. mount the partitions in the right place (/mnt)
	```bash
	mount /dev/nvme0n1p3 /mnt
	mount --mkdir /dev/nvme0n1p4 /mnt/home
	mount --mkdir /dev/nvme0n1p1 /mnt/boot
	mount --mkdir /dev/sda /mnt/mnt/hdd
	swapon /dev/nvme0n1p2 
	```
7. Install linux on the newly mounted fs

	```bash
	pacstrap -K /mnt base linux linux-firmware
	```
8. Generate fstab
	```bash
	genfstab -U /mnt >> /mnt/etc/fstab
	```
9. chroot
	```bash
	arch-chroot /mnt
	```
10. set timezone, clock, localization, from inside chroot
	```bash
	ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
	hwclock --systohc
	```
	Edit /etc/locale.gen and uncomment en_IE.UTF-8 then run `locale-gen`
	edit /etc/locale.conf and add the line `LANG=en_IE.UTF-8`
	edit /etc/vconsole.conf and add the line `KEYMAP=us`
	edit /etc/hostname and add the line `hostname`
11. Set Root password, from inside chroot
	```bash
	passwd
	```
12. Install GRUB, from inside chroot
	```bash
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg
	```
13. Install network manager, from inside chroot
	```bash
	pacman -S networkmanager
	systemctl enable NetworkManager
	```
14. Exit chroot, reboot, login with root
15. Add user and its groups
	```bash
	useradd -m -G adm,log,wheel,network,tty -s /bin/bash <username>
	passwd <username>
	```
16. Install sudo
	```bash
	pacman -S sudo
	```
	Edit /etc/sudoers, uncomment line `%wheel ALL=(ALL:ALL) ALL`
17. Install xorg
	```bash
	pacman -S xf86-video-intel xorg-server xorg-apps xorg-twm xorg-xinit
	```
	run twm test, from user run  `echo twm >> ~/.xinitrc; startx`
18. Fix Hibernate configurations

    in /etc/default/grub modify GRUB_CMDLINE_LINUX to `GRUB_CMDLINE_LINUX="resume=/dev/sdXY"`
	```bash
    `sudo grub-mkconfig -o /boot/grub/grub.cfg`
	```
    in /etc/mkinitcpio.conf at HOOKS add `resume` before `filesystems`
	```bash
    sudo mkinitcpio -p linux
	```

        
## Desktop environment

- Distribution: Arch linux
- Desktop Environment: Xfce4
- Windows Manager: AwesomeWM
- Terminal: Konsole
- Theme: Adwaita-dark 


## Run

```bash
git clone http://github.com/agtonybarletta/homeMaDE.git
cd homeMaDE
./install.sh
# optionally setup ~/.ssh in remote git repo, fill projects_list.txt and run ./install_projects.sh
```

## TODO
- [ ] add gtk.css subsitution in intall_theme
- [ ] add big theme in theme in base.properties
- [ ] remove px strin in base.properties
- [ ] add bar style parameter: [full, floating-buttons, floating-bar, floating-icons ]
- [ ] write script to compile sass Awaita theme using custom color scheme
- [X] add fix hibernate steps
- [X] add killing xfconfd and rm-rf ~/.cache before coping xfce4 config files
- [X] fix xfce4-panel trasparency ??
- [X] fix bluethoot
- [ ] add progress bar when run pacman ...
- [ ] write install.sh logic to exclude/include installation files (default excluded: install_projects.sh, install_directories.sh) (interactive mode?)
- [ ] make an install_theme script to download the icon pack
- [ ] Make this configuration multi distro (arch & debian)
- [ ] change PS1 into `PS1=$(pwd=$(pwd); for i in $(seq 1 $(( $COLUMNS - ${#pwd} )) ); do echo -n \ ; done; printf "$pwd\r>"; )` or something like that
- [ ] (xfce-panel styles)[https://github.com/xfce-ricer/custom-xfce-panels]

