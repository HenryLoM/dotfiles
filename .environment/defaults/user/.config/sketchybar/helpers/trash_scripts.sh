#!/bin/sh

# ==============================
# Source globals
# ==============================
. "$(dirname "$0")/../global/settings.sh"
. "$(dirname "$0")/../global/icons.sh"
. "$(dirname "$0")/../global/colors.sh"

# ==============================
# Click Script
# ==============================
click() {
    osascript -e 'tell application "Finder" to empty trash'
    sketchybar --set trash icon="$icons_trash_empty"
    afplay "/System/Library/Components/CoreAudio.component/Contents/SharedSupport/SystemSounds/finder/empty trash.aif"
    sketchybar --set trash icon="$icons_trash_idle"
}

# ==============================
# Bare call without a handler
# ==============================
click
