TARGET_FILE="$1"
CACHE_DIR="$HOME/.cache/quickshell/paperPreview"

if [ -z "$TARGET_FILE" ] || [ ! -f "$TARGET_FILE" ]; then
    echo "valid path only sadly"
    exit 1
fi

mkdir -p "$CACHE_DIR"

ABS_PATH=$(realpath "$TARGET_FILE")

ENCODED_NAME=$(echo -n "$ABS_PATH" | xxd -p | tr -d '\n')

PREVIEW_PATH="$CACHE_DIR/${ENCODED_NAME}.jpeg"

echo "Adding Wallpaper: $ABS_PATH"

ffmpeg -i "$ABS_PATH" -vframes 1 -vf "scale=-1:300" -q:v 2 "$PREVIEW_PATH" -y -loglevel error

echo "Preview added to UI."