#!/usr/bin/env bash
set -euo pipefail

release=${1:?Missing release identifier}
[[ "$release" =~ ^[a-f0-9]{40}-[0-9]+-[0-9]+$ ]] || { echo 'Invalid release identifier'; exit 1; }
root="$HOME/public_html"
work="$HOME/kesno-deploy"
backup="$HOME/kesno-backups"
archive="$work/incoming/$release.tar.gz"
stage="$work/releases/$release"

test -d "$root"
test -w "$root"
test -s "$archive"
command -v rsync > /dev/null
mkdir -p "$stage" "$backup"
chmod 700 "$backup"
tar -xzf "$archive" -C "$stage"
for page in index about clients contact services team; do
  test -s "$stage/$page.html"
done
for assets in css js images; do
  test -d "$stage/$assets"
done

# Preserve the complete live root before replacing any website files.
umask 077
tar -czf "$backup/$release.tar.gz" -C "$root" .
chmod 600 "$backup/$release.tar.gz"
umask 022

# Stage contains only the six pages and their asset folders. No deletion.
rsync -rl --chmod=D755,F644 "$stage/" "$root/"
for page in index about clients contact services team; do
  cmp "$stage/$page.html" "$root/$page.html"
done
printf '%s\n' "$release" > "$work/last-successful-copy"
printf 'Website copied. Backup: %s\n' "$backup/$release.tar.gz"
