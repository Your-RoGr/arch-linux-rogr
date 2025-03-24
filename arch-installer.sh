#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

echo "Enter username:"
read username
username=$(echo $username | tr -cd '[:alnum:]_-')
echo "You entered: $username"

echo "Enter hostname:"
read hostname
hostname=$(echo $hostname | tr -cd '[:alnum:]_-')
echo "You entered: $hostname"

fdisk -l
echo "Enter your disk (press enter for default: sda):"
read sd
sd=${sd:-sda}
sd=$(echo $sd | sed 's/[^[:alnum:]\/_:]//g')
echo "You entered: $sd"

echo "Enter timezone (press enter for default: Asia/Yekaterinburg):"
read current_timezone
current_timezone=${current_timezone:-Asia/Yekaterinburg}
current_timezone=$(echo $current_timezone | sed 's/[^[:alnum:]\/_:]//g')
echo "You entered: $current_timezone"

# Set time
echo "Set time"
timedatectl set-ntp true
timedatectl set-timezone $current_timezone
timedatectl status
sleep 1

echo "Selected disk:"
fdisk -l /dev/$sd

if [[ "${sd:0:4}" == "skip" ]]; then
    echo "Autoformatting skipped"
elif [[ "${sd:0:2}" == "sd" ]]; then
    # Partitioning the disk with parted
    echo "Partitioning the disk with parted"
    parted /dev/$sd mklabel gpt
    parted /dev/$sd mkpart primary fat32 1MiB 513MiB
    parted /dev/$sd set 1 boot on
    parted /dev/$sd mkpart primary ext4 513MiB 100%

    # Formatting the partitions
    echo "Formatting the partitions"
    mkfs.fat -F 32 /dev/"$sd"1
    mkfs.ext4 /dev/"$sd"2

    # Mounting the partitions
    echo "Mounting the partitions"
    mount /dev/$sd"2" /mnt
    mkdir /mnt/boot
    mount /dev/$sd"1" /mnt/boot
elif [[ "${sd:0:4}" == "nvme" ]]; then
    # Partitioning the disk with parted
    echo "Partitioning the disk with parted"
    parted /dev/$sd mklabel gpt
    parted /dev/$sd mkpart primary fat32 1MiB 513MiB
    parted /dev/$sd set 1 boot on
    parted /dev/$sd mkpart primary ext4 513MiB 100%

    # Formatting the partitions
    echo "Formatting the partitions"
    mkfs.fat -F 32 /dev/"$sd"p1
    mkfs.ext4 /dev/"$sd"p2

    # Mounting the partitions
    echo "Mounting the partitions"
    mount /dev/$sd"p2" /mnt
    mkdir /mnt/boot
    mount /dev/$sd"p1" /mnt/boot
else
    echo "Wrong disk or no existing format in the script, format the partitions manually, create /mnt/boot and mount /mnt/boot (EFI disk partitions) and /mnt in different disk partitions."
    echo "Partition the drive into three partitions for EFI (512mb), swap, and the main drive"
    echo "Don't forget enable swap space"
    echo "After load script again and write "skip" when selecting a disk."
    exit 1
fi

# Installing the base system
echo "Installing the base system"
pacstrap /mnt base linux linux-firmware

# Generating fstab
echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot to the installed system
echo "Chrooting into the installed system"

mkdir -p /mnt/local/$username

cat > /mnt/local/$username/continue_install.sh << EOL
#!/bin/bash

# Configuring pacman on installer
echo "Configuring pacman"
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 10/g' /etc/pacman.conf

pacman -Sy --noconfirm sudo

# Configuring users
echo "Configuring users"
echo "Enter the root password"
passwd
useradd -m -g users -G wheel,audio,video,optical,storage -s /bin/bash $username
echo "Enter the $username password"
passwd $username
sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers

# Installing software
echo "Installing software"
pacman -Sy --noconfirm grub efibootmgr micro dhcpcd os-prober ntfs-3g zram-generator git curl iwd

# Enabling dhcpcd
echo "Enabling dhcpcd"
systemctl enable dhcpcd

echo "Configuring zram-generator"
sh -c "cat > /etc/systemd/zram-generator.conf << EOL
[zram0]
zram-size = ram * 0.75
EOL"

# Installing openssh
echo "Installing openssh"
pacman -Sy --noconfirm openssh

# Enabling sshd
echo "Enabling sshd"
systemctl enable sshd

# Configuring locales
echo "Configuring locales"
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Configuring hostname
echo "Configuring hostname"
sh -c "cat > /etc/hostname.conf << EOL
$hostname
EOL"

# Configuring hostname
echo "Configuring hostname"
sh -c "cat > /etc/hosts << EOL
# Static table lookup for hostnames.
# See hosts(5) for details.

127.0.0.1    localhost
::1          localhost
127.0.1.1    $hostname.localdomain    $hostname
EOL"

# Configuring timezone
echo "timezone - $current_timezone"
ln -sf /usr/share/zoneinfo/$current_timezone /etc/localtime
hwclock --systohc

# Installing GRUB
echo "Installing GRUB"
mkdir /boot/EFI

if [[ "${sd:0:4}" == "skip" ]]; then
    echo "Enter path for /boot/EFI (for example: /dev/sda1):"
    read path_efi
    path_efi=$(echo \$path_efi | sed 's/[^[:alnum:]\/_:]//g')
    echo "You entered: \$path_efi"
    mount \$path_efi /boot/EFI
elif [[ "${sd:0:2}" == "sd" ]]; then
    mount /dev/$sd"1" /boot/EFI
elif [[ "${sd:0:4}" == "nvme" ]]; then
    mount /dev/$sd"p1" /boot/EFI
fi

grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/EFI --removable
grub-mkconfig -o /boot/grub/grub.cfg

# Configuring GRUB for other system
sed -i 's/#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/g' /etc/sudoers

# Exiting and rebooting
echo "Exiting and rebooting"
exit
EOL

chmod +x /mnt/local/$username/continue_install.sh
arch-chroot /mnt /bin/bash /local/$username/continue_install.sh

umount -R /mnt

poweroff
