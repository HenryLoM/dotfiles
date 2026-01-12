#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/../global/settings.sh"
. "$(dirname "$0")/../global/icons.sh"
. "$(dirname "$0")/../global/colors.sh"

# ==============================
# Update Script
# ==============================
update() {
    # Run pmset only once
    batt_info=$(pmset -g batt)

    # Extract percentage safely
    if echo "$batt_info" | grep -q "InternalBattery"; then
        charge=$(echo "$batt_info" | grep -o '[0-9]\+%' | head -1 | tr -d '%')
    else
        charge="?"
    fi

    # Default icon in case of error
    ICON="$icons_battery_0"

    # Only set icon if we have a valid number
    if [ "$charge" != "?" ]; then
        if [ "$charge" -ge 90 ]; then
            ICON="$icons_battery_100"
        elif [ "$charge" -ge 60 ]; then
            ICON="$icons_battery_75"
        elif [ "$charge" -ge 30 ]; then
            ICON="$icons_battery_50"
        elif [ "$charge" -ge 10 ]; then
            ICON="$icons_battery_25"
        else
            ICON="$icons_battery_0"
        fi
    fi

    # Update widget
    sketchybar --set battery icon="$ICON" label="${charge}%"
}

# ==============================
# Click Script
# ==============================
click() {
    current=$(sketchybar --query battery | grep -q '"drawing" : "on"' && echo "on" || echo "off")

    sketchybar --set battery popup.drawing=toggle

    if [ "$current" = "off" ]; then
        batt_info=$(pmset -g batt)
        remaining=$(echo "$batt_info" | grep -o ' [0-9][0-9]*:[0-9][0-9] remaining' | awk '{print $1 "h"}')
        label=${remaining:-"No estimate"}

        sketchybar --set battery.popup label="$label"
    fi
}

# ==============================
# Click Handler
# ==============================
case "$SENDER" in
    "update" | "routine" | "power_source_change" | "system_woke") update ;;
    "mouse.clicked") click ;;
esac
