#!/bin/bash

set -ouex pipefail

# Create a working directory
mkdir -p /tmp/kukui-kernel
cd /tmp/kukui-kernel

# Download the APK
cp /ctx/6.12.28-stb-cbm+.tar.gz .

# Extract kernel image and modules from APK
tar -xzf *.tar.gz

# Move kernel image and modules to appropriate locations in the container
# (Adjust paths as needed for your base image)
cp -r boot /boot/vmlinuz-kukui
cp -r lib/modules/* /lib/modules/

# Optionally: update symlinks and run depmod
ln -sf /boot/vmlinuz-kukui /boot/vmlinuz
#depmod

# Clean up
cd /
rm -rf /tmp/kukui-kernel

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
