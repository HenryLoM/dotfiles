#!/usr/bin/env sh

# ==============================
# Config path
# ==============================
kitty_conf="$HOME/.config/kitty/colors.conf"
[ ! -f "$kitty_conf" ] && kitty_conf="$HOME/.config/kitty/colors.conf"
[ ! -f "$kitty_conf" ] && { echo "✖ Kitty config not found ✖"; exit 1; }

# ==============================
# Convert #RRGGBB → 0xAARRGGBB
# ==============================
hex2ahex() { printf "0x%s%s\n" "$1" "${2#"#"}"; }

# ==============================
# Read config
# ==============================
while read -r key val; do
    [ -z "$key" ] && continue
    [ "${key#\#}" = "$key" ] || continue  # skip comments
    eval "KITTY_$key='$val'"
done < "$kitty_conf"

# ==============================
# General colors
# ==============================
colors_background=$(hex2ahex ff "$KITTY_background")
colors_foreground=$(hex2ahex ff "$KITTY_foreground")
colors_transparent=0x00000000

# ==============================
# ANSI colors
# ==============================
for i in $(seq 0 7); do
    eval "colors_color$i=\$(hex2ahex ff \"\$KITTY_color$i\")"
done

# ==============================
# Titled
# ==============================
colors_bar=$colors_background
colors_widget=0x00000000
colors_border=0x00000000

colors_icon=$colors_foreground
colors_label=$colors_foreground

colors_widget_popup=$colors_background
colors_border_popup=$colors_icon
