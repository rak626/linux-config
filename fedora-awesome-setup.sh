#!/usr/bin/env bash

set -e  # exit on error

echo "🚀 Starting Fedora Everything Setup..."

# -----------------------------
# 1. SYSTEM UPDATE
# -----------------------------
echo "📦 Updating system..."
sudo dnf upgrade -y

# -----------------------------
# 2. ENABLE RPM FUSION (NVIDIA etc.)
# -----------------------------
echo "🔌 Enabling RPM Fusion..."
sudo dnf install -y \
https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# -----------------------------
# 3. CORE PACKAGES (XORG + WM)
# -----------------------------
echo "🖥️ Installing Xorg + Awesome WM..."
sudo dnf install -y \
xorg-x11-server-Xorg \
xorg-x11-xinit \
awesome

# -----------------------------
# 4. ESSENTIAL UTILITIES
# -----------------------------
echo "🧰 Installing essential tools..."
sudo dnf install -y \
alacritty \
rofi \
feh \
picom \
nitrogen \
lxappearance \
thunar \
thunar-archive-plugin \
gvfs \
gvfs-mtp \
network-manager-applet \
pavucontrol \
unzip \
tar \
gzip

# -----------------------------
# 5. AUDIO (PIPEWIRE)
# -----------------------------
echo "🔊 Installing audio stack..."
sudo dnf install -y \
pipewire \
pipewire-pulseaudio \
wireplumber

# -----------------------------
# 6. NETWORK
# -----------------------------
echo "🌐 Enabling NetworkManager..."
sudo systemctl enable NetworkManager

# -----------------------------
# 7. DEV STACK
# -----------------------------
echo "👨‍💻 Installing development tools..."
sudo dnf install -y \
git \
curl \
wget \
neovim \
java-17-openjdk \
nodejs \
npm \
gcc \
gcc-c++ \
make \
python3 \
python3-pip

# -----------------------------
# 8. DISPLAY MANAGER (LIGHTDM)
# -----------------------------
echo "🖥️ Installing LightDM..."
sudo dnf install -y lightdm lightdm-gtk

sudo systemctl enable lightdm

# -----------------------------
# 9. NVIDIA DRIVERS
# -----------------------------
echo "🎮 Installing NVIDIA drivers..."
sudo dnf install -y \
akmod-nvidia \
xorg-x11-drv-nvidia-cuda

# -----------------------------
# 10. FONTS
# -----------------------------
echo "🔤 Installing fonts..."
sudo dnf install -y \
google-noto-fonts \
fontawesome-fonts

# -----------------------------
# 11. OPTIONAL: ZSH
# -----------------------------
echo "🐚 Installing Zsh..."
sudo dnf install -y zsh

# -----------------------------
# DONE
# -----------------------------
echo "✅ Setup complete!"
echo "👉 Reboot your system now:"
echo "   sudo reboot"
