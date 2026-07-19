REAL_PATH="$1"

if [ -z "$REAL_PATH" ]; then
    echo "Error: No file path provided."
    exit 1
fi

if [ ! -f "$REAL_PATH" ]; then
    echo "Error: File not found at $REAL_PATH"
    exit 1
fi

awww img "$REAL_PATH" --transition-type random --transition-fps 60 --transition-step 2 -f Bilinear --transition-duration 1