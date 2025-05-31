#!/bin/bash

set -ouex pipefail

KERNEL_VERSION="6.12.28-stb-cbm+"

cd /ctx

# Extract kernel image and modules from tar.gz to custom_kernel directory
mkdir -p custom_kernel
tar -xzf "/ctx/${KERNEL_VERSION}.tar.gz" -C custom_kernel

copy -r custom_kernel/boot /boot
copy -r custom_kernel/lib/modules /lib/modules

# Initramfs
/usr/bin/dracut --no-hostonly --kver "${KERNEL_VERSION}" --reproducible -v --add ostree -f "/lib/modules/${KERNEL_VERSION}/initramfs.img"
chmod 0600 "/lib/modules/${KERNEL_VERSION}/initramfs.img"

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
