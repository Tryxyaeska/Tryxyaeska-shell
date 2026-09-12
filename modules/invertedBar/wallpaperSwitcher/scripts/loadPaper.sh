REAL_PATH="$1"

if [ -z "$REAL_PATH" ]; then
    echo "Error: No file path provided."
    exit 1
fi

if [ ! -f "$REAL_PATH" ]; then
    echo "Error: File not found at $REAL_PATH"
    exit 1
fi

matugen image "$REAL_PATH" --source-color-index 0 --type scheme-fidelity
awww img "$REAL_PATH" --transition-type random --transition-fps 60 --transition-step 2 -f Bilinear --transition-duration 0.5 &
killall -SIGUSR1 kitty
pkill -SIGUSR1 nvim
killall -SIGUSR1 vis 2>/dev/null
hyprctl reload
gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'