#!/usr/bin/env bash
set -euo pipefail

BASE="https://github.com/neovim/neovim/releases/latest/download"
DEST="$HOME/.local/bin/nvimd"
LINK="$HOME/.local/bin/nvim"

# Already installed? Make sure the link exists, then stop.
if [[ -x "$DEST/bin/nvim" ]]; then
	echo "Neovim already installed in $DEST, skipping download."
	mkdir -p "$(dirname "$LINK")"
	ln -sf "$DEST/bin/nvim" "$LINK"
	"$DEST/bin/nvim" --version | head -1
	exit 0
fi

case "$(uname -m)" in
aarch64 | arm64) asset="nvim-linux-arm64.tar.gz" ;;
x86_64) asset="nvim-linux-x86_64.tar.gz" ;;
*)
	echo "Unsupported architecture: $(uname -m)"
	echo "Official Neovim binaries only exist for 64-bit ARM and x86_64."
	echo "On 32-bit, build from source: https://github.com/neovim/neovim"
	exit 1
	;;
esac

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Downloading latest $asset..."
curl -fsSL "$BASE/$asset" -o "$tmp/nvim.tar.gz"

rm -rf "$DEST"
mkdir -p "$DEST" "$(dirname "$LINK")"
tar -xzf "$tmp/nvim.tar.gz" -C "$DEST" --strip-components=1

# Symlink into ~/.local/bin (no rc file edits)
ln -sf "$DEST/bin/nvim" "$LINK"

"$DEST/bin/nvim" --version | head -1
echo "Linked $LINK -> $DEST/bin/nvim"
