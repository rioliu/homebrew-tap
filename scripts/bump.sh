#!/usr/bin/env bash
# Bump Formula/<tool>.rb to the latest GitHub release of <owner/repo>.
#
# Usage: bump.sh <tool> [<owner/repo>]     (repo defaults to rioliu/<tool>)
#
# Only edits the formula; committing is left to the caller (sync workflow).
# Reads the release's checksums.txt asset so sha256 values stay correct
# for every platform the formula references.
set -euo pipefail

tool="${1:?usage: bump.sh <tool> [<owner/repo>]}"
repo="${2:-rioliu/$tool}"
formula="Formula/${tool}.rb"

if [ ! -f "$formula" ]; then
    echo "ERROR: no formula at $formula" >&2
    exit 1
fi

api="https://api.github.com/repos/${repo}/releases/latest"
release_json="$(curl -fsSL "$api")"
tag="$(echo "$release_json" | jq -r .tag_name)"
ver="${tag#v}"
if [ -z "$ver" ] || [ "$ver" = "null" ]; then
    echo "ERROR: no release found for $repo" >&2
    exit 1
fi

current="$(sed -n 's/^  version "\(.*\)"$/\1/p' "$formula")"
if [ "$current" = "$ver" ]; then
    echo "$tool: formula already at $ver"
    exit 0
fi

checksums_url="$(echo "$release_json" | jq -r \
    '.assets[] | select(.name == "checksums.txt") | .browser_download_url')"
if [ -z "$checksums_url" ] || [ "$checksums_url" = "null" ]; then
    echo "ERROR: release $tag has no checksums.txt asset" >&2
    exit 1
fi
sums_file="$(mktemp)"
tmp="$(mktemp)"
out="$(mktemp)"
trap 'rm -f "$sums_file" "$tmp" "$out"' EXIT
curl -fsSL "$checksums_url" > "$sums_file"

# 1. version line, 2. release tag inside every download url path,
# 3. version inside the asset file name (dbq_v0.2.1_... -> dbq_v0.2.2_...)
sed -e "s/^  version \".*\"$/  version \"${ver}\"/" \
    -e "s|/download/v[^/]*/|/download/v${ver}/|" \
    -e "s|${tool}_v${current}|${tool}_v${ver}|g" \
    "$formula" > "$tmp"

# 3. sha256 following each url line, looked up by the asset's file name
awk -v sums="$sums_file" '
    BEGIN {
        while ((getline line < sums) > 0) {
            split(line, p, /[ \t]+/)
            sha[p[2]] = p[1]
        }
    }
    /url "https:/ {
        n = split($0, part, "/")
        file = part[n]
        sub(/"$/, "", file)
        pending = 1
        print
        next
    }
    pending && /sha256 "/ {
        if (!(file in sha)) {
            printf "ERROR: no checksum for %s in checksums.txt\n", file > "/dev/stderr"
            exit 1
        }
        sub(/sha256 ".*"/, "sha256 \"" sha[file] "\"", $0)
        pending = 0
    }
    { print }
' "$tmp" > "$out"

# only overwrite the formula after a fully successful rewrite, so a
# mid-awk failure (missing checksum) cannot leave a truncated file
mv "$out" "$formula"

echo "$tool: bumped $current -> $ver"
