# rioliu/homebrew-tap

Homebrew tap for tools by rioliu.

```bash
brew install rioliu/tap/dbq
```

## Available formulae

| formula | source |
|---|---|
| `dbq` | https://github.com/rioliu/dbq |

## Maintenance

`scripts/bump.sh <tool>` rewrites `Formula/<tool>.rb` to the latest GitHub
release (version, URLs, sha256 from the release's `checksums.txt`). The
`Sync formulae` workflow runs it daily and commits when something changed.
To onboard a new tool: add `Formula/<tool>.rb` and one `bump.sh` line in
`.github/workflows/sync.yml`.
