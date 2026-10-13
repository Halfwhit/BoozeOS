#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG="$SCRIPT_DIR/build.log"

echo "=== Booze OS Build Script ===" | tee "$LOG"
echo "Started: $(date)" | tee -a "$LOG"
echo "" | tee -a "$LOG"

# Install archiso if needed
if ! pacman -Qi archiso &>/dev/null; then
    echo ">>> Installing archiso..." | tee -a "$LOG"
    pacman -S --noconfirm archiso 2>&1 | tee -a "$LOG"
else
    echo ">>> archiso already installed" | tee -a "$LOG"
fi

echo ">>> Starting ISO build..." | tee -a "$LOG"
echo "" | tee -a "$LOG"

cd "$SCRIPT_DIR"
bash buildiso.sh 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo "=== Build complete: $(date) ===" | tee -a "$LOG"
echo "ISO location: $SCRIPT_DIR/out/"
ls -lh "$SCRIPT_DIR/out/"
