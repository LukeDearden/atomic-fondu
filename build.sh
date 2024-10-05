#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install screen
# Install RPM packages
rpm-ostree install \
    adwaita-blue-gtk-theme \
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
    gvfs-smb \
    gvfs-nfs \
    kitty \
    liberation-fonts \
    nautilus \
    network-manager-applet \
    pavucontrol \
    pulseaudio-utils \
    polkit-gnome \
    tldr \
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
    virt-top

# Add COPR repositories
for i in solopasha/hyprland; do
    MAINTAINER="${i%%/*}"
    REPOSITORY="${i##*/}"
    curl --output-dir "/etc/yum.repos.d/" --remote-name \
    "https://copr.fedorainfracloud.org/coprs/${MAINTAINER}/${REPOSITORY}/repo/fedora-${RELEASE}/${MAINTAINER}-${REPOSITORY}-fedora-${RELEASE}.repo"
done

rpm-ostree install cliphist hypridle hyprlock hyprshot waypaper hyprland-git hyprpaper hyprshot
#### Example for enabling a System Unit File

systemctl enable podman.socket
