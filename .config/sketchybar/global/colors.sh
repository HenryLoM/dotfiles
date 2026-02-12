#!/bin/sh

# ==============================
# Find Kitty's colors config
# ==============================
kitty_conf="$HOME/.config/kitty/colors.conf"
[ ! -f "$kitty_conf" ] && kitty_conf="$HOME/.config/kitty/colors.conf"
[ ! -f "$kitty_conf" ] && { echo "✖ Kitty config not found ✖"; exit 1; }

# ==============================
# Convert #RRGGBB → 0xAARRGGBB
# ==============================
hex2ahex() { printf "0x%s%s\n" "$1" "${2#"#"}"; }

# ==============================
# Read colors into variables
# ==============================
while read -r key val; do
    [ -z "$key" ] && continue
    [ "${key#\#}" = "$key" ] || continue  # skip comments
    eval "KITTY_$key='$val'"
done < "$kitty_conf"

# ==============================
# General
# ==============================
colors_background=$(hex2ahex cc "$KITTY_background")
colors_foreground=$(hex2ahex ff "$KITTY_foreground")
colors_transparent=0x00000000

# ==============================
# Main ANSI 0–7
# ==============================
for i in $(seq 0 7); do
    eval "colors_color$i=\$(hex2ahex ff \"\$KITTY_color$i\")"
done

# ==============================
# Titled
# ==============================
colors_bar=$(hex2ahex cc "$KITTY_background")
colors_widget=0x00000000
colors_border=0x00000000
colors_icon=$(hex2ahex ff "$KITTY_color5")
colors_label=$(hex2ahex ff "$KITTY_color4")
