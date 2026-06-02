#!/usr/bin/env bash
# Install CentrexOS branding assets into the system
set -euo pipefail

[[ "$EUID" -eq 0 ]] || { echo "Run as root."; exit 1; }

BRANDING_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

info() { echo -e "\033[1;34m[branding]\033[0m $*"; }
ok()   { echo -e "\033[1;32m[branding]\033[0m $*"; }

# Plymouth theme
info "Installing Plymouth theme..."
PLYMOUTH_DIR="/usr/share/plymouth/themes/centrex-splash"
mkdir -p "$PLYMOUTH_DIR"
cp -r "$BRANDING_DIR/plymouth/centrex-splash/"* "$PLYMOUTH_DIR/"
update-alternatives --install /usr/share/plymouth/themes/default.plymouth \
    default.plymouth "$PLYMOUTH_DIR/centrex-splash.plymouth" 200 || true
plymouth-set-default-theme centrex-splash 2>/dev/null || true
ok "Plymouth theme installed."

# GRUB theme
info "Installing GRUB theme..."
GRUB_DIR="/usr/share/grub/themes/centrex"
mkdir -p "$GRUB_DIR"
cp -r "$BRANDING_DIR/grub/centrex-theme/"* "$GRUB_DIR/"
if [[ -f /etc/default/grub ]]; then
    if ! grep -q "GRUB_THEME" /etc/default/grub; then
        echo 'GRUB_THEME="/usr/share/grub/themes/centrex/theme.txt"' >> /etc/default/grub
    else
        sed -i 's|#\?GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/centrex/theme.txt"|' /etc/default/grub
    fi
    update-grub 2>/dev/null || grub-mkconfig -o /boot/grub/grub.cfg 2>/dev/null || true
fi
ok "GRUB theme installed."

# Logo
info "Installing logo assets..."
mkdir -p /usr/share/centrexos
cp "$BRANDING_DIR/logo/centrexos.svg"       /usr/share/centrexos/logo.svg
cp "$BRANDING_DIR/logo/centrexos-white.svg" /usr/share/centrexos/logo-white.svg
ok "Logo assets installed."

ok "Branding installation complete."
