#!/bin/bash

# Force the script to run with sudo from the start
if [ "$EUID" -ne 0 ]; then
    echo "=== Please run this script with sudo: sudo ./Build.sh ==="
    exit 1
fi

echo "=========================================================="
echo " Choose a Neo Linux Profile to build:"
echo " 1) Core (Default)"
echo " 2) Dev-Nova"
echo " 3) Hyper-Nova"
echo " 4) Game-Nova"
echo "=========================================================="
# Pause and wait for user typing
read -p "Type profile name or number [Core]: " SELECTION

# Convert numbers or empty inputs into the actual profile names
case "$SELECTION" in
    2|[Dd]ev-[Nn]ova)
        PROFILE="Dev-Nova"
        ;;
    3|[Hh]yper-[Nn]ova)
        PROFILE="Hyper-Nova"
        ;;
    4|[Gg]ame-[Nn]ova)
        PROFILE="Game-Nova"
        ;;
    1|[Cc]ore|"")
        PROFILE="Core"
        ;;
    *)
        # If you type a custom name directly
        PROFILE=$SELECTION
        ;;
esac

echo ""
echo "=== Building Neo Linux Profile: $PROFILE ==="
echo ""

# Clean old builds safely
rm -rf ./out

# Run KIWI with the chosen profile
kiwi-ng --kiwi-file ./Neo.kiwi \
        --shared-cache-dir ./cache \
        --profile="$PROFILE" \
        --debug system build \
        --description ./ \
        --target-dir ./out
