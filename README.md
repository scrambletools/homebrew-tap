# Scramble Tools' Homebrew tap

Homebrew casks for the Scramble Tools apps, each installing the signed and
notarized macOS build from the app's own GitHub release.

| App | What it is | Install |
|---|---|---|
| [prev](https://prev.run) | View, mark up and sign PDFs and images | `brew install --cask scrambletools/tap/prev` |

Installing by the full name, as above, also tells Homebrew to trust that
cask from this tap. `brew upgrade` keeps each app current: once a day, a
workflow here moves every cask to its app's latest release, with the new
checksums.

## Adding an app

Add `Casks/NAME.rb`, installing the app's release from GitHub, with a
`livecheck` block using `strategy :github_latest`, so the daily update
finds new releases. A pull request is checked by `brew audit` and
`brew style`, and the cask is installed and uninstalled on macOS.
