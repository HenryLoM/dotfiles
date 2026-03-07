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
# Click function
# ==============================
click() {
    sketchybar --remove '/output\..*/'

    CURRENT=$(SwitchAudioSource -c)

    # Read outputs line-by-line (no mapfile)
    while IFS= read -r dev; do
        [ -z "$dev" ] && continue

        name="output.$(echo "$dev" | tr ' ' '_')"
        if [ "$dev" = "$CURRENT" ]; then
            icon="􀥑"  # selected
        else
            icon="􀫠"  # normal
        fi

        sketchybar --add item "$name" popup.volume \
                   --set "$name" icon="$icon" label="$dev" \
                   icon.padding_left=$settings_icon_padding_left \
                   icon.padding_right=$settings_icon_padding_right \
                   label.padding_left=$settings_label_padding_left \
                   label.padding_right=$settings_label_padding_right \
                   click_script="SwitchAudioSource -s \"$dev\"; sketchybar --set volume popup.drawing=off; $0"
    done <<EOF
$(SwitchAudioSource -a -t output)
EOF

    sketchybar --set volume popup.drawing=toggle
}

# ==============================
# Handler
# ==============================
case "$SENDER" in
    "volume_change") update ;;
    "mouse.clicked") click ;;
esac
