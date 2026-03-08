#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/../global/settings.sh"
. "$(dirname "$0")/../global/icons.sh"
. "$(dirname "$0")/../global/colors.sh"

# ==============================
# Update function
# ==============================
update() {
    VOL=$(osascript -e "output volume of (get volume settings)")
    MUTED=$(osascript -e "output muted of (get volume settings)")

    if [ "$MUTED" = "true" ]; then
        ICON="$icons_volume_mute"
    elif [ "$VOL" -eq 0 ]; then
        ICON="$icons_volume_zero"
    elif [ "$VOL" -ge 1 ] && [ "$VOL" -le 24 ]; then
        ICON="$icons_volume_one"
    elif [ "$VOL" -ge 25 ] && [ "$VOL" -le 54 ]; then
        ICON="$icons_volume_two"
    else
        ICON="$icons_volume_three"
    fi

    sketchybar --set "$NAME" icon="$ICON" label="${VOL}%"
}

# ==============================
# Handler
# ==============================
case "$SENDER" in
    "volume_change") update ;;
esac
