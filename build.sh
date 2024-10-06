#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Install RPM packages
rpm-ostree install \
    screen \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    adwaita-qt5 \
    bash-completion \
    btop \
    blueman \
    breeze-cursor-theme \
    breeze-gtk \
    breeze-icon-theme \
    chrony \
    firewall-config \
    flatpak \
    fontawesome-6-free-fonts \
    fontawesome-6-brands-fonts \
    fuzzel \
    git \
    gnome-keyring \
    gnome-packagekit-installer \
    gnome-software \
    goverlay \
    gvfs-smb \
    gvfs-nfs \
    kitty \
    keepassxc \
    liberation-fonts \
    nautilus \
    network-manager-applet \
    pavucontrol \
    pulseaudio-utils \
    xdg-user-dirs \
    xdg-user-dirs-gtk \
    xdg-desktop-portal-hyprland \
    wl-clipboard \
    wlsunset \
    wlogout \
    virt-install \
    libvirt-daemon-config-network \
    libvirt-daemon-kvm \
    qemu-kvm \
    virt-manager \
    virt-viewer \
    guestfs-tools \
    python3-tools \
    python3-libguestfs \
    pip \
    virt-top

# Add COPR repositories
for i in solopasha/hyprland; do
    MAINTAINER="${i%%/*}"
    REPOSITORY="${i##*/}"
    curl --output-dir "/etc/yum.repos.d/" --remote-name \
    "https://copr.fedorainfracloud.org/coprs/${MAINTAINER}/${REPOSITORY}/repo/fedora-${RELEASE}/${MAINTAINER}-${REPOSITORY}-fedora-${RELEASE}.repo"
done

rpm-ostree install cliphist hypridle hyprlock hyprshot waypaper hyprland hyprpaper hyprshot waybar-git
#### Example for enabling a System Unit File

## Install VS Codium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | tee -a /etc/yum.repos.d/vscodium.repo
rpm-ostree install codium

# Install Zen Browser
#wget "https://copr.fedorainfracloud.org/coprs/sneexy/zen-browser/repo/fedora-$(rpm -E %fedora)/sneexy-zen-browsder-fedora-$(rpm -E %fedora).repo" -O "/etc/yum.repos.d/_copr_sneexy-zen-browser.repo"
#rpm-ostree install zen-browser

# Install PyWal (probably needs to be done later)
pip3 install pywal --user

systemctl enable podman.socket
