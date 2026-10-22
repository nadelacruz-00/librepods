#!/usr/bin/env bash
# Installs LibrePods for the current user (no root needed).
# Run from the extracted release tarball: ./install.sh
set -euo pipefail

HERE="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
PREFIX="${PREFIX:-$HOME/.local}"

install -Dm755 "$HERE/librepods" "$PREFIX/bin/librepods"
install -Dm644 "$HERE/me.kavishdevar.librepods.png" \
    "$PREFIX/share/icons/hicolor/256x256/apps/me.kavishdevar.librepods.png"
install -Dm644 "$HERE/me.kavishdevar.librepods.desktop" \
    "$PREFIX/share/applications/me.kavishdevar.librepods.desktop"

# Point the launcher at the absolute path so it works even if ~/.local/bin isn't on PATH
sed -i "s|^Exec=.*|Exec=$PREFIX/bin/librepods|" \
    "$PREFIX/share/applications/me.kavishdevar.librepods.desktop"

command -v update-desktop-database >/dev/null && update-desktop-database -q "$PREFIX/share/applications" || true
command -v gtk-update-icon-cache >/dev/null && gtk-update-icon-cache -qtf "$PREFIX/share/icons/hicolor" || true

echo "Installed LibrePods $(cat "$HERE/VERSION" 2>/dev/null || true) to $PREFIX/bin/librepods"
