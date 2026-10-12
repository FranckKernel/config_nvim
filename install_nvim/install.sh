#!/usr/bin/env bash
set -euo pipefail

BASE="https://github.com/neovim/neovim/releases/latest/download"
DEST="$HOME/.local/bin/nvim"

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
mkdir -p "$DEST"
tar -xzf "$tmp/nvim.tar.gz" -C "$DEST" --strip-components=1

# The binary is at $DEST/bin/nvim, so that folder must be on PATH
BIN="$DEST/bin"
LINE="export PATH=\"$BIN:\$PATH\""
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
	if [[ -f "$rc" ]] && ! grep -qF "$BIN" "$rc"; then
		echo "$LINE" >>"$rc"
	fi
done
if command -v fish >/dev/null; then
	fish -c "fish_add_path $BIN"
fi

"$BIN/nvim" --version | head -1
echo "Open a new shell (or run: hash -r) so 'nvim' resolves to this version."
