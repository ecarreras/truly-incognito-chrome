#!/bin/bash

# Defineix els camins
BIN_DIR="$HOME/bin"
SCRIPT_SRC="random-chrome.sh"
SCRIPT_DEST="$BIN_DIR/random-chrome.sh"
DESKTOP_SRC="random-chrome.desktop"
DESKTOP_DEST="$HOME/.local/share/applications/random-chrome.desktop"
ICON_SRC="random-chrome.png"
ICON_DEST="$HOME/.local/share/icons/random-chrome.png"

# Crea el directori ~/bin si no existeix
if [ ! -d "$BIN_DIR" ]; then
    echo "Creating $BIN_DIR directory..."
    mkdir -p "$BIN_DIR"
fi

# Mou el script sh al directori ~/bin
echo "Moving $SCRIPT_SRC to $SCRIPT_DEST..."
mv "$SCRIPT_SRC" "$SCRIPT_DEST"

# Fes que el script sigui executable
chmod +x "$SCRIPT_DEST"

# Substitueix el camp Exec del fitxer .desktop
echo "Updating Exec path in $DESKTOP_SRC..."
sed -i "s|Exec=.*|Exec=$SCRIPT_DEST|" "$DESKTOP_SRC"

# Crea el directori ~/.local/share/applications si no existeix
if [ ! -d "$(dirname "$DESKTOP_DEST")" ]; then
    echo "Creating $(dirname "$DESKTOP_DEST") directory..."
    mkdir -p "$(dirname "$DESKTOP_DEST")"
fi

# Mou el fitxer .desktop al directori ~/.local/share/applications
echo "Moving $DESKTOP_SRC to $DESKTOP_DEST..."
mv "$DESKTOP_SRC" "$DESKTOP_DEST"

# Mou la icona al directori ~/.local/share/icons
echo "Moving $ICON_SRC to $ICON_DEST..."
mv "$ICON_SRC" "$ICON_DEST"

# Actualitza la base de dades de les aplicacions
echo "Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/"

echo "Installation complete. You can now find 'Random Chrome' in your applications menu."
